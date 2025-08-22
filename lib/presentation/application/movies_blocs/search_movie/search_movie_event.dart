part of 'search_movie_bloc.dart';

@immutable
sealed class SearchMovieEvent {}

///Search movie
class SearchEventInitial extends SearchMovieEvent {
  final String? keyword;
  final SearchArguments? arguments;

  SearchEventInitial({this.keyword, this.arguments});
}

class AddMovieToPreviousSearchResult extends SearchMovieEvent {
  final Result searchedMovie;

  AddMovieToPreviousSearchResult(this.searchedMovie);
}

class GetPreviousSearchResult extends SearchMovieEvent {}

///Load more
class LoadMoreEvent extends SearchMovieEvent {}
