import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/datasources/network_data_source/network_movies_datasource.dart';
import 'package:movie/data/models/genre_model.dart';

part 'filter_genre_state.dart';

class FilterGenreCubit extends Cubit<FilterGenreState> {
  FilterGenreCubit() : super(FilterGenreInitial());
  NetworkMoviesDataSource networkMoviesDataSource = NetworkMoviesDataSource();

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
