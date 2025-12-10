import 'package:fusion_festa/constants/assets.gen.dart';
import 'package:fusion_festa/models/onboardingitems.dart';
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

  void onNext() {
    if (!isLastPage) {
      currentIndex++;
      notifyListeners();
    } else {
      _goToLogin();
    }
  }

  void onSkip() {
    _goToLogin();
  }

  void _goToLogin() {
    // TODO: use your navigationService & route
    // navigationService.replaceWith(Routes.loginView);
  }
}
