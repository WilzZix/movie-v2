import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:movie/core/utils/application_theme.dart';
import 'package:movie/data/datasources/local_data_source/shared_preference_service.dart';

part 'core_state.dart';

class CoreCubit extends Cubit<CoreState> {
  CoreCubit() : super(CoreInitial());
  SharedPreferenceService sharedPreferenceService = SharedPreferenceService();

  Future<void> changeTheme(String themeMode) async {
    if (themeMode == 'light') {
      sharedPreferenceService.setAppTheme(themeMode);
      emit(ApplicationThemeChanged(themeData: ApplicationTheme.light));
    } else {
      sharedPreferenceService.setAppTheme(themeMode);
      emit(ApplicationThemeChanged(themeData: ApplicationTheme.dark));
    }
  }

  Future<void> getAppTheme() async {
    final theme = SharedPreferenceService.getAppTheme();
    if (theme == 'dark') {
      emit(ApplicationThemeLoaded(themeData: ApplicationTheme.dark));
    } else {
      emit(ApplicationThemeLoaded(themeData: ApplicationTheme.light));
    }
  }
}
