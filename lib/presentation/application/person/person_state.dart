part of 'person_bloc.dart';

@immutable
sealed class PersonState extends Equatable {}

final class PersonInitial extends PersonState {
  @override
  List<Object?> get props => [];
}

///Person played movies
class PersonMoviesLoadingState extends PersonState {
  @override
  List<Object?> get props => [];
}

class PersonMoviesLoadedState extends PersonState {
  final List<Movie> data;

  PersonMoviesLoadedState({required this.data});

  @override
  List<Object?> get props => [data];
}

class PersonMoviesLoadErrorState extends PersonState {
  final String msg;

  PersonMoviesLoadErrorState({required this.msg});

  @override
  List<Object?> get props => [msg];
}

///Get person detail info
class PersonMovieDetailLoadingState extends PersonState {
  @override
  List<Object?> get props => [];
}

class PersonMovieDetailLoadedState extends PersonState {
  final PersonDetailModel data;

  PersonMovieDetailLoadedState({required this.data});

  @override
  List<Object?> get props => [data];
}

class PersonMovieDetailLoadErrorState extends PersonState {
  final String msg;

  PersonMovieDetailLoadErrorState({required this.msg});

  @override
  List<Object?> get props => [msg];
}

///Get person gallery
class PersonGalleryLoadingState extends PersonState {
  @override
  List<Object?> get props => [];
}

class PersonGalleryLoadedState extends PersonState {
  final List<ImageDetailModel> data;

  PersonGalleryLoadedState({required this.data});

  @override
  List<Object?> get props => [data];
}

class PersonGalleryLoadingErrorState extends PersonState {
  final String msg;

  PersonGalleryLoadingErrorState({required this.msg});

  @override
  List<Object?> get props => [msg];
}
