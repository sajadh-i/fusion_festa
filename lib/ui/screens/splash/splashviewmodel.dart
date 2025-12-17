import 'package:flutter/material.dart';
import 'package:fusion_festa/app/app.router.dart';
import 'package:fusion_festa/app/utils.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;

  double get animationProgress => controller.value;

  // Call this from the view, and pass the vsync (TickerProvider)
  void init(TickerProvider vsync) {
    _setupAnimations(vsync);
    controller.forward();
    _navigateNext();
  }

  void _setupAnimations(TickerProvider vsync) {
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 2000),
    );

    scaleAnimation = Tween(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));

    fadeAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
  }

  void _navigateNext() {
    Future.delayed(const Duration(seconds: 5), () async {
      // TODO: use your navigationService here
      // navigationService.navigateTo(Routes.loginview);
      final isLockEnabled = await securitypref.getSystemLock();

      if (isLockEnabled) {
        final didAuth = await lockauth.authenticate(
          localizedReason: 'Unlock Fusion Festa',
          biometricOnly: false,
        );

        if (!didAuth) {
          // User failed auth → stay on splash
          return;
        }
      }
      navigationService.pushNamedAndRemoveUntil(Routes.onboardingview);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
