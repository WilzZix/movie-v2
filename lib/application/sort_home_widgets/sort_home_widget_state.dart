part of 'sort_home_widget_cubit.dart';

@immutable
sealed class SortHomeWidgetState {}

final class SortHomeWidgetInitial extends SortHomeWidgetState {}

class DefaultSortedWidget extends SortHomeWidgetState {
  final Map<String, dynamic> sortedHomeWidgets;

  DefaultSortedWidget(this.sortedHomeWidgets);
}

class SortedWidgetsLoaded extends SortHomeWidgetState {
  final Map<String, dynamic> sortedHomeWidgets;

  SortedWidgetsLoaded(this.sortedHomeWidgets);
}
