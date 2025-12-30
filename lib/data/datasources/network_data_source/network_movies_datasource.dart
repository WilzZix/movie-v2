import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/core/network_provider.dart';
import 'package:movie/data/datasources/network_data_source/base_repository.dart';
import 'package:movie/data/models/actor_model.dart';
import 'package:movie/data/models/default_model.dart';
import 'package:movie/data/models/genre_model.dart';
import 'package:movie/data/models/movie_gallery_model.dart';
import 'package:movie/data/models/movie_videos.dart';
import 'package:movie/data/models/movies_detail_model.dart';
import 'package:movie/data/models/movies_model.dart';
import 'package:movie/data/models/result_entity.dart';
import 'package:movie/data/models/trailer_model.dart';
import 'package:movie/data/network_movie_api/network_movie_api.dart';
import 'package:movie/domain/repositories/i_movies_repository.dart';

import '../../../core/utils/error_to_user_message.dart';

@Singleton(as: IMoviesRepository)
class NetworkMoviesDataSource extends BaseRepository implements IMoviesRepository {
  final NetworkMovieApi _networkMovieApi;

  NetworkMoviesDataSource(this._networkMovieApi);

  @override
  Future<ResultEntity<MoviesResult>> getTopRatedMovies({required int page}) async {
    return safeCall(() => _networkMovieApi.getTopRatedMovies(page: page));
  }

  @override
  Future<ResultEntity<MoviesResult>> getUpcomingMovies({required int page}) async {
    return safeCall(() => _networkMovieApi.getUpcomingMovies());
  }

  @override
  Future<ResultEntity<MoviesResult>> getPopularMovies({required int page}) async {
    return safeCall(() => _networkMovieApi.getPopularMovies());
  }

  @override
  Future<ResultEntity<MovieDetailsPage>> getMovieDetails({required int movieId}) async {
    return safeCall(() => _networkMovieApi.getMovieDetails(movieId: movieId));
  }

  @override
  Future<ResultEntity<List<ActorModel>>> fetchMovieActor({required int movieId}) async {
    return safeCall(() => _networkMovieApi.fetchMovieActor(movieId: movieId));
  }

  @override
  Future<ResultEntity<List<MovieVideos>>> getMovieVideos({required int movieId}) async {
    return safeCall(() => _networkMovieApi.getMovieVideos(movieId: movieId));
  }

  @override
  Future<ResultEntity<DefaultModel>> addMovieWatchList(
      {required int movieId, required int? accountId, required String sessionId}) async {
    return safeCall(() => _networkMovieApi.addMovieWatchList(accountId: accountId, sessionId: sessionId));
  }

  @override
  Future<ResultEntity<MoviesResult>> getWatchListMovies({
    required int accountId,
    required String sessionId,
  }) async {
    return safeCall(() => _networkMovieApi.getWatchListMovies(accountId: accountId, sessionId: sessionId));
  }

  @override
  Future<ResultEntity<MoviesResult>> getTrendingTVShow({required int page}) async {
    return safeCall(() => _networkMovieApi.getTrendingTVShow());
  }

  @override
  Future<ResultEntity<List<TrailerVideo>>> getMovieTrailer({required int movieId}) async {
    return safeCall(() => _networkMovieApi.getMovieTrailer(movieId: movieId));
  }

  @override
  Future<ResultEntity<MoviesResult>> getRecommendedMovies({required int movieId}) async {
    return safeCall(() => _networkMovieApi.getRecommendedMovies(movieId: movieId));
  }

  @override
  Future<ResultEntity<List<ImageData>>> getMovieGallery({required int movieId}) async {
    return safeCall(() => _networkMovieApi.getMovieGallery(movieId: movieId));
  }

  @override
  Future<ResultEntity<List<GenreModel>>> getMovieGenres() async {
    return safeCall(() => _networkMovieApi.getMovieGenres());
  }

  @override
  Future<ResultEntity<MoviesResult>> search({
    required String keyword,
    required int page,
  }) async {
    return safeCall(() => _networkMovieApi.search(keyword: keyword, page: page));
  }

  @override
  Future<ResultEntity<MoviesResult>> searchCollection({required String keyword, required int page}) async {
    return safeCall(() => _networkMovieApi.searchCollection(keyword: keyword, page: page));
  }

  @override
  Future<ResultEntity<MoviesResult>> searchMovie({required String keyword, required int page}) async {
    return safeCall(() => _networkMovieApi.searchMovie(keyword: keyword, page: page));
  }

  @override
  Future<ResultEntity<MoviesResult>> searchPerson({required String keyword, required int page}) async {
    return safeCall(() => _networkMovieApi.searchPerson(keyword: keyword, page: page));
  }

  @override
  Future<ResultEntity<MoviesResult>> searchTv({required String keyword, required int page}) async {
    return safeCall(() => _networkMovieApi.searchTv(keyword: keyword, page: page));
  }
}
//5098792b57de08b1d83cdd2235dc6cd03714e0cc - wilzix
//7b82dde7ac6df73a63be7600003899f23451e31c - Nodirbekwilzix
