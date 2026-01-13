// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:local_auth/src/local_auth.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/Ticket_pdf_service.dart';
import '../services/admin_service.dart';
import '../services/api_services.dart';
import '../services/auth_service.dart';
import '../services/booking_service.dart';
import '../services/cloudinary_service.dart';
import '../services/event_service.dart';
import '../services/home_service.dart';
import '../services/local_notification_service.dart';
import '../services/security_prefes.dart';
import '../services/user_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
  // Register environments
  locator.registerEnvironment(
    environment: environment,
    environmentFilter: environmentFilter,
  );

  // Register dependencies
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => LocalAuthentication());
  locator.registerLazySingleton(() => SecurityPrefs());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => CloudinaryService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => EventService());
  locator.registerLazySingleton(() => BookingService());
  locator.registerLazySingleton(() => TicketPdfService());
  locator.registerLazySingleton(() => LocalNotificationService());
  locator.registerLazySingleton(() => AdminService());
  locator.registerLazySingleton(() => HomeService());
}
