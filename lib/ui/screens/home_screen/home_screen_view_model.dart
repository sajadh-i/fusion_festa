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
  DateTime selectedDay = DateTime.now();
  List<QueryDocumentSnapshot> selectedEvents = [];

  TextEditingController reviewcontroller = TextEditingController();

  StreamSubscription? _eventSub;
  StreamSubscription? _reviewSub;

  void initialise() {
    _eventSub = homeservice.approvedEvents().listen((snapshot) {
      events = snapshot.docs;
      selectDate(selectedDay);
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

  void selectDate(DateTime day) {
    selectedDay = day;

    selectedEvents = events.where((e) {
      final date = (e['startAt'] as Timestamp).toDate();
      return date.year == day.year &&
          date.month == day.month &&
          date.day == day.day;
    }).toList();

    notifyListeners();
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
