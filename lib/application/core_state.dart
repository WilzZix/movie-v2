part of 'core_cubit.dart';

@immutable
sealed class CoreState {}

final class CoreInitial extends CoreState {}

class ApplicationThemeLoaded extends CoreState {
  final ThemeData themeData;

  ApplicationThemeLoaded({required this.themeData});
}
