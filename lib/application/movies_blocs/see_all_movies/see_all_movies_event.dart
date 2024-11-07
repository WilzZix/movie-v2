part of 'see_all_movies_bloc.dart';

@immutable
sealed class SeeAllMoviesEvent {}

class FetchSeeAllMoviesEvent extends SeeAllMoviesEvent {
  final int page;
  final MovieType type;

  FetchSeeAllMoviesEvent({
    required this.page,
    required this.type,
  });
}

enum MovieType { topMoviesPick, upcoming, popular }
