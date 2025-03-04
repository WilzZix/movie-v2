part of 'search_movie_bloc.dart';

@immutable
sealed class SearchMovieState {}

final class SearchMovieInitial extends SearchMovieState {}

///Search movie
class SearchMovieLoadingState extends SearchMovieState {}

class SearchMovieLoadedState extends SearchMovieState {
  final MoviesResult data;

  SearchMovieLoadedState(this.data);
}

class SearchMovieLoadErrorState extends SearchMovieState {
  final String msg;

  SearchMovieLoadErrorState(this.msg);
}

class LastSearchedMovieLoadedState extends SearchMovieState {
  final List<Result> data;

  LastSearchedMovieLoadedState(this.data);
}
