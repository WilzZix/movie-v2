import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/datasources/local_data_source/shared_preference_service.dart';
import 'package:movie/data/datasources/network_data_source/network_movies_datasource.dart';
import 'package:movie/data/models/movies_model.dart';

part 'see_all_movies_event.dart';

part 'see_all_movies_state.dart';

class SeeAllMoviesBloc extends Bloc<SeeAllMoviesEvent, SeeAllMoviesState> {
  NetworkMoviesDataSource dataSource = NetworkMoviesDataSource();
  SharedPreferenceService sharedPreferences = SharedPreferenceService();

  SeeAllMoviesBloc() : super(SeeAllMoviesInitial()) {
    on<FetchSeeAllMoviesEvent>((event, emit) async {
      try {
        switch (event.type) {
          case MovieType.topMoviesPick:
            final result = await dataSource.getTopRatedMovies(page: event.page);
            emit(SeeAllMoviesLoaded(result));
          case MovieType.upcoming:
            final result = await dataSource.getUpcomingMovies(page: event.page);
            emit(SeeAllMoviesLoaded(result));
          case MovieType.popular:
            final result = await dataSource.getPopularMovies(page: event.page);
            emit(SeeAllMoviesLoaded(result));
        }
      } catch (e) {}
    });
  }
}
