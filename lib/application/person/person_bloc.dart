import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/datasources/network_data_source/person_repository.dart';
import 'package:movie/data/models/person_dateil_model.dart';
import 'package:movie/data/models/person_image_model.dart';
import 'package:movie/data/models/person_movies.dart';

part 'person_event.dart';

part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc() : super(PersonInitial()) {
    on<GetPersonDetailEvent>(_getPersonDetailInfo);
    on<GetPersonPlayedMoviesEvent>(_getPersonPlayedMovies);
    on<GetPersonGalleryEvent>(_getPersonGallery);
  }

  PersonRepository repository = PersonRepository();

  FutureOr<void> _getPersonDetailInfo(
      GetPersonDetailEvent event, Emitter<PersonState> emit) async {
    try {
      emit(PersonMoviesLoadingState());
      final data = await repository.getPersonDetail(personId: event.personId);
      emit(PersonMovieDetailLoadedState(data: data));
    } catch (e) {
      emit(PersonMovieDetailLoadErrorState(msg: e.toString()));
    }
  }

  FutureOr<void> _getPersonPlayedMovies(
      GetPersonPlayedMoviesEvent event, Emitter<PersonState> emit) async {
    try {
      emit(PersonMoviesLoadingState());
      final data = await repository.getPersonFilmsWhichHePlayed(
          personId: event.personId);
      emit(PersonMoviesLoadedState(data: data));
    } catch (e) {
      emit(PersonMoviesLoadErrorState(msg: e.toString()));
    }
  }

  FutureOr<void> _getPersonGallery(
      GetPersonGalleryEvent event, Emitter<PersonState> emit) async {
    try {
      emit(PersonGalleryLoadingState());
      final data = await repository.getPersonImages(personId: event.personId);
      emit(PersonGalleryLoadedState(data: data));
    } catch (e) {
      emit(PersonGalleryLoadingErrorState(msg: e.toString()));
    }
  }
}
