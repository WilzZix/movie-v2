import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/datasources/network_data_source/network_movies_datasource.dart';
import 'package:movie/data/models/movies_model.dart';

part 'recommended_movies_state.dart';

class RecommendedMoviesCubit extends Cubit<RecommendedMoviesState> {
  RecommendedMoviesCubit() : super(RecommendedMoviesInitial());
  NetworkMoviesDataSource dataSource = NetworkMoviesDataSource();

  FutureOr<void> getRecommendedMovies({required int movieId}) async {
    try {
      final result = await dataSource.getRecommendedMovies(movieId: movieId);
      emit(RecommendedVideosLoadedState(data: result));
    } catch (e) {
      log('line 20 ${e.toString()}');
      emit(RecommendedVideosLoadErrorState(e.toString()));
    }
  }
}
