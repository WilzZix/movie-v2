part of 'filter_genre_cubit.dart';

@immutable
sealed class FilterGenreState {}

final class FilterGenreInitial extends FilterGenreState {}

class MovieGenresLoadedState extends FilterGenreState {
  final List<GenreModel> data;

  MovieGenresLoadedState(this.data);
}

class MovieGenresLoadingErrorState extends FilterGenreState {
  final String msg;

  MovieGenresLoadingErrorState(this.msg);
}

class MovieGenreLoadingState extends FilterGenreState {}
