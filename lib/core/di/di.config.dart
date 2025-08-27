// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
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
    gh.singleton<_i1053.IFirebaseAuth>(() => _i819.FirebaseAuthImpl());
    gh.singleton<_i734.MovieDBAuth>(() => _i1043.FirebaseAuthRepository());
    gh.singleton<_i589.IMoviesRepository>(
        () => _i549.NetworkMoviesDataSource());
    return this;
  }
}
