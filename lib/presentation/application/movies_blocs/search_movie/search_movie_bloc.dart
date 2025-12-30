import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/datasources/local_data_source/shared_preference_service.dart';
import 'package:movie/data/models/movies_model.dart';
import 'package:movie/data/models/result_entity.dart';
import 'package:movie/domain/repositories/i_movies_repository.dart';
import 'package:movie/presentation/pages/search_page/search_arguments.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

part 'search_movie_event.dart';

part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  SearchMovieBloc(this.dataSource) : super(SearchMovieInitial()) {
    on<SearchEventInitial>(_searchMovie, transformer: debounce(const Duration(milliseconds: 500)));
    on<LoadMoreEvent>(_loadMore);
    on<GetPreviousSearchResult>(_getPreviousSearchResult);
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }

  final IMoviesRepository dataSource;
  SharedPreferenceService sharedPreferences = SharedPreferenceService();
  SearchArguments? arguments;
  int page = 1;
  String keyword = '';
  List<Result>? results = [];
  MediaType? mediaType;

  FutureOr<void> _searchMovie(SearchEventInitial event, Emitter<SearchMovieState> emit) async {
    results!.clear();
    emit(SearchMovieLoadingState());
    page = 1;

    keyword = event.keyword!;
    mediaType = event.arguments!.mediaType!;
    switch (mediaType) {
      case null:
        final result = await dataSource.search(
          keyword: event.keyword!,
          page: page,
        );
        switch (result) {
          case SuccessEntity():
            results!.addAll(result.data.results!);
            emit(SearchMovieLoadedState(MoviesResult(results: results)));
          case FailureEntity():
            emit(SearchMovieLoadErrorState(result.exception.toString()));
        }
      case MediaType.movie:
        final result = await dataSource.searchMovie(
          keyword: event.keyword!,
          page: page,
        );
        switch (result) {
          case SuccessEntity():
            results!.addAll(result.data.results!);
            emit(SearchMovieLoadedState(MoviesResult(results: results)));
          case FailureEntity():
            emit(SearchMovieLoadErrorState(result.exception.toString()));
        }
      case MediaType.person:
        final result = await dataSource.searchPerson(
          keyword: event.keyword!,
          page: page,
        );
        switch (result) {
          case SuccessEntity():
            results!.addAll(result.data.results!);
            emit(SearchMovieLoadedState(MoviesResult(results: results)));
          case FailureEntity():
            emit(SearchMovieLoadErrorState(result.exception.toString()));
        }

      case MediaType.tv:
        final result = await dataSource.searchTv(
          keyword: event.keyword!,
          page: page,
        );
        switch (result) {
          case SuccessEntity():
            results!.addAll(result.data.results!);
            emit(SearchMovieLoadedState(MoviesResult(results: results)));
          case FailureEntity():
            emit(SearchMovieLoadErrorState(result.exception.toString()));
        }

      case MediaType.collection:
        final result = await dataSource.searchCollection(
          keyword: event.keyword!,
          page: page,
        );
        switch (result) {
          case SuccessEntity():
            results!.addAll(result.data.results!);
            emit(SearchMovieLoadedState(MoviesResult(results: results)));
          case FailureEntity():
            emit(SearchMovieLoadErrorState(result.exception.toString()));
        }

      case MediaType.all:
        final result = await dataSource.search(
          keyword: event.keyword!,
          page: page,
        );
        switch (result) {
          case SuccessEntity():
            results!.addAll(result.data.results!);
            emit(SearchMovieLoadedState(MoviesResult(results: results)));
          case FailureEntity():
            emit(SearchMovieLoadErrorState(result.exception.toString()));
        }
    }
  }

  FutureOr<void> _loadMore(LoadMoreEvent event, Emitter<SearchMovieState> emit) async {
    add(SearchEventInitial());
    // final result = await dataSource.search(
    //   keyword: keyword,
    //   page: ++page,
    // );
    // results!.addAll(result.results!);
    // emit(SearchMovieLoadedState(MoviesResult(results: results)));
  }

  FutureOr<void> _getPreviousSearchResult(GetPreviousSearchResult event, Emitter<SearchMovieState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? movieJsonList = prefs.getStringList('movie_results')!.reversed.toList();

      emit(LastSearchedMovieLoadedState(
          movieJsonList.map((movieJson) => Result.fromJson(jsonDecode(movieJson))).toList()));
    } catch (e) {
      emit(SearchMovieLoadErrorState(e.toString()));
    }
  }
}
