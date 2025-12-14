import 'package:fusion_festa/ui/screens/Navbar/navbar_view.dart';
import 'package:fusion_festa/ui/screens/bookingdetails/booking_details_view.dart';
import 'package:fusion_festa/ui/screens/event_screen/event_screen_view.dart';
import 'package:fusion_festa/ui/screens/forgot_password/for_pass_view.dart';
import 'package:fusion_festa/ui/screens/home_screen/home_screen_view.dart';
import 'package:fusion_festa/ui/screens/login/login_view.dart';
import 'package:fusion_festa/ui/screens/onboarding/onboardingview.dart';
import 'package:fusion_festa/ui/screens/profile/profile_view.dart';
import 'package:fusion_festa/ui/screens/settings/setting_view.dart';
import 'package:fusion_festa/ui/screens/sign_up/sign_up_view.dart';
import 'package:fusion_festa/ui/screens/splash/splashview.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/api_services.dart';
import '../services/user_service.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: Splashview, initial: true),
    MaterialRoute(page: Onboardingview),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: ForPassView),
    MaterialRoute(page: SignUpView),
    MaterialRoute(page: HomeScreenView),
    MaterialRoute(page: EventScreenView),
    MaterialRoute(page: NavbarView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: BookingDetailsView),
    MaterialRoute(page: SettingView),
  ],
  dependencies: [
    LazySingleton(classType: ApiService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: UserService),
  ],
)
class AppSetUp {}
