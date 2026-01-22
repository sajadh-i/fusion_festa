import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fusion_festa/app/app.router.dart';
import 'package:fusion_festa/app/utils.dart';
import 'package:fusion_festa/constants/assets.gen.dart';
import 'package:fusion_festa/models/onboardingitems.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class Onboardingviewmodel extends BaseViewModel {
  int currentIndex = 0;

  final List<OnboardingItem> items = [
    OnboardingItem(
      image: Assets.images.onboard1,
      title: "Discover Kerala's\nCulture",
      description:
          "Find a wide range of traditional events, from the vibrant storytelling of Kathakali to the divine rituals of Theyyam.",
    ),
    OnboardingItem(
      image: Assets.images.onboard2,
      title: "Experience Festive\nVibes",
      description:
          "Join iconic festivals, boat races, and temple fairs happening across Kerala throughout the year.",
    ),
    OnboardingItem(
      image: Assets.images.onboard3,
      title: "Taste Local\nFlavours",
      description:
          "Explore food festivals and street events that celebrate Kerala's authentic cuisine.",
    ),
  ];

  OnboardingItem get currentItem => items[currentIndex];

  bool get isLastPage => currentIndex == items.length - 1;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final done = prefs.getBool('onboarding_done') ?? false;

    // If already seen onboarding  skip UI
    if (done) {
      _navigateAfterOnboarding();
    }
  }

  void onNext() {
    if (!isLastPage) {
      currentIndex++;
      notifyListeners();
    } else {
      _finishOnboarding();
    }
  }

  void onSkip() {
    _finishOnboarding();
  }

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);

    _navigateAfterOnboarding();
  }

  Future<void> _navigateAfterOnboarding() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Not logged in
      navigationService.replaceWith(Routes.loginView);
      return;
    }

    // Logged in check role
    final role = await userservice.getUserRole(user.uid);

    if (role == 'admin') {
      navigationService.replaceWith(Routes.adminView);
    } else {
      navigationService.replaceWith(Routes.navbarView);
    }
  }
}
