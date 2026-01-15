// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i22;
import 'package:flutter/material.dart';
import 'package:fusion_festa/ui/screens/add_event/add_event_view.dart' as _i11;
import 'package:fusion_festa/ui/screens/admin_screen/admin_view.dart' as _i19;
import 'package:fusion_festa/ui/screens/AI_chat/ai_chat_view.dart' as _i20;
import 'package:fusion_festa/ui/screens/booking_confirmation/booking_confirmation_view.dart'
    as _i18;
import 'package:fusion_festa/ui/screens/edit_profile/edit_profile_view.dart'
    as _i12;
import 'package:fusion_festa/ui/screens/event_details/eventdetails_view.dart'
    as _i15;
import 'package:fusion_festa/ui/screens/event_screen/event_screen_view.dart'
    as _i8;
import 'package:fusion_festa/ui/screens/forgot_password/for_pass_view.dart'
    as _i5;
import 'package:fusion_festa/ui/screens/helpSupport/helpsupport_view.dart'
    as _i14;
import 'package:fusion_festa/ui/screens/home_screen/home_screen_view.dart'
    as _i7;
import 'package:fusion_festa/ui/screens/login/login_view.dart' as _i4;
import 'package:fusion_festa/ui/screens/My_booking/booking_det_view.dart'
    as _i21;
import 'package:fusion_festa/ui/screens/my_event_screen/my_event_view.dart'
    as _i16;
import 'package:fusion_festa/ui/screens/Navbar/navbar_view.dart' as _i9;
import 'package:fusion_festa/ui/screens/onboarding/onboardingview.dart' as _i3;
import 'package:fusion_festa/ui/screens/passwordsecurity/passwordsecurityview.dart'
    as _i13;
import 'package:fusion_festa/ui/screens/profile/profile_view.dart' as _i10;
import 'package:fusion_festa/ui/screens/sign_up/sign_up_view.dart' as _i6;
import 'package:fusion_festa/ui/screens/splash/splashview.dart' as _i2;
import 'package:fusion_festa/ui/screens/ticketselectionScreen/ticketselection_view.dart'
    as _i17;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i23;

class Routes {
  static const splashview = '/';

  static const onboardingview = '/Onboardingview';

  static const loginView = '/login-view';

  static const forPassView = '/for-pass-view';

  static const signUpView = '/sign-up-view';

  static const homeScreenView = '/home-screen-view';

  static const eventScreenView = '/event-screen-view';

  static const navbarView = '/navbar-view';

  static const profileView = '/profile-view';

  static const addEventView = '/add-event-view';

  static const editProfileView = '/edit-profile-view';

  static const passwordSecurityView = '/password-security-view';

  static const helpsupportView = '/helpsupport-view';

  static const eventdetailsView = '/eventdetails-view';

  static const myEventView = '/my-event-view';

  static const ticketselectionView = '/ticketselection-view';

  static const bookingConfirmationView = '/booking-confirmation-view';

  static const adminView = '/admin-view';

  static const aiChatView = '/ai-chat-view';

  static const bookingDetView = '/booking-det-view';

  static const all = <String>{
    splashview,
    onboardingview,
    loginView,
    forPassView,
    signUpView,
    homeScreenView,
    eventScreenView,
    navbarView,
    profileView,
    addEventView,
    editProfileView,
    passwordSecurityView,
    helpsupportView,
    eventdetailsView,
    myEventView,
    ticketselectionView,
    bookingConfirmationView,
    adminView,
    aiChatView,
    bookingDetView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(Routes.splashview, page: _i2.Splashview),
    _i1.RouteDef(Routes.onboardingview, page: _i3.Onboardingview),
    _i1.RouteDef(Routes.loginView, page: _i4.LoginView),
    _i1.RouteDef(Routes.forPassView, page: _i5.ForPassView),
    _i1.RouteDef(Routes.signUpView, page: _i6.SignUpView),
    _i1.RouteDef(Routes.homeScreenView, page: _i7.HomeScreenView),
    _i1.RouteDef(Routes.eventScreenView, page: _i8.EventScreenView),
    _i1.RouteDef(Routes.navbarView, page: _i9.NavbarView),
    _i1.RouteDef(Routes.profileView, page: _i10.ProfileView),
    _i1.RouteDef(Routes.addEventView, page: _i11.AddEventView),
    _i1.RouteDef(Routes.editProfileView, page: _i12.EditProfileView),
    _i1.RouteDef(Routes.passwordSecurityView, page: _i13.PasswordSecurityView),
    _i1.RouteDef(Routes.helpsupportView, page: _i14.HelpsupportView),
    _i1.RouteDef(Routes.eventdetailsView, page: _i15.EventdetailsView),
    _i1.RouteDef(Routes.myEventView, page: _i16.MyEventView),
    _i1.RouteDef(Routes.ticketselectionView, page: _i17.TicketselectionView),
    _i1.RouteDef(
      Routes.bookingConfirmationView,
      page: _i18.BookingConfirmationView,
    ),
    _i1.RouteDef(Routes.adminView, page: _i19.AdminView),
    _i1.RouteDef(Routes.aiChatView, page: _i20.AiChatView),
    _i1.RouteDef(Routes.bookingDetView, page: _i21.BookingDetView),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.Splashview: (data) {
      final args = data.getArgs<SplashviewArguments>(
        orElse: () => const SplashviewArguments(),
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.Splashview(key: args.key),
        settings: data,
      );
    },
    _i3.Onboardingview: (data) {
      final args = data.getArgs<OnboardingviewArguments>(
        orElse: () => const OnboardingviewArguments(),
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.Onboardingview(key: args.key),
        settings: data,
      );
    },
    _i4.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.LoginView(key: args.key),
        settings: data,
      );
    },
    _i5.ForPassView: (data) {
      final args = data.getArgs<ForPassViewArguments>(
        orElse: () => const ForPassViewArguments(),
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.ForPassView(key: args.key),
        settings: data,
      );
    },
    _i6.SignUpView: (data) {
      final args = data.getArgs<SignUpViewArguments>(
        orElse: () => const SignUpViewArguments(),
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.SignUpView(key: args.key),
        settings: data,
      );
    },
    _i7.HomeScreenView: (data) {
      final args = data.getArgs<HomeScreenViewArguments>(
        orElse: () => const HomeScreenViewArguments(),
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i7.HomeScreenView(key: args.key, onGoToEvents: args.onGoToEvents),
        settings: data,
      );
    },
    _i8.EventScreenView: (data) {
      final args = data.getArgs<EventScreenViewArguments>(
        orElse: () => const EventScreenViewArguments(),
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.EventScreenView(key: args.key),
        settings: data,
      );
    },
    _i9.NavbarView: (data) {
      final args = data.getArgs<NavbarViewArguments>(
        orElse: () => const NavbarViewArguments(),
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.NavbarView(key: args.key),
        settings: data,
      );
    },
    _i10.ProfileView: (data) {
      final args = data.getArgs<ProfileViewArguments>(
        orElse: () => const ProfileViewArguments(),
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.ProfileView(key: args.key),
        settings: data,
      );
    },
    _i11.AddEventView: (data) {
      final args = data.getArgs<AddEventViewArguments>(
        orElse: () => const AddEventViewArguments(),
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.AddEventView(key: args.key),
        settings: data,
      );
    },
    _i12.EditProfileView: (data) {
      final args = data.getArgs<EditProfileViewArguments>(
        orElse: () => const EditProfileViewArguments(),
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.EditProfileView(key: args.key),
        settings: data,
      );
    },
    _i13.PasswordSecurityView: (data) {
      final args = data.getArgs<PasswordSecurityViewArguments>(
        orElse: () => const PasswordSecurityViewArguments(),
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i13.PasswordSecurityView(key: args.key),
        settings: data,
      );
    },
    _i14.HelpsupportView: (data) {
      final args = data.getArgs<HelpsupportViewArguments>(
        orElse: () => const HelpsupportViewArguments(),
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i14.HelpsupportView(key: args.key),
        settings: data,
      );
    },
    _i15.EventdetailsView: (data) {
      final args = data.getArgs<EventdetailsViewArguments>(nullOk: false);
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i15.EventdetailsView(key: args.key, eventId: args.eventId),
        settings: data,
      );
    },
    _i16.MyEventView: (data) {
      final args = data.getArgs<MyEventViewArguments>(
        orElse: () => const MyEventViewArguments(),
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i16.MyEventView(key: args.key),
        settings: data,
      );
    },
    _i17.TicketselectionView: (data) {
      final args = data.getArgs<TicketselectionViewArguments>(nullOk: false);
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i17.TicketselectionView(key: args.key, eventId: args.eventId),
        settings: data,
      );
    },
    _i18.BookingConfirmationView: (data) {
      final args = data.getArgs<BookingConfirmationViewArguments>(
        nullOk: false,
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i18.BookingConfirmationView(
          key: args.key,
          bookingId: args.bookingId,
          eventTitle: args.eventTitle,
          venue: args.venue,
          startAt: args.startAt,
          endAt: args.endAt,
          totalPaid: args.totalPaid,
          userId: args.userId,
          bookedTickets: args.bookedTickets,
        ),
        settings: data,
      );
    },
    _i19.AdminView: (data) {
      final args = data.getArgs<AdminViewArguments>(
        orElse: () => const AdminViewArguments(),
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i19.AdminView(key: args.key),
        settings: data,
      );
    },
    _i20.AiChatView: (data) {
      final args = data.getArgs<AiChatViewArguments>(
        orElse: () => const AiChatViewArguments(),
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i20.AiChatView(key: args.key),
        settings: data,
      );
    },
    _i21.BookingDetView: (data) {
      final args = data.getArgs<BookingDetViewArguments>(
        orElse: () => const BookingDetViewArguments(),
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i21.BookingDetView(key: args.key),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class SplashviewArguments {
  const SplashviewArguments({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant SplashviewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class OnboardingviewArguments {
  const OnboardingviewArguments({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant OnboardingviewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class LoginViewArguments {
  const LoginViewArguments({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant LoginViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ForPassViewArguments {
  const ForPassViewArguments({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ForPassViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class SignUpViewArguments {
  const SignUpViewArguments({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant SignUpViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class HomeScreenViewArguments {
  const HomeScreenViewArguments({this.key, this.onGoToEvents});

  final _i22.Key? key;

  final void Function()? onGoToEvents;

  @override
  String toString() {
    return '{"key": "$key", "onGoToEvents": "$onGoToEvents"}';
  }

  @override
  bool operator ==(covariant HomeScreenViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.onGoToEvents == onGoToEvents;
  }

  @override
  int get hashCode {
    return key.hashCode ^ onGoToEvents.hashCode;
  }
}

class EventScreenViewArguments {
  const EventScreenViewArguments({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant EventScreenViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class NavbarViewArguments {
  const NavbarViewArguments({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant NavbarViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ProfileViewArguments {
  const ProfileViewArguments({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class AddEventViewArguments {
  const AddEventViewArguments({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant AddEventViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class EditProfileViewArguments {
  const EditProfileViewArguments({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant EditProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class PasswordSecurityViewArguments {
  const PasswordSecurityViewArguments({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant PasswordSecurityViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class HelpsupportViewArguments {
  const HelpsupportViewArguments({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant HelpsupportViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class EventdetailsViewArguments {
  const EventdetailsViewArguments({this.key, required this.eventId});

  final _i22.Key? key;

  final String eventId;

  @override
  String toString() {
    return '{"key": "$key", "eventId": "$eventId"}';
  }

  @override
  bool operator ==(covariant EventdetailsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.eventId == eventId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ eventId.hashCode;
  }
}

class MyEventViewArguments {
  const MyEventViewArguments({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant MyEventViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class TicketselectionViewArguments {
  const TicketselectionViewArguments({this.key, required this.eventId});

  final _i22.Key? key;

  final String eventId;

  @override
  String toString() {
    return '{"key": "$key", "eventId": "$eventId"}';
  }

  @override
  bool operator ==(covariant TicketselectionViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.eventId == eventId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ eventId.hashCode;
  }
}

class BookingConfirmationViewArguments {
  const BookingConfirmationViewArguments({
    this.key,
    required this.bookingId,
    required this.eventTitle,
    required this.venue,
    required this.startAt,
    required this.endAt,
    required this.totalPaid,
    required this.userId,
    required this.bookedTickets,
  });

  final _i22.Key? key;

  final String bookingId;

  final String eventTitle;

  final String venue;

  final DateTime startAt;

  final DateTime endAt;

  final double totalPaid;

  final String userId;

  final List<dynamic> bookedTickets;

  @override
  String toString() {
    return '{"key": "$key", "bookingId": "$bookingId", "eventTitle": "$eventTitle", "venue": "$venue", "startAt": "$startAt", "endAt": "$endAt", "totalPaid": "$totalPaid", "userId": "$userId", "bookedTickets": "$bookedTickets"}';
  }

  @override
  bool operator ==(covariant BookingConfirmationViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.bookingId == bookingId &&
        other.eventTitle == eventTitle &&
        other.venue == venue &&
        other.startAt == startAt &&
        other.endAt == endAt &&
        other.totalPaid == totalPaid &&
        other.userId == userId &&
        other.bookedTickets == bookedTickets;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        bookingId.hashCode ^
        eventTitle.hashCode ^
        venue.hashCode ^
        startAt.hashCode ^
        endAt.hashCode ^
        totalPaid.hashCode ^
        userId.hashCode ^
        bookedTickets.hashCode;
  }
}

class AdminViewArguments {
  const AdminViewArguments({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant AdminViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class AiChatViewArguments {
  const AiChatViewArguments({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant AiChatViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class BookingDetViewArguments {
  const BookingDetViewArguments({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant BookingDetViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

extension NavigatorStateExtension on _i23.NavigationService {
  Future<dynamic> navigateToSplashview({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.splashview,
      arguments: SplashviewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToOnboardingview({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.onboardingview,
      arguments: OnboardingviewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToLoginView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.loginView,
      arguments: LoginViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToForPassView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.forPassView,
      arguments: ForPassViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToSignUpView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.signUpView,
      arguments: SignUpViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToHomeScreenView({
    _i22.Key? key,
    void Function()? onGoToEvents,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.homeScreenView,
      arguments: HomeScreenViewArguments(key: key, onGoToEvents: onGoToEvents),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToEventScreenView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.eventScreenView,
      arguments: EventScreenViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToNavbarView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.navbarView,
      arguments: NavbarViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToProfileView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.profileView,
      arguments: ProfileViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToAddEventView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.addEventView,
      arguments: AddEventViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToEditProfileView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.editProfileView,
      arguments: EditProfileViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToPasswordSecurityView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.passwordSecurityView,
      arguments: PasswordSecurityViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToHelpsupportView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.helpsupportView,
      arguments: HelpsupportViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToEventdetailsView({
    _i22.Key? key,
    required String eventId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.eventdetailsView,
      arguments: EventdetailsViewArguments(key: key, eventId: eventId),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToMyEventView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.myEventView,
      arguments: MyEventViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToTicketselectionView({
    _i22.Key? key,
    required String eventId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.ticketselectionView,
      arguments: TicketselectionViewArguments(key: key, eventId: eventId),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToBookingConfirmationView({
    _i22.Key? key,
    required String bookingId,
    required String eventTitle,
    required String venue,
    required DateTime startAt,
    required DateTime endAt,
    required double totalPaid,
    required String userId,
    required List<dynamic> bookedTickets,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.bookingConfirmationView,
      arguments: BookingConfirmationViewArguments(
        key: key,
        bookingId: bookingId,
        eventTitle: eventTitle,
        venue: venue,
        startAt: startAt,
        endAt: endAt,
        totalPaid: totalPaid,
        userId: userId,
        bookedTickets: bookedTickets,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToAdminView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.adminView,
      arguments: AdminViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToAiChatView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.aiChatView,
      arguments: AiChatViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToBookingDetView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.bookingDetView,
      arguments: BookingDetViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithSplashview({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.splashview,
      arguments: SplashviewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithOnboardingview({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.onboardingview,
      arguments: OnboardingviewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithLoginView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.loginView,
      arguments: LoginViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithForPassView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.forPassView,
      arguments: ForPassViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithSignUpView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.signUpView,
      arguments: SignUpViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithHomeScreenView({
    _i22.Key? key,
    void Function()? onGoToEvents,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.homeScreenView,
      arguments: HomeScreenViewArguments(key: key, onGoToEvents: onGoToEvents),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithEventScreenView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.eventScreenView,
      arguments: EventScreenViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithNavbarView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.navbarView,
      arguments: NavbarViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithProfileView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.profileView,
      arguments: ProfileViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithAddEventView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.addEventView,
      arguments: AddEventViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithEditProfileView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.editProfileView,
      arguments: EditProfileViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithPasswordSecurityView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.passwordSecurityView,
      arguments: PasswordSecurityViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithHelpsupportView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.helpsupportView,
      arguments: HelpsupportViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithEventdetailsView({
    _i22.Key? key,
    required String eventId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.eventdetailsView,
      arguments: EventdetailsViewArguments(key: key, eventId: eventId),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithMyEventView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.myEventView,
      arguments: MyEventViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithTicketselectionView({
    _i22.Key? key,
    required String eventId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.ticketselectionView,
      arguments: TicketselectionViewArguments(key: key, eventId: eventId),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithBookingConfirmationView({
    _i22.Key? key,
    required String bookingId,
    required String eventTitle,
    required String venue,
    required DateTime startAt,
    required DateTime endAt,
    required double totalPaid,
    required String userId,
    required List<dynamic> bookedTickets,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.bookingConfirmationView,
      arguments: BookingConfirmationViewArguments(
        key: key,
        bookingId: bookingId,
        eventTitle: eventTitle,
        venue: venue,
        startAt: startAt,
        endAt: endAt,
        totalPaid: totalPaid,
        userId: userId,
        bookedTickets: bookedTickets,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithAdminView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.adminView,
      arguments: AdminViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithAiChatView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.aiChatView,
      arguments: AiChatViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithBookingDetView({
    _i22.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.bookingDetView,
      arguments: BookingDetViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }
}
