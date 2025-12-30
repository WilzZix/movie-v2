import 'package:movie/data/models/actor_model.dart';
import 'package:movie/data/models/default_model.dart';
import 'package:movie/data/models/genre_model.dart';
import 'package:movie/data/models/movie_gallery_model.dart';
import 'package:movie/data/models/movies_detail_model.dart';
import 'package:movie/data/models/movies_model.dart';
import 'package:movie/data/models/result_entity.dart';
import 'package:movie/data/models/trailer_model.dart';

import '../../data/models/movie_videos.dart';

abstract class IMoviesRepository {
  Future<ResultEntity<MoviesResult>> getTopRatedMovies({required int page});

  Future<ResultEntity<MoviesResult>> getUpcomingMovies({required int page});

  Future<ResultEntity<MoviesResult>> getPopularMovies({required int page});

  Future<ResultEntity<MoviesResult>> getTrendingTVShow({required int page});

  Future<ResultEntity<MovieDetailsPage>> getMovieDetails({required int movieId});

  Future<ResultEntity<List<MovieVideos>>> getMovieVideos({required int movieId});

  Future<ResultEntity<List<ActorModel>>> fetchMovieActor({required int movieId});

  Future<ResultEntity<MoviesResult>> search({
    required String keyword,
    required int page,
  });

  Future<ResultEntity<MoviesResult>> searchMovie({
    required String keyword,
    required int page,
  });

  Future<ResultEntity<MoviesResult>> searchTv({
    required String keyword,
    required int page,
  });

  Future<ResultEntity<MoviesResult>> searchPerson({
    required String keyword,
    required int page,
  });

  Future<ResultEntity<MoviesResult>> searchCollection({
    required String keyword,
    required int page,
  });

  Future<ResultEntity<DefaultModel>> addMovieWatchList({
    required int movieId,
    required int accountId,
    required String sessionId,
  });

  Future<ResultEntity<MoviesResult>> getWatchListMovies({
    required int accountId,
    required String sessionId,
  });

  Future<ResultEntity<List<TrailerVideo>>> getMovieTrailer({required int movieId});

  Future<ResultEntity<MoviesResult>> getRecommendedMovies({required int movieId});

  Future<ResultEntity<List<ImageData>>> getMovieGallery({required int movieId});

  Future<ResultEntity<List<GenreModel>>> getMovieGenres();
}
