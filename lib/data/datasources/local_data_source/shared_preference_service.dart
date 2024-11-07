import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static SharedPreferences? _instance;

  static Future<SharedPreferences> init() async {
    _instance = await SharedPreferences.getInstance();
    return _instance!;
  }

  Future<void> setUserRequestToken(String requestToken) async {
    await _instance?.setString(
        SharedPrefsKeyStrings.userRequestTokenKey, requestToken);
  }

  Future<void> setSessionId(String sessionId) async {
    _instance?.setString(SharedPrefsKeyStrings.userSessionIdKey, sessionId);
  }

  Future<void> setUserAuthStatus(bool status) async {
    _instance?.setBool(SharedPrefsKeyStrings.userAuthKey, status);
  }

  Future<void> setAccountId(int accountId) async {
    _instance?.setInt(SharedPrefsKeyStrings.accountId, accountId);
  }

  static String? getUserRequestToken() =>
      _instance?.getString(SharedPrefsKeyStrings.userRequestTokenKey);

  static String? getUserSessionId() =>
      _instance?.getString(SharedPrefsKeyStrings.userSessionIdKey);

  static bool? getUserAuthStatus() =>
      _instance?.getBool(SharedPrefsKeyStrings.userAuthKey);

  static int? getAccountId() =>
      _instance?.getInt(SharedPrefsKeyStrings.accountId);

  //for delete data
  static Future<bool> remove(String key) async => await _instance!.remove(key);

  static Future<bool> clear() async => await _instance!.clear();
}

class SharedPrefsKeyStrings {
  static String userAuthKey = 'auth';
  static String userRequestTokenKey = 'requestToken';
  static String userSessionIdKey = 'requestToken';
  static String accountId = 'accountId';
}
