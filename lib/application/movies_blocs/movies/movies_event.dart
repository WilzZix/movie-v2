part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent {}

class GetTopRatedMoviesEvent extends MoviesEvent {
  final int page;

  GetTopRatedMoviesEvent(this.page);
}

class GetUpcomingMoviesEvent extends MoviesEvent {
  final int page;

  GetUpcomingMoviesEvent(this.page);
}

class GetPopularMoviesEvent extends MoviesEvent {
  final int page;

  GetPopularMoviesEvent(this.page);
}

class GetMovieDetailsEvent extends MoviesEvent {
  final int movieId;

  GetMovieDetailsEvent(this.movieId);
}

///Search movie
class SearchMovieEvent extends MoviesEvent {
  final String? keyword;
  final SearchArguments? arguments;

  SearchMovieEvent({this.keyword, this.arguments});
}

class AddMovieToPreviousSearchResult extends MoviesEvent {
  final Result searchedMovie;

  AddMovieToPreviousSearchResult(this.searchedMovie);
}

class GetPreviousSearchResult extends MoviesEvent {}



///Watchlist movies
class GetWatchListMoviesEvent extends MoviesEvent {}

///TVShow
class GetTrendingTVShowEvent extends MoviesEvent {
  final int page;

  GetTrendingTVShowEvent(this.page);
}
