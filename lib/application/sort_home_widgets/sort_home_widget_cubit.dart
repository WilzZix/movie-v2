import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/datasources/local_data_source/shared_preference_service.dart';

part 'sort_home_widget_state.dart';

class SortHomeWidgetCubit extends Cubit<SortHomeWidgetState> {
  SortHomeWidgetCubit() : super(SortHomeWidgetInitial());

  Future<void> defaultSortedHomeWidgets() async {
    if (SharedPreferenceService.getSortedHomeWidgets().isEmpty) {
      emit(
        DefaultSortedWidget(
          const {
            'popular': 1,
            'top_movies_pick': 0,
            'upcoming': 2,
          },
        ),
      );
    } else {
      emit(DefaultSortedWidget(const {
        'popular': 1,
        'top_movies_pick': 0,
        'upcoming': 2,
      }));
    }
  }

  Future<void> sortHomeWidgets(Map<String, dynamic> sortedData) async {
    emit(SortedWidgetsLoaded(sortedData));
  }
}
