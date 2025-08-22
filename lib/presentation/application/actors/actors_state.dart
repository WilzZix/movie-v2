part of 'actors_bloc.dart';

@immutable
sealed class ActorsState {}

final class ActorsInitial extends ActorsState {}

///Fetching Movie Actors
class MovieActorsLoadingState extends ActorsState {}

class MovieActorsLoadedState extends ActorsState {
  final List<ActorModel> data;

  MovieActorsLoadedState(this.data);
}

class MovieActorLoadingErrorState extends ActorsState {
  final String msg;

  MovieActorLoadingErrorState(this.msg);
}
