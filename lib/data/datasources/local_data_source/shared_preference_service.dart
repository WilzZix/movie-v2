import 'package:injectable/injectable.dart';
import 'package:movie/presentation/application/language/language_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Singleton()
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

  static String getAppTheme() =>
      _instance?.getString(SharedPrefsKeyStrings.appTheme) ?? 'dark';

  Future<void> setAppTheme(String appTheme) async {
    _instance?.setString(SharedPrefsKeyStrings.appTheme, appTheme);
  }

  Future<void> setAppLanguage(Language appLanguage) async {
    _instance?.setString(
        SharedPrefsKeyStrings.appLanguage, appLanguage.toJson());
  }

  static Language? getAppLanguage() {
    String? appLanguageString =
        _instance?.getString(SharedPrefsKeyStrings.appLanguage);
    if (appLanguageString != null) {
      return Language.fromJson(appLanguageString);
    }
    return Language(name: 'English', code: 'en-US');
  }

  //for delete data
  static Future<bool> remove(String key) async => await _instance!.remove(key);

  static Future<bool> clear() async => await _instance!.clear();
}

class SharedPrefsKeyStrings {
  static String userAuthKey = 'auth';
  static String userRequestTokenKey = 'requestToken';
  static String userSessionIdKey = 'requestToken';
  static String accountId = 'accountId';
  static String appTheme = 'appTheme';
  static String appLanguage = 'appLanguage';
}
