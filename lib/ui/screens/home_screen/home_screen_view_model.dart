import 'package:stacked/stacked.dart';

class HomeScreenViewModel extends BaseViewModel {
  bool showHeroText = false; // controls animation

  void initialise() {
    // call this from onModelReady in the View
    Future.delayed(const Duration(milliseconds: 200), () {
      showHeroText = true;
      notifyListeners();
    });
  }

  void hideHeroText() {
    showHeroText = false;
    notifyListeners();
  }

  void tapsetteing() {
    // settings navigation
  }

  void onGetStarted() {
    // your existing navigation
  }
}
