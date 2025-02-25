import 'package:movie/data/models/actor_model.dart';
import 'package:movie/data/models/default_model.dart';
import 'package:movie/data/models/movie_gallery_model.dart';
import 'package:movie/data/models/movies_detail_model.dart';
import 'package:movie/data/models/movies_model.dart';
import 'package:movie/data/models/trailer_model.dart';

import '../../data/models/movie_videos.dart';

abstract class IMoviesRepository {
  Future<MoviesResult> getTopRatedMovies({required int page});

  Future<MoviesResult> getUpcomingMovies({required int page});

  Future<MoviesResult> getPopularMovies({required int page});

  Future<MoviesResult> getTrendingTVShow({required int page});

  Future<MovieDetailsPage> getMovieDetails({required int movieId});

  Future<List<MovieVideos>> getMovieVideos({required int movieId});

  Future<List<ActorModel>> fetchMovieActor({required int movieId});

  Future<MoviesResult> searchMovies({
    required String keyword,
    required int page,
  });

  Future<DefaultModel> addMovieWatchList({
    required int movieId,
    required int accountId,
    required String sessionId,
  });

  Future<MoviesResult> getWatchListMovies({
    required int accountId,
    required String sessionId,
  });

  Future<List<TrailerVideo>> getMovieTrailer({required int movieId});

  Future<MoviesResult> getRecommendedMovies({required int movieId});

  Future<List<ImageData>> getMovieGallery({required int movieId});
}
