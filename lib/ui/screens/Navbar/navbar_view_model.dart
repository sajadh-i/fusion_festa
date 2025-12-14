import 'package:stacked/stacked.dart';

class NavbarViewModel extends BaseViewModel {
  int currentIndex = 0;

  void onTabChange(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
