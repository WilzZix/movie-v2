import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/datasources/local_data_source/shared_preference_service.dart';
import 'package:movie/data/datasources/network_data_source/network_movies_datasource.dart';
import 'package:movie/data/models/movies_model.dart';
import 'package:movie/domain/repositories/i_movies_repository.dart';

part 'see_all_movies_event.dart';

part 'see_all_movies_state.dart';

class SeeAllMoviesBloc extends Bloc<SeeAllMoviesEvent, SeeAllMoviesState> {
  final IMoviesRepository dataSource;
  SharedPreferenceService sharedPreferences = SharedPreferenceService();

  SeeAllMoviesBloc(this.dataSource) : super(SeeAllMoviesInitial()) {
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

          case MovieType.tvShow:
            final result = await dataSource.getTrendingTVShow(page: event.page);
            emit(SeeAllMoviesLoaded(result));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
