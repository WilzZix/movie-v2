part of 'recommended_movies_cubit.dart';

@immutable
sealed class RecommendedMoviesState {}

final class RecommendedMoviesInitial extends RecommendedMoviesState {}

class RecommendedVideosLoadedState extends RecommendedMoviesState {
  final MoviesResult data;

  RecommendedVideosLoadedState({required this.data});
}

class RecommendedVideosLoadErrorState extends RecommendedMoviesState {
  final String msg;

  RecommendedVideosLoadErrorState(this.msg);
}

class RecommendedVideosLoadingState extends RecommendedMoviesState {}
