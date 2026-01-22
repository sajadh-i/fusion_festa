import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fusion_festa/app/app.router.dart';
import 'package:fusion_festa/app/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class HomeScreenViewModel extends BaseViewModel {
  List<QueryDocumentSnapshot> events = [];
  List<QueryDocumentSnapshot> reviews = [];
  DateTime selectedDay = DateTime.now();
  List<QueryDocumentSnapshot> selectedEvents = [];
  File? selectedImage;
  final picker = ImagePicker();
  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      selectedImage = File(picked.path);
      notifyListeners();
    }
  }

  TextEditingController reviewcontroller = TextEditingController();

  StreamSubscription? _eventSub;
  StreamSubscription? _reviewSub;

  List<String> carouselImages = [
    'assets/images/car8.jpeg',
    'assets/images/car6.jpeg',
    'assets/images/car7.jpeg',
  ];

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
    if (text.isEmpty && selectedImage == null) return;

    final uid = FirebaseAuth.instance.currentUser!.uid;

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    final userName = userDoc.data()?['name'] ?? 'User';

    String? imageUrl;

    if (selectedImage != null) {
      imageUrl = await cloudinaryservice.uploadImage(selectedImage!);
    }

    await homeservice.addReview(
      userId: uid,
      userName: userName,
      text: text,
      imageUrl: imageUrl,
    );

    reviewcontroller.clear();
    selectedImage = null;
    notifyListeners();
  }

  Future<void> deleteReview(String id) async {
    await homeservice.deleteReview(id);
  }

  Future<void> toggleLike(String id, bool isLiked) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await homeservice.toggleLike(id, uid, isLiked);
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
