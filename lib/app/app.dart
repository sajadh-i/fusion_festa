import 'package:fusion_festa/services/auth_service.dart';
import 'package:fusion_festa/services/cloudinary_service.dart';
import 'package:fusion_festa/services/security_prefes.dart';
import 'package:fusion_festa/ui/screens/Navbar/navbar_view.dart';
import 'package:fusion_festa/ui/screens/add_event/add_event_view.dart';
import 'package:fusion_festa/ui/screens/bookingdetails/booking_details_view.dart';
import 'package:fusion_festa/ui/screens/edit_profile/edit_profile_view.dart';
import 'package:fusion_festa/ui/screens/event_screen/event_screen_view.dart';
import 'package:fusion_festa/ui/screens/forgot_password/for_pass_view.dart';
import 'package:fusion_festa/ui/screens/helpSupport/helpsupport_view.dart';
import 'package:fusion_festa/ui/screens/home_screen/home_screen_view.dart';
import 'package:fusion_festa/ui/screens/login/login_view.dart';
import 'package:fusion_festa/ui/screens/onboarding/onboardingview.dart';
import 'package:fusion_festa/ui/screens/passwordsecurity/passwordsecurityview.dart';
import 'package:fusion_festa/ui/screens/profile/profile_view.dart';
import 'package:fusion_festa/ui/screens/settings/setting_view.dart';
import 'package:fusion_festa/ui/screens/sign_up/sign_up_view.dart';
import 'package:fusion_festa/ui/screens/splash/splashview.dart';
import 'package:local_auth/local_auth.dart';
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
    MaterialRoute(page: AddEventView),
    MaterialRoute(page: EditProfileView),
    MaterialRoute(page: PasswordSecurityView),
    MaterialRoute(page: HelpsupportView),
  ],
  dependencies: [
    LazySingleton(classType: ApiService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: LocalAuthentication),
    LazySingleton(classType: SecurityPrefs),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: CloudinaryService),
    LazySingleton(classType: AuthService),
  ],
)
class AppSetUp {}
