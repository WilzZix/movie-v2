import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/data/models/actor_model.dart';

import '../../../domain/repositories/i_movies_repository.dart';

part 'actors_event.dart';

part 'actors_state.dart';

class ActorsBloc extends Bloc<ActorsEvent, ActorsState> {
  ActorsBloc(this.dataSource) : super(ActorsInitial()) {
    on<GetMovieActorsEvent>(_fetchMovieActors);
  }

  final IMoviesRepository dataSource;

  FutureOr<void> _fetchMovieActors(
      GetMovieActorsEvent event, Emitter<ActorsState> emit) async {
    emit(MovieActorsLoadingState());
    try {
      final result = await dataSource.fetchMovieActor(movieId: event.movieId);
      emit(MovieActorsLoadedState(result));
    } catch (e) {
      emit(MovieActorLoadingErrorState(e.toString()));
    }
  }
}
