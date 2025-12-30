import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/datasources/local_data_source/shared_preference_service.dart';
import 'package:movie/data/models/default_model.dart';
import 'package:movie/data/models/movie_gallery_model.dart';
import 'package:movie/data/models/result_entity.dart';
import 'package:movie/domain/repositories/i_movies_repository.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc(this.dataSource) : super(MovieDetailInitial()) {
    on<AddMovieToWatchList>(_addMovieToWatchList);
    on<GetMovieGalleryEvent>(_getMovieGallery);
  }

  final IMoviesRepository dataSource;

  Future<void> _addMovieToWatchList(AddMovieToWatchList event, Emitter<MovieDetailState> emit) async {
    emit(AddingMovieToWatchList());
    final result = await dataSource.addMovieWatchList(
      movieId: event.movieId,
      accountId: SharedPreferenceService.getAccountId()!,
      sessionId: SharedPreferenceService.getUserSessionId()!,
    );
    switch (result) {
      case SuccessEntity():
        emit(MovieAddedToWatchList(result.data));
      case FailureEntity():
        emit(AddingMovieToWatchlistError(result.exception.toString()));
    }
  }

  Future<void> _getMovieGallery(GetMovieGalleryEvent event, Emitter<MovieDetailState> emit) async {
    emit(MovieGalleryLoadingState());
    final result = await dataSource.getMovieGallery(movieId: event.movieId);
    switch (result) {
      case SuccessEntity():
        emit(MovieGalleryLoadedState(data: result.data));
      case FailureEntity():
        emit(MovieGalleryLoadErrorState(msg: result.exception.toString()));
    }
  }
}
