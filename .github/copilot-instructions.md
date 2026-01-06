# Copilot / AI Agent Instructions for fusion_festa

Keep guidance concise and action-focused — the goal is to make an AI coding agent productive immediately.

1. Project overview
- Flutter mobile app using the `stacked` MVVM pattern. Entry point: [lib/main.dart](lib/main.dart#L1).
- Dependency injection via generated locator: [lib/app/app.locator.dart](lib/app/app.locator.dart). Routes are generated in [lib/app/app.router.dart](lib/app/app.router.dart).
- Uses Firebase (core, auth, firestore, storage). Configuration: [lib/firebase_options.dart](lib/firebase_options.dart) and platform google-services files under `android/app`.

2. Key directories and responsibilities
- `lib/services/`: app service layer (auth_service.dart, user_service.dart, event_service.dart, booking_service.dart, cloudinary_service.dart, etc.). Prefer adding new cross-cutting logic here.
- `lib/models/`: data models used across the app.
- `lib/ui/screens/`: screens follow View + ViewModel pattern (stacked). Example ViewModel: [lib/ui/screens/profile/profile_view_model.dart](lib/ui/screens/profile/profile_view_model.dart).
- `lib/app/`: generated routing and locator wiring. Do not hand-edit generated files; update annotations and run `build_runner`.

3. Coding & patterns to follow
- Use the `stacked` pattern: Views are lightweight, business logic lives in `*ViewModel` classes. Use `notifyListeners()` only inside ViewModels.
- Register and consume services via the locator (`setupLocator()` in [lib/main.dart](lib/main.dart#L1)). Inject services into ViewModels via constructor or locator() calls depending on existing patterns.
- For async side-effects (API, Firebase): services under `lib/services/` return domain models (from `lib/models/`) not raw Maps.
- Generated code: run `flutter pub run build_runner build --delete-conflicting-outputs` when changing annotations (routes, locator, json_serializable, etc.).

4. Build / test / debug
- Typical local dev: `flutter run` or launch via IDE. Entry is `lib/main.dart`.
- Firebase initialization is synchronous in `main()` using `DefaultFirebaseOptions.currentPlatform`; ensure `lib/firebase_options.dart` is present for the target platform.
- To regenerate DI/routing: `flutter pub run build_runner build --delete-conflicting-outputs`.

5. Integration points & external services
- Firebase: cloud_firestore, firebase_auth, firebase_storage. Look for Firestore usage in `lib/services/*.dart`.
- Third-party integrations: Cloudinary (`cloudinary_service.dart`), Razorpay (`razorpay_flutter`), and local notifications (`local_notification_service.dart`). Be careful with platform-specific initialization.

6. Common pitfalls & repo-specific notes
- Do not edit generated files under `lib/gen/` or `lib/app/*.g.dart` — change source annotations and re-run build_runner.
- `stacked_services` is used for navigation; `MaterialApp` uses `StackedRouter().onGenerateRoute` and `StackedService.navigatorKey` in `lib/main.dart`.
- UI scaling uses `lib/ui/tools/screen_size.dart` and a custom `TextScaler` in `main.dart` — preserve these when refactoring layouts.

7. Quick examples
- Add a service: create `lib/services/new_service.dart`, register it in the locator annotations, then run build_runner to generate registration.
- Add a route: add a view and annotate with stacked_route (per existing examples), then run build_runner and use `navigationService.navigateTo(Routes.newView)`.

8. When you need more info
- If a task requires runtime verification (device, emulator, or Firebase console), request permission to run commands locally or ask the maintainer for credentials/config files.

If any section is unclear or you need more specific examples (tests, CI, or a particular ViewModel), tell me which area to expand.
