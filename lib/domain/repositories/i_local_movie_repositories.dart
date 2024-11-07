import 'package:movie/data/models/movies_model.dart';

abstract class ILocalMovieRepository {
  Future<Result> getPreviousSearchMovies();

  Future<void> cacheData(Result data);
}
