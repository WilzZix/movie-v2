import 'package:dio/dio.dart';
import 'package:movie/core/network_provider.dart';
import 'package:movie/core/utils/error_to_user_message.dart';
import 'package:movie/data/models/person_dateil_model.dart';
import 'package:movie/data/models/person_image_model.dart';
import 'package:movie/data/models/person_movies.dart';
import 'package:movie/domain/repositories/i_person.dart';

class PersonRepository extends IPerson {
  @override
  Future<PersonDetailModel> getPersonDetail({required int personId}) async {
    try {
      final Response response = await NetworkProvider.dio.get(
        "${IRoutes.personDetail}/$personId",
      );
      return PersonDetailModel.fromJson(response.data ?? {});
    } on DioExceptions catch (e) {
      throw e.getServerError;
    }
  }

  @override
  Future<List<Movie>> getPersonFilmsWhichHePlayed(
      {required int personId}) async {
    try {
      final Response response = await NetworkProvider.dio.get(
        "${IRoutes.personDetail}/$personId/movie_credits",
      );
      return Movie.fetchData(response.data ?? {});
    } on DioExceptions catch (e) {
      throw e.getServerError;
    }
  }

  @override
  Future<List<ImageDetailModel>> getPersonImages(
      {required int personId}) async {
    try {
      final Response response = await NetworkProvider.dio.get(
        "${IRoutes.personDetail}/$personId/images",
      );
      return ImageDetailModel.fetchData(response.data ?? {});
    } on DioExceptions catch (e) {
      throw e.getServerError;
    }
  }
}
