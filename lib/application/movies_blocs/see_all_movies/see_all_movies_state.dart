part of 'see_all_movies_bloc.dart';

@immutable
sealed class SeeAllMoviesState {}

final class SeeAllMoviesInitial extends SeeAllMoviesState {}

class SeeAllMoviesLoadingState extends SeeAllMoviesState {}

class SeeAllMoviesLoaded extends SeeAllMoviesState {
  final MoviesResult result;

  SeeAllMoviesLoaded(this.result);
}

class SeeAllMoviesLoadErrorState extends SeeAllMoviesState {
  final String msg;

  SeeAllMoviesLoadErrorState(this.msg);
}
