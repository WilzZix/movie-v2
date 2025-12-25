// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movie/core/dio/dio_provider.dart' as _i500;
import 'package:movie/data/api/movie_api.dart' as _i732;
import 'package:movie/data/datasources/local_data_source/shared_preference_service.dart'
    as _i1066;
import 'package:movie/data/datasources/network_data_source/firebase_auth.dart'
    as _i819;
import 'package:movie/data/datasources/network_data_source/moviedb.dart'
    as _i1043;
import 'package:movie/data/datasources/network_data_source/network_movies_datasource.dart'
    as _i549;
import 'package:movie/domain/repositories/i_firebase_auth.dart' as _i1053;
import 'package:movie/domain/repositories/i_movie_auth.dart' as _i734;
import 'package:movie/domain/repositories/i_movies_repository.dart' as _i589;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioProvider = _$DioProvider();
    gh.singleton<_i1066.SharedPreferenceService>(
        () => _i1066.SharedPreferenceService());
    gh.singletonAsync<_i361.Dio>(() => dioProvider.getAuthorizedDioClient(
        host: gh<String>(instanceName: 'Host')));
    gh.singleton<_i1053.IFirebaseAuth>(() => _i819.FirebaseAuthImpl());
    gh.singletonAsync<_i732.MovieApi>(
        () async => _i732.MovieApi(await getAsync<_i361.Dio>()));
    gh.singletonAsync<_i734.MovieDBAuth>(() async =>
        _i1043.FirebaseAuthRepository(await getAsync<_i732.MovieApi>()));
    gh.singleton<_i589.IMoviesRepository>(
        () => _i549.NetworkMoviesDataSource());
    return this;
  }
}

class _$DioProvider extends _i500.DioProvider {}
