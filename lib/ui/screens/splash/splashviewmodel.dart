import 'package:fusion_festa/app/app.router.dart';
import 'package:fusion_festa/app/utils.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel {
  init() {
    // code to navigate to  next screen
    Future.delayed(Duration(seconds: 3), () {
      //navigationService.navigateTo(Routes.loginview);
      // navigationService.pushNamedAndRemoveUntil(Routes.loginview);
    });
  }
}
