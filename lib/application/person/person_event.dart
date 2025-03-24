part of 'person_bloc.dart';

@immutable
sealed class PersonEvent {}

class GetPersonDetailEvent extends PersonEvent {
  final int personId;

  GetPersonDetailEvent({required this.personId});
}

class GetPersonPlayedMoviesEvent extends PersonEvent {
  final int personId;

  GetPersonPlayedMoviesEvent({required this.personId});
}

class GetPersonGalleryEvent extends PersonEvent {
  final int personId;

  GetPersonGalleryEvent({required this.personId});
}
