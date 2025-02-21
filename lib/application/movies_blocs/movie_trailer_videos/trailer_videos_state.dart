part of 'trailer_videos_cubit.dart';

@immutable
sealed class TrailerVideosState {}

final class TrailerVideosInitial extends TrailerVideosState {}

class TrailerVideosLoadingState extends TrailerVideosState {}

class TrailerVideosLoadedState extends TrailerVideosState {
  final List<TrailerVideo> data;

  TrailerVideosLoadedState({required this.data});
}

class TrailerVideosLoadErrorState extends TrailerVideosState {
  final String msg;

  TrailerVideosLoadErrorState(this.msg);
}
