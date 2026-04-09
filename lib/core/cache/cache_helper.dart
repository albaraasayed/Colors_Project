import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _prefs;

  static const String _onboardingSeenKey = 'onboardingSeen';
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _loggedInEmailKey = 'loggedInEmail';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isOnboardingSeen =>
      _prefs.getBool(_onboardingSeenKey) ?? false;

  static Future<void> markOnboardingSeen() =>
      _prefs.setBool(_onboardingSeenKey, true);

  static bool get isLoggedIn => _prefs.getBool(_isLoggedInKey) ?? false;

  static String? get loggedInEmail => _prefs.getString(_loggedInEmailKey);

  static Future<void> saveLoginSession(String email) async {
    await _prefs.setBool(_isLoggedInKey, true);
    await _prefs.setString(_loggedInEmailKey, email);
  }

  static Future<void> clearSession() async {
    await _prefs.remove(_isLoggedInKey);
    await _prefs.remove(_loggedInEmailKey);
  }
}
