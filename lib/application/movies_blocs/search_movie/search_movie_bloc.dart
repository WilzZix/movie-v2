import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/datasources/local_data_source/shared_preference_service.dart';
import 'package:movie/data/datasources/network_data_source/network_movies_datasource.dart';
import 'package:movie/data/models/movies_model.dart';
import 'package:movie/presentation/pages/search_page/search_arguments.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_movie_event.dart';

part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  SearchMovieBloc() : super(SearchMovieInitial()) {
    on<SearchMovieEventInitial>(_searchMovie);
    on<LoadMoreEvent>(_loadMore);
    on<GetPreviousSearchResult>(_getPreviousSearchResult);
  }

  NetworkMoviesDataSource dataSource = NetworkMoviesDataSource();
  SharedPreferenceService sharedPreferences = SharedPreferenceService();
  int page = 1;
  String keyword = '';
  List<Result>? results = [];

  FutureOr<void> _searchMovie(
      SearchMovieEventInitial event, Emitter<SearchMovieState> emit) async {
    results!.clear();
    emit(SearchMovieLoadingState());
    page = 1;
    try {
      keyword = event.keyword!;
      final result = await dataSource.searchMovies(
        keyword: event.keyword!,
        page: page,
      );
      results!.addAll(result.results!);
      emit(SearchMovieLoadedState(MoviesResult(results: results)));
    } catch (e) {
      emit(SearchMovieLoadErrorState(e.toString()));
    }
  }

  FutureOr<void> _loadMore(
      LoadMoreEvent event, Emitter<SearchMovieState> emit) async {
    final result = await dataSource.searchMovies(
      keyword: keyword,
      page: ++page,
    );
    results!.addAll(result.results!);
    emit(SearchMovieLoadedState(MoviesResult(results: results)));
  }

  FutureOr<void> _getPreviousSearchResult(
      GetPreviousSearchResult event, Emitter<SearchMovieState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? movieJsonList =
          prefs.getStringList('movie_results')!.reversed.toList();

      emit(LastSearchedMovieLoadedState(movieJsonList
          .map((movieJson) => Result.fromJson(jsonDecode(movieJson)))
          .toList()));
    } catch (e) {
      emit(SearchMovieLoadErrorState(e.toString()));
    }
  }
}
