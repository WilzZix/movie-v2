import 'package:dio/dio.dart';
import 'package:movie/core/network_provider.dart';
import 'package:movie/data/models/actor_model.dart';
import 'package:movie/data/models/default_model.dart';
import 'package:movie/data/models/movie_videos.dart';
import 'package:movie/data/models/movies_detail_model.dart';
import 'package:movie/data/models/movies_model.dart';
import 'package:movie/domain/repositories/i_movies_repository.dart';

import '../../../core/utils/error_to_user_message.dart';

class NetworkMoviesDataSource extends IMoviesRepository {
  @override
  Future<MoviesResult> getTopRatedMovies({required int page}) async {
    try {
      final Response response = await NetworkProvider.dio.get(
        IRoutes.topRated,
        queryParameters: {
          'page': page,
        },
      );
      return MoviesResult.fromJson(response.data ?? {});
    } on DioExceptions catch (e) {
      throw e.getServerError;
    }
  }

  @override
  Future<MoviesResult> getUpcomingMovies({required int page}) async {
    try {
      final Response response = await NetworkProvider.dio.get(
        IRoutes.upcomingMovies,
        queryParameters: {'page': page},
      );
      return MoviesResult.fromJson(response.data ?? {});
    } on DioExceptions catch (e) {
      throw e.getServerError;
    }
  }

  @override
  Future<MoviesResult> getPopularMovies({required int page}) async {
    try {
      final Response response = await NetworkProvider.dio.get(
        IRoutes.popularMovies,
        queryParameters: {'page': page},
      );
      return MoviesResult.fromJson(response.data ?? {});
    } on DioExceptions catch (e) {
      throw e.getServerError;
    }
  }

  @override
  Future<MovieDetailsPage> getMovieDetails({required int movieId}) async {
    try {
      final Response response =
          await NetworkProvider.dio.get('/movie/$movieId');
      return MovieDetailsPage.fromJson(response.data ?? {});
    } on DioExceptions catch (e) {
      throw e.getServerError;
    }
  }

  @override
  Future<List<ActorModel>> fetchMovieActor({required int movieId}) async {
    try {
      final Response response =
          await NetworkProvider.dio.get('/movie/$movieId/credits');
      return ActorModel.fetchData(response.data ?? {});
    } on DioExceptions catch (e) {
      throw e.getServerError;
    }
  }

  @override
  Future<MoviesResult> searchMovies({
    required String keyword,
    required int page,
  }) async {
    try {
      Map<String, dynamic> queryParams = {'page': page};
      final Response response = await NetworkProvider.dio.get(
          '${IRoutes.search}/movie?query=$keyword&include_adult=false',
          queryParameters: queryParams);
      return MoviesResult.fromJson(response.data ?? {});
    } on DioExceptions catch (e) {
      throw e.getServerError;
    }
  }

  @override
  Future<List<MovieVideos>> getMovieVideos({required int movieId}) async {
    try {
      final Response response =
          await NetworkProvider.dio.get('/movie/$movieId/videos');
      return MovieVideos.fetchData(response.data ?? {});
    } on DioExceptions catch (e) {
      throw e.getServerError;
    }
  }

  @override
  Future<DefaultModel> addMovieWatchList(
      {required int movieId,
      required int? accountId,
      required String sessionId}) async {
    try {
      final Response response = await NetworkProvider.dio.post(
        '/account/$accountId/watchlist',
        queryParameters: {
          "media_type": "movie",
          "media_id": movieId,
          "watchlist": true,
          // 'api_key': '9eb3a3779d0206d18a39ac0f045f11c2',
          'session_id': sessionId
        },
      );
      return DefaultModel.fromJson(response.data);
    } on DioExceptions catch (e) {
      throw e.getServerError;
    }
  }

  @override
  Future<MoviesResult> getWatchListMovies({
    required int accountId,
    required String sessionId,
  }) async {
    try {
      final Response response = await NetworkProvider.dio.get(
        '/account/$accountId/watchlist/movies',
        queryParameters: {
          'session_id': sessionId,
        },
      );
      return MoviesResult.fromJson(response.data ?? {});
    } on DioExceptions catch (e) {
      throw e.getServerError;
    }
  }
}
//5098792b57de08b1d83cdd2235dc6cd03714e0cc - wilzix
//7b82dde7ac6df73a63be7600003899f23451e31c - Nodirbekwilzix