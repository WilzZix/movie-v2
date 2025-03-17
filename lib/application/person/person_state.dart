part of 'person_bloc.dart';

@immutable
sealed class PersonState {}

final class PersonInitial extends PersonState {}

///Person played movies
class PersonMoviesLoadingState extends PersonState {}

class PersonMoviesLoadedState extends PersonState {
  final List<Movie> data;

  PersonMoviesLoadedState({required this.data});
}

class PersonMoviesLoadErrorState extends PersonState {
  final String msg;

  PersonMoviesLoadErrorState({required this.msg});
}

///Get person detail info
class PersonMovieDetailLoadingState extends PersonState {}

class PersonMovieDetailLoadedState extends PersonState {
  final PersonDetailModel data;

  PersonMovieDetailLoadedState({required this.data});
}

class PersonMovieDetailLoadErrorState extends PersonState {
  final String msg;

  PersonMovieDetailLoadErrorState({required this.msg});
}

///Get person gallery
class PersonGalleryLoadingState extends PersonState {}

class PersonGalleryLoadedState extends PersonState {
  final List<ImageDetailModel> data;

  PersonGalleryLoadedState({required this.data});
}

class PersonGalleryLoadingErrorState extends PersonState {
  final String msg;

  PersonGalleryLoadingErrorState({required this.msg});
}
