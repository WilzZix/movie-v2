part of 'search_movie_bloc.dart';

@immutable
sealed class SearchMovieState extends Equatable {}

final class SearchMovieInitial extends SearchMovieState {
  @override
  List<Object?> get props => [];
}

///Search movie
class SearchMovieLoadingState extends SearchMovieState {
  @override
  List<Object?> get props => [];
}

class SearchMovieLoadedState extends SearchMovieState {
  final MoviesResult data;

  SearchMovieLoadedState(this.data);

  @override
  List<Object?> get props => [data];
}

class SearchMovieLoadErrorState extends SearchMovieState {
  final String msg;

  SearchMovieLoadErrorState(this.msg);

  @override
  List<Object?> get props => [];
}

class LastSearchedMovieLoadedState extends SearchMovieState {
  final List<Result> data;

  LastSearchedMovieLoadedState(this.data);

  @override
  List<Object?> get props => [data];
}
