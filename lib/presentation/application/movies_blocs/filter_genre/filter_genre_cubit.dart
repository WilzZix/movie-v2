import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/models/genre_model.dart';
import 'package:movie/data/models/result_entity.dart';
import 'package:movie/domain/repositories/i_movies_repository.dart';

part 'filter_genre_state.dart';

class FilterGenreCubit extends Cubit<FilterGenreState> {
  FilterGenreCubit(this.networkMoviesDataSource) : super(FilterGenreInitial());
  final IMoviesRepository networkMoviesDataSource;

  Future<void> loadMovieGenres() async {
    emit(MovieGenreLoadingState());
    final result = await networkMoviesDataSource.getMovieGenres();
    switch (result) {
      case SuccessEntity():
        emit(MovieGenresLoadedState(result.data));

      case FailureEntity():
        emit(MovieGenresLoadingErrorState(result.exception.toString()));
    }
  }
}
