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

/// Movie gallery
class MovieGalleryLoadingState extends MovieDetailState {}

class MovieGalleryLoadedState extends MovieDetailState {
  final List<ImageData> data;

  MovieGalleryLoadedState({required this.data});
}

class MovieGalleryLoadErrorState extends MovieDetailState {
  final String msg;

  MovieGalleryLoadErrorState({required this.msg});
}
