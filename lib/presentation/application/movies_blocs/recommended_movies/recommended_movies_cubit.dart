import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/models/movies_model.dart';
import 'package:movie/data/models/result_entity.dart';
import 'package:movie/domain/repositories/i_movies_repository.dart';

part 'recommended_movies_state.dart';

class RecommendedMoviesCubit extends Cubit<RecommendedMoviesState> {
  RecommendedMoviesCubit(this.dataSource) : super(RecommendedMoviesInitial());
  final IMoviesRepository dataSource;

  FutureOr<void> getRecommendedMovies({required int movieId}) async {
    final result = await dataSource.getRecommendedMovies(movieId: movieId);
    switch (result) {
      case SuccessEntity():
        emit(RecommendedVideosLoadedState(data: result.data));
      case FailureEntity():
        emit(RecommendedVideosLoadErrorState(result.exception.toString()));
    }
  }
}
