part of 'language_cubit.dart';

@immutable
sealed class LanguageState {}

final class LanguageInitial extends LanguageState {}

class LanguageChangedState extends LanguageState {
  final Language currentLanguage;

  LanguageChangedState({required this.currentLanguage});
}

class CurrentLanguageState extends LanguageState {
  final Language currentLanguage;

  CurrentLanguageState({required this.currentLanguage});
}
