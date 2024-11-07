part of 'movie_detail_bloc.dart';

@immutable
sealed class MovieDetailState {}

final class MovieDetailInitial extends MovieDetailState {}

///Add movie to watchlist
class AddingMovieToWatchList extends MovieDetailState {}

class MovieAddedToWatchList extends MovieDetailState {
  final DefaultModel defaultModel;

  MovieAddedToWatchList(this.defaultModel);
}

class AddingMovieToWatchlistError extends MovieDetailState {
  final String msg;

  AddingMovieToWatchlistError(this.msg);
}
