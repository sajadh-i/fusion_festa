import 'package:fusion_festa/app/app.router.dart';
import 'package:fusion_festa/services/security_prefes.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:fusion_festa/app/utils.dart';

class PasswordSecurityViewModel extends BaseViewModel {
  bool systemLockEnabled = false;
  String? systemLockError;

  Future<void> initialise() async {
    systemLockEnabled = await securitypref.getSystemLock();
    notifyListeners();
  }

  Future<void> toggleSystemLock() async {
    systemLockError = null;
    setBusy(true);

    try {
      final didAuth = await lockauth.authenticate(
        localizedReason: systemLockEnabled
            ? 'Confirm to disable system lock'
            : 'Enable system lock for Fusion Festa',
        biometricOnly: false,
      );

      if (didAuth) {
        systemLockEnabled = !systemLockEnabled;
        await securitypref.setSystemLock(systemLockEnabled);
      }
    } catch (e) {
      systemLockError = 'Authentication failed.';
    }

    setBusy(false);
    notifyListeners();
  }

  Future<bool> requireUnlock() async {
    if (!await securitypref.getSystemLock()) return true;

    try {
      return await lockauth.authenticate(
        localizedReason: 'Unlock Fusion Festa',
        biometricOnly: false,
      );
    } catch (_) {
      return false;
    }
  }

  void ontapchangepassword() {
    navigationService.navigateTo(Routes.changePasswordView);
  }

  void ontaplogOutAllDevices() {}
}
