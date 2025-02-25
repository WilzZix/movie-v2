import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/datasources/local_data_source/shared_preference_service.dart';
import 'package:movie/data/datasources/network_data_source/network_movies_datasource.dart';
import 'package:movie/data/models/movie_gallery_model.dart';

import '../../../data/models/default_model.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailInitial()) {
    on<AddMovieToWatchList>(_addMovieToWatchList);
    on<GetMovieGalleryEvent>(_getMovieGallery);
  }

  NetworkMoviesDataSource dataSource = NetworkMoviesDataSource();

  Future<void> _addMovieToWatchList(
      AddMovieToWatchList event, Emitter<MovieDetailState> emit) async {
    try {
      emit(AddingMovieToWatchList());
      DefaultModel defaultModel = await dataSource.addMovieWatchList(
        movieId: event.movieId,
        accountId: SharedPreferenceService.getAccountId(),
        sessionId: SharedPreferenceService.getUserSessionId()!,
      );
      emit(MovieAddedToWatchList(defaultModel));
    } catch (e) {
      emit(AddingMovieToWatchlistError(e.toString()));
    }
  }

  Future<void> _getMovieGallery(
      GetMovieGalleryEvent event, Emitter<MovieDetailState> emit) async {
    try {
      emit(MovieGalleryLoadingState());
      List<ImageData> data =
          await dataSource.getMovieGallery(movieId: event.movieId);
      emit(MovieGalleryLoadedState(data: data));
    } catch (e) {
      emit(MovieGalleryLoadErrorState(msg: e.toString()));
    }
  }
}
