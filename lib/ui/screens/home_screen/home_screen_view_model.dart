import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fusion_festa/app/app.router.dart';
import 'package:fusion_festa/app/utils.dart';
import 'package:stacked/stacked.dart';

class HomeScreenViewModel extends BaseViewModel {
  List<QueryDocumentSnapshot> events = [];
  List<QueryDocumentSnapshot> reviews = [];

  TextEditingController reviewcontroller = TextEditingController();

  StreamSubscription? _eventSub;
  StreamSubscription? _reviewSub;

  void initialise() {
    _eventSub = homeservice.approvedEvents().listen((snapshot) {
      events = snapshot.docs;
      notifyListeners();
    });

    _reviewSub = homeservice.liveReviews().listen((snapshot) {
      reviews = snapshot.docs;
      notifyListeners();
    });
  }

  Future<void> submitReview() async {
    final text = reviewcontroller.text.trim();
    if (text.isEmpty) return;

    final uid = FirebaseAuth.instance.currentUser!.uid;

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    final userName = userDoc.data()?['name'] ?? 'User';

    await homeservice.addReview(userName, text);

    reviewcontroller.clear();
  }

  void addevent() {
    navigationService.navigateTo(Routes.addEventView);
  }

  @override
  void dispose() {
    _eventSub?.cancel();
    _reviewSub?.cancel();
    reviewcontroller.dispose();
    super.dispose();
  }
}
