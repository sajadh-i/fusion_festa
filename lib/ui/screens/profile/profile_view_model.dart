import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusion_festa/app/app.router.dart';
import 'package:fusion_festa/app/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  String userName = '';
  String userEmail = '';
  String profileImage = '';
  String phone = '';

  bool notificationsEnabled = true;
  String languageLabel = 'English';
  //LOAD USER DATA
  StreamSubscription<DocumentSnapshot>? _profileSub;

  Future<void> loadprofile() async {
    final user = FirebaseAuth.instance.currentUser!;
    userEmail = user.email ?? '';

    final pref = await SharedPreferences.getInstance();
    notificationsEnabled = pref.getBool('notifications_enabled') ?? true;

    _profileSub = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .listen((doc) {
          if (!doc.exists) return;

          final data = doc.data() as Map<String, dynamic>;

          userName = data['name'] ?? '';
          phone = data['phone'] ?? '';
          profileImage = data['profileImage'] ?? '';

          notifyListeners();
        });
  }

  void onEditProfileTap() {
    navigationService.navigateTo(Routes.editProfileView);
  }

  void onMyEventsTap() {
    navigationService.navigateTo(Routes.myEventView);
  }

  void onPaymentMethodsTap() {}
  void onSecurityTap() {
    navigationService.navigateTo(Routes.passwordSecurityView);
  }

  Future<void> onNotificationsChanged(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    notificationsEnabled = value;
    await prefs.setBool('notifications_enabled', value);

    if (value) {
      await localnotificationservice.init();
      await localnotificationservice.show(
        title: 'Notification Enabled',
        body: 'You will now recieve update',
      );
    }
    notifyListeners();
  }

  void onLanguageTap() {
    // open language bottom sheet
  }

  void onHelpTap() {
    navigationService.navigateTo(Routes.helpsupportView);
  }

  void onTermsTap() {}
  void onPrivacyTap() {}

  Future<void> onLogoutTap() async {
    setBusy(true);
    try {
      await authservice.logout();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('onboarding_done');
      navigationService.clearStackAndShow(Routes.loginView);
    } finally {
      setBusy(false);
    }
  }

  Future<void> onDeleteAccountTap() async {
    final confirm = await dialogService.showConfirmationDialog(
      title: 'Delete Account?',
      description:
          'This will permanently delete your account and all events you created.',
      confirmationTitle: 'Delete',
      cancelTitle: 'Cancel',
    );

    if (confirm?.confirmed != true) return;

    setBusy(true);

    try {
      final user = FirebaseAuth.instance.currentUser!;
      final uid = user.uid;

      //Delete all events created by this user
      await eventservice.deleteEventsByUser(uid);

      //Delete Firestore user document
      await userservice.deleteUserData();

      //Delete Firebase Auth account
      await authservice.deleteAuthAccount();
      //clear on all in shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      //Navigate to login
      navigationService.clearStackAndShow(Routes.loginView);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        dialogService.showDialog(
          title: 'Re-authentication required',
          description: 'Please login again and retry deleting your account.',
        );
      } else {
        dialogService.showDialog(
          title: 'Delete failed',
          description: 'Unable to delete account. Try again.',
        );
      }
    } catch (e) {
      dialogService.showDialog(
        title: 'Error',
        description: 'Something went wrong. Please try again.',
      );
    } finally {
      setBusy(false);
    }
  }
}
