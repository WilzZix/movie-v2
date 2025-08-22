import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/data/datasources/network_data_source/network_movies_datasource.dart';
import 'package:movie/data/models/actor_model.dart';

part 'actors_event.dart';

part 'actors_state.dart';

class ActorsBloc extends Bloc<ActorsEvent, ActorsState> {
  ActorsBloc() : super(ActorsInitial()) {
    on<GetMovieActorsEvent>(_fetchMovieActors);
  }

  NetworkMoviesDataSource dataSource = NetworkMoviesDataSource();

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
