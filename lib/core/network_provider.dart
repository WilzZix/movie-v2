import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie/core/utils/interceptor.dart';
import 'package:movie/data/datasources/local_data_source/shared_preference_service.dart';

class NetworkProvider {
  static late Dio dio;
  final SharedPreferenceService sharedPreferenceService;

  NetworkProvider(this.sharedPreferenceService);

  static Future<void> initApp() async {
    dio = Dio(
      BaseOptions(
        baseUrl: IRoutes.baseUrl,
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNmY2MmM3YmIxNTczNTM0ZjU4MWQwNDdlMjUwNjllOCIsIm5iZiI6MTczMDAxOTk1My4xODgzNjUsInN1YiI6IjVmODA5NzBiMDIxY2VlMDAzNTM5ZjQxOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0jy86fHM-xtnCYl_kuQrh3wth5qmWtSbYHf6wkkeltU',
          'accept': 'application-json',
        },
        queryParameters: {
          'language': SharedPreferenceService.getAppLanguage()!.code,
          'region': SharedPreferenceService.getAppLanguage()!.code,
        },
      ),
    )..interceptors.addAll(
        [
          DioInterceptor(),
          if (kDebugMode)
            LogInterceptor(
              responseHeader: true,
              responseBody: true,
              requestBody: true,
              logPrint: (error) => log(
                error.toString(),
              ),
            ),
        ],
      );
  }
}

class IRoutes {
  static const String baseUrl = 'https://movie_api.themoviedb.org/3';
  static const String topRated = '/movie/top_rated';
  static const String popularMovies = '/movie/popular';
  static const String upcomingMovies = '/movie/upcoming';
  static const String nowPlaying = '/movie/now_playing';
  static const String search = '/search';
  static const String trending = '/trending/tv/day';
  static const String movieVideos = '/movie/';
  static const String personDetail = '/person/';
}
