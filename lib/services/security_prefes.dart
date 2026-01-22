import 'package:shared_preferences/shared_preferences.dart';

class SecurityPrefs {
  //using system local lock
  static const _systemLockKey = 'system_lock_enabled';

  Future<bool> getSystemLock() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_systemLockKey) ?? false;
  }

  Future<void> setSystemLock(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_systemLockKey, value);
  }
}
