import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/models/genre_model.dart';
import 'package:movie/domain/repositories/i_movies_repository.dart';

part 'filter_genre_state.dart';

class FilterGenreCubit extends Cubit<FilterGenreState> {
  FilterGenreCubit(this.networkMoviesDataSource) : super(FilterGenreInitial());
  final IMoviesRepository networkMoviesDataSource;

  Future<void> loadMovieGenres() async {
    emit(MovieGenreLoadingState());
    try {
      List<GenreModel> data = await networkMoviesDataSource.getMovieGenres();
      emit(MovieGenresLoadedState(data));
    } catch (e) {
      emit(MovieGenresLoadingErrorState(e.toString()));
    }
  }
}
