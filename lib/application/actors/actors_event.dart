part of 'actors_bloc.dart';

@immutable
sealed class ActorsEvent {}

class GetMovieActorsEvent extends ActorsEvent {
  final int movieId;

  GetMovieActorsEvent(this.movieId);
}
