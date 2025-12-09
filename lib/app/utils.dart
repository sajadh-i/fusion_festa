import 'package:fusion_festa/services/api_services.dart';
import 'package:fusion_festa/services/user_service.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';

NavigationService get navigationService => locator<NavigationService>();
ApiService get apiservice => locator<ApiService>();
