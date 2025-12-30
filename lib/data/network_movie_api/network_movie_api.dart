import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/data/datasources/network_data_source/base_repository.dart';
import 'package:movie/data/models/actor_model.dart';
import 'package:movie/data/models/movies_detail_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/network_provider.dart';
import '../models/base_response.dart';
import '../models/default_model.dart';
import '../models/genre_model.dart';
import '../models/movie_gallery_model.dart';
import '../models/movie_videos.dart';
import '../models/movies_model.dart';
import '../models/trailer_model.dart';

part 'network_movie_api.g.dart';

@RestApi()
@singleton
abstract class NetworkMovieApi {
  @factoryMethod
  factory NetworkMovieApi(Dio dio) = _NetworkMovieApi;

  @GET('/movie/top_rated')
  Future<BaseResponse<MoviesResult>> getTopRatedMovies({@Query('page') int page = 1});

  @GET('/movie/upcoming')
  Future<BaseResponse<MoviesResult>> getUpcomingMovies({@Query('page') int page = 1});

  @GET('/movie/popular')
  Future<BaseResponse<MoviesResult>> getPopularMovies({@Query('page') int page = 1});

  @GET('/movie/{movieId}/credits')
  Future<BaseResponse<MovieDetailsPage>> getMovieDetails({@Path('movieID') required int movieId});

  @GET('/movie/{movieId}/videos')
  Future<BaseResponse<List<MovieVideos>>> getMovieVideos({@Path('movieId') required int movieId});

  @POST('/account/{accountId}/watchlist')
  Future<BaseResponse<DefaultModel>> addMovieWatchList(
      {required int? accountId, @Query('session_id') required String sessionId});

  @GET('/account/{accountId}/watchlist/movies')
  Future<BaseResponse<MoviesResult>> getWatchListMovies({
    @Path('accountId') required int accountId,
    @Query('session_id') required String sessionId,
  });

  @GET('/trending/tv/day')
  Future<BaseResponse<MoviesResult>> getTrendingTVShow({@Path('page') int page = 1});

  @GET('${IRoutes.movieVideos}/{movieId}/videos')
  Future<BaseResponse<List<TrailerVideo>>> getMovieTrailer({
    @Path('movieId') required int movieId,
  });

  @GET('/movie/{movieId}/recommendations')
  Future<BaseResponse<MoviesResult>> getRecommendedMovies({
    @Path('movieId') required int movieId,
  });

  @GET('/movie/{movieId}/images')
  Future<BaseResponse<List<ImageData>>> getMovieGallery({
    @Path('movieId') required int movieId,
  });

  @GET('/genre/movie/list')
  Future<BaseResponse<List<GenreModel>>> getMovieGenres();

  @GET('${IRoutes.search}/multi')
  Future<BaseResponse<MoviesResult>> search({
    @Query('query') required String keyword,
    @Query('page') required int page,
  });

  @GET('${IRoutes.search}/collection')
  Future<BaseResponse<MoviesResult>> searchCollection({
    @Query('query') required String keyword,
    @Query('page') required int page,
  });

  @GET('${IRoutes.search}/movie')
  Future<BaseResponse<MoviesResult>> searchMovie({
    @Query('query') required String keyword,
    @Query('page') required int page,
  });

  @GET('${IRoutes.search}/person')
  Future<BaseResponse<MoviesResult>> searchPerson({
    @Query('query') required String keyword,
    @Query('page') required int page,
  });

  @GET('${IRoutes.search}/tv')
  Future<BaseResponse<MoviesResult>> searchTv({
    @Query('query') required String keyword,
    @Query('page') required int page,
  });

  @GET('/movie/{movieId}/credits')
  Future<BaseResponse<List<ActorModel>>> fetchMovieActor({@Query('movieId') required int movieId});
}
