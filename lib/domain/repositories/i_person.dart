import 'package:movie/data/models/person_dateil_model.dart';
import 'package:movie/data/models/person_image_model.dart';
import 'package:movie/data/models/person_movies.dart';

abstract class IPerson {
  Future<PersonDetailModel> getPersonDetail({required int personId});

  Future<List<ImageDetailModel>> getPersonImages({required int personId});

  Future<List<Movie>> getPersonFilmsWhichHePlayed({required int personId});
}
