import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:movie/core/utils/application_theme.dart';

part 'core_state.dart';

class CoreCubit extends Cubit<CoreState> {
  CoreCubit() : super(CoreInitial());

  Future<void> changeTheme(String themeMode) async {
    if (themeMode == 'light') {
      emit(ApplicationThemeLoaded(themeData: ApplicationTheme.light));
    } else {
      emit(ApplicationThemeLoaded(themeData: ApplicationTheme.dark));
    }
  }
}
