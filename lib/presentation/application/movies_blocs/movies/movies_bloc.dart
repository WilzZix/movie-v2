import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/datasources/local_data_source/shared_preference_service.dart';
import 'package:movie/data/models/movie_videos.dart';
import 'package:movie/data/models/movies_detail_model.dart';
import 'package:movie/data/models/movies_model.dart';
import 'package:movie/data/models/result_entity.dart';
import 'package:movie/domain/repositories/i_movies_repository.dart';
import 'package:movie/presentation/pages/search_page/search_arguments.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'movies_event.dart';

part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc(this.dataSource) : super(MoviesInitial()) {
    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);
    on<GetUpcomingMoviesEvent>(_getUpcomingMovies);
    on<GetPopularMoviesEvent>(_getPopularMovies);
    on<GetMovieDetailsEvent>(_getMovieDetails);

    on<AddMovieToPreviousSearchResult>(_addSearchResultMovieToPreviousSearchResult);
    on<GetWatchListMoviesEvent>(_getWatchListMovies);
    on<GetTrendingTVShowEvent>(_getTrendingTVShow);
  }

  final IMoviesRepository dataSource;
  SharedPreferenceService sharedPreferences = SharedPreferenceService();
  int page = 1;
  String keyword = '';
  List<Result>? results = [];

  FutureOr<void> _getTopRatedMovies(GetTopRatedMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(TopRatedMoviesLoadingState());
    final result = await dataSource.getTopRatedMovies(page: event.page);
    switch (result) {
      case SuccessEntity():
        results!.addAll(result.data.results!);
        emit(TopRatedMoviesLoadedState(MoviesResult(results: results)));
      case FailureEntity():
        emit(TopRatedMoviesLoadingErrorState(result.exception.toString()));
    }
  }

  FutureOr<void> _getUpcomingMovies(GetUpcomingMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(UpcomingMoviesLoadingState());
    final result = await dataSource.getUpcomingMovies(page: event.page);
    switch (result) {
      case SuccessEntity():
        emit(UpcomingMoviesLoadedState(result.data));
      case FailureEntity():
        emit(UpcomingMoviesLoadError(result.exception.toString()));
    }
  }

  FutureOr<void> _getPopularMovies(GetPopularMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(PopularMoviesLoadingState());
    final result = await dataSource.getPopularMovies(page: event.page);
    switch (result) {
      case SuccessEntity():
        emit(PopularMoviesLoadedState(result.data));
      case FailureEntity():
        emit(PopularMoviesLoadErrorState(result.exception.toString()));
    }
  }

  FutureOr<void> _getMovieDetails(GetMovieDetailsEvent event, Emitter<MoviesState> emit) async {
    emit(MovieDetailsLoadingState());
    String txt = '';
    final result = await dataSource.getMovieDetails(movieId: event.movieId);
    ResultEntity<List<MovieVideos>> movieVideos = await dataSource.getMovieVideos(movieId: event.movieId);
    switch (movieVideos) {
      case SuccessEntity():
        txt = movieVideos.data[0].key!;
    }
    switch (result) {
      case SuccessEntity():
        emit(MovieDetailsLoadedState((result.data, txt)));
      case FailureEntity():
        emit(MoviesDetailsLoadingErrorState(result.exception.toString()));
    }
  }

  Future<void> _addSearchResultMovieToPreviousSearchResult(
      AddMovieToPreviousSearchResult event, Emitter<MoviesState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> movieJsonList = prefs.getStringList('movie_results') ?? [];
      movieJsonList.add(jsonEncode(event.searchedMovie.toJson()));
      await prefs.setStringList('movie_results', movieJsonList);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _getWatchListMovies(GetWatchListMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(WatchListMoviesLoadingState());
    final result = await dataSource.getWatchListMovies(
        accountId: SharedPreferenceService.getAccountId()!, sessionId: SharedPreferenceService.getUserSessionId()!);
    switch (result) {
      case SuccessEntity():
        emit(WatchListMoviesLoadedState(result.data));
      case FailureEntity():
        emit(WatchListMoviesLoadedErrorState(result.exception.toString()));
    }
  }

  FutureOr<void> _getTrendingTVShow(GetTrendingTVShowEvent event, Emitter<MoviesState> emit) async {
    emit(TrendingTVShowLoadingState());

    final result = await dataSource.getTrendingTVShow(page: page);
    switch (result) {
      case SuccessEntity():
        emit(TrendingTVShowLoadedState(result.data));
      case FailureEntity():
        emit(TrendingTVShowLoadingErrorState(result.exception.toString()));
    }
  }
}
