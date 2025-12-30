import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/models/result_entity.dart';
import 'package:movie/data/models/trailer_model.dart';
import 'package:movie/domain/repositories/i_movies_repository.dart';

part 'trailer_videos_state.dart';

class TrailerVideosCubit extends Cubit<TrailerVideosState> {
  TrailerVideosCubit(this.dataSource) : super(TrailerVideosInitial());
  final IMoviesRepository dataSource;

  FutureOr<void> getTrailerVideos({required int movieId}) async {
    emit(TrailerVideosLoadingState());
    final result = await dataSource.getMovieTrailer(movieId: movieId);
    switch (result) {
      case SuccessEntity():
        emit(TrailerVideosLoadedState(data: [result.data.first, result.data.last]));
      case FailureEntity():
        emit(TrailerVideosLoadErrorState(result.exception.toString()));
    }
  }
}
