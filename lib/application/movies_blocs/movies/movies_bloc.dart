import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/datasources/local_data_source/shared_preference_service.dart';
import 'package:movie/data/datasources/network_data_source/network_movies_datasource.dart';
import 'package:movie/data/models/movie_videos.dart';
import 'package:movie/data/models/movies_detail_model.dart';
import 'package:movie/data/models/movies_model.dart';
import 'package:movie/presentation/pages/search_page/search_arguments.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'movies_event.dart';

part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial()) {
    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);
    on<GetUpcomingMoviesEvent>(_getUpcomingMovies);
    on<GetPopularMoviesEvent>(_getPopularMovies);
    on<GetMovieDetailsEvent>(_getMovieDetails);

    on<AddMovieToPreviousSearchResult>(
        _addSearchResultMovieToPreviousSearchResult);
    on<GetWatchListMoviesEvent>(_getWatchListMovies);
    on<GetTrendingTVShowEvent>(_getTrendingTVShow);
  }

  NetworkMoviesDataSource dataSource = NetworkMoviesDataSource();
  SharedPreferenceService sharedPreferences = SharedPreferenceService();
  int page = 1;
  String keyword = '';
  List<Result>? results = [];

  FutureOr<void> _getTopRatedMovies(
      GetTopRatedMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(TopRatedMoviesLoadingState());
    try {
      final result = await dataSource.getTopRatedMovies(page: event.page);
      results!.addAll(result.results!);
      emit(TopRatedMoviesLoadedState(MoviesResult(results: results)));
    } catch (e) {
      emit(TopRatedMoviesLoadingErrorState(e.toString()));
    }
  }

  FutureOr<void> _getUpcomingMovies(
      GetUpcomingMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(UpcomingMoviesLoadingState());
    try {
      final result = await dataSource.getUpcomingMovies(page: event.page);
      emit(UpcomingMoviesLoadedState(result));
    } catch (e) {
      emit(UpcomingMoviesLoadError(e.toString()));
    }
  }

  FutureOr<void> _getPopularMovies(
      GetPopularMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(PopularMoviesLoadingState());
    try {
      final result = await dataSource.getPopularMovies(page: event.page);
      emit(PopularMoviesLoadedState(result));
    } catch (e) {
      emit(PopularMoviesLoadErrorState(e.toString()));
    }
  }

  FutureOr<void> _getMovieDetails(
      GetMovieDetailsEvent event, Emitter<MoviesState> emit) async {
    emit(MovieDetailsLoadingState());
    try {
      final result = await dataSource.getMovieDetails(movieId: event.movieId);
      List<MovieVideos> movieVideos =
          await dataSource.getMovieVideos(movieId: event.movieId);
      emit(MovieDetailsLoadedState((result, movieVideos[0].key!)));
    } catch (e) {
      emit(MoviesDetailsLoadingErrorState(e.toString()));
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

  Future<void> _getWatchListMovies(
      GetWatchListMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(WatchListMoviesLoadingState());
    try {
      final result = await dataSource.getWatchListMovies(
          accountId: SharedPreferenceService.getAccountId()!,
          sessionId: SharedPreferenceService.getUserSessionId()!);
      emit(WatchListMoviesLoadedState(result));
    } catch (e) {
      emit(WatchListMoviesLoadedErrorState(e.toString()));
    }
  }

  FutureOr<void> _getTrendingTVShow(
      GetTrendingTVShowEvent event, Emitter<MoviesState> emit) async {
    emit(TrendingTVShowLoadingState());
    try {
      final result = await dataSource.getTrendingTVShow(page: page);
      emit(TrendingTVShowLoadedState(result));
    } catch (e) {
      emit(TrendingTVShowLoadingErrorState(e.toString()));
    }
  }
}
