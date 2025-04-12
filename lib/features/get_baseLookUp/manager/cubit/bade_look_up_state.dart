part of 'bade_look_up_cubit.dart';

@immutable
sealed class BadeLookUpState {}

final class BadeLookUpInitial extends BadeLookUpState {}

final class GettAllCitiesLoading extends BadeLookUpState {}

final class GettAllCitiesSuccess extends BadeLookUpState {
  final List<CityModel> cities;
  GettAllCitiesSuccess(this.cities);
}

final class GettAllCitiesError extends BadeLookUpState {
  final String error;
  GettAllCitiesError(this.error);
}

final class GettAllRegionsLoading extends BadeLookUpState {}

final class GettAllRegionsSuccess extends BadeLookUpState {
  final List<RegionModel> regions;
  GettAllRegionsSuccess(this.regions);
}

final class GettAllRegionsError extends BadeLookUpState {
  final String error;
  GettAllRegionsError(this.error);
}
