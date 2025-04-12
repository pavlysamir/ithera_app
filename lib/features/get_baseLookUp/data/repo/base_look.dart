import 'package:dartz/dartz.dart';
import 'package:ithera_app/core/api/api_consumer.dart';
import 'package:ithera_app/core/api/end_ponits.dart';
import 'package:ithera_app/core/errors/exceptions.dart';
import 'package:ithera_app/features/get_baseLookUp/data/models/allCities_model.dart';

class BaseLookRepo {
  final ApiConsumer api;
  BaseLookRepo({required this.api});

  Future<Either<String, List<CityModel>>> getAllCities() async {
    try {
      final response = await api.get(
        EndPoint.getAllCities,
      );
      List<CityModel> cities = [];
      for (var city in response) {
        cities.add(CityModel.fromJson(city));
      }

      return Right(cities);
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? '');
    }
  }
}
