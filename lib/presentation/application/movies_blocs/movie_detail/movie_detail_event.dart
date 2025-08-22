part of 'movie_detail_bloc.dart';

@immutable
sealed class MovieDetailEvent {}

///Add movie to watchlist
class AddMovieToWatchList extends MovieDetailEvent {
  final int movieId;

  AddMovieToWatchList(this.movieId);
}

/// Movie gallery
class GetMovieGalleryEvent extends MovieDetailEvent {
  final int movieId;

  GetMovieGalleryEvent({required this.movieId});
}
