import 'package:fusion_festa/services/Ticket_pdf_service.dart';
import 'package:fusion_festa/services/admin_service.dart';
//import 'package:fusion_festa/services/api_services.dart';
import 'package:fusion_festa/services/auth_service.dart';
import 'package:fusion_festa/services/booking_service.dart';
import 'package:fusion_festa/services/cloudinary_service.dart';
import 'package:fusion_festa/services/event_service.dart';
import 'package:fusion_festa/services/home_service.dart';
import 'package:fusion_festa/services/local_notification_service.dart';
import 'package:fusion_festa/services/security_prefes.dart';
import 'package:fusion_festa/services/user_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';

NavigationService get navigationService => locator<NavigationService>();
//ApiService get apiservice => locator<ApiService>();
LocalAuthentication get lockauth => locator<LocalAuthentication>();
SecurityPrefs get securitypref => locator<SecurityPrefs>();
DialogService get dialogService => locator<DialogService>();
CloudinaryService get cloudinaryservice => locator<CloudinaryService>();
UserService get userservice => locator<UserService>();
AuthService get authservice => locator<AuthService>();
EventService get eventservice => locator<EventService>();
BookingService get bookingservice => locator<BookingService>();
TicketPdfService get pdfservice => locator<TicketPdfService>();
LocalNotificationService get localnotificationservice =>
    locator<LocalNotificationService>();
AdminService get adminservice => locator<AdminService>();
HomeService get homeservice => locator<HomeService>();
