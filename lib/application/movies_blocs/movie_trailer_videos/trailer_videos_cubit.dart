import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/datasources/network_data_source/network_movies_datasource.dart';
import 'package:movie/data/models/trailer_model.dart';

part 'trailer_videos_state.dart';

class TrailerVideosCubit extends Cubit<TrailerVideosState> {
  TrailerVideosCubit() : super(TrailerVideosInitial());
  NetworkMoviesDataSource dataSource = NetworkMoviesDataSource();

  FutureOr<void> getTrailerVideos({required int movieId}) async {
    emit(TrailerVideosLoadingState());
    try {
      final result = await dataSource.getMovieTrailer(movieId: movieId);
      emit(TrailerVideosLoadedState(data: [result.first,result.last]));
    } catch (e) {
      emit(TrailerVideosLoadErrorState(e.toString()));
    }
  }
}
