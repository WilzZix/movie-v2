import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/datasources/local_data_source/shared_preference_service.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit(this.sharedPreferenceService) : super(LanguageInitial());
  final SharedPreferenceService sharedPreferenceService;

  Future<void> changeLanguage(Language language) async {
    await sharedPreferenceService.setAppLanguage(language);
    emit(LanguageChangedState(currentLanguage: language));
  }

  Future<void> getCurrentLanguage() async {
    emit(
      CurrentLanguageState(
        currentLanguage: SharedPreferenceService.getAppLanguage() ??
            Language(name: 'English', code: 'en-US'),
      ),
    );
  }
}

class Language {
  final String name;
  final String code;

  String toJson() {
    return jsonEncode({
      'name': name,
      'code': code,
    });
  }

  factory Language.fromJson(String jsonString) {
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return Language(
      name: jsonMap['name'],
      code: jsonMap['code'],
    );
  }

  Language({required this.name, required this.code});
}
