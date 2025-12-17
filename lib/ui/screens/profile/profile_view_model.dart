import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusion_festa/app/app.router.dart';
import 'package:fusion_festa/app/utils.dart';
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

  void loadprofile() {
    final user = FirebaseAuth.instance.currentUser!;
    userEmail = user.email ?? '';

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

  void onMyEventsTap() {}
  void onPaymentMethodsTap() {}
  void onSecurityTap() {
    navigationService.navigateTo(Routes.passwordSecurityView);
  }

  void onNotificationsChanged(bool value) {
    notificationsEnabled = value;
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
      navigationService.replaceWith(Routes.loginView);
    } finally {
      setBusy(false);
    }
  }

  Future<void> onDeleteAccountTap() async {
    setBusy(true);
    try {
      //Delete Firestore user data
      await userservice.deleteUserData();

      //Delete Auth user
      await authservice.deleteAuthAccount();

      //Navigate to login
      navigationService.replaceWith(Routes.loginView);
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
    } finally {
      setBusy(false);
    }
  }
}
