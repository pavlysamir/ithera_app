import 'package:ithera_app/features/get_baseLookUp/data/models/allCities_model.dart';
import 'package:ithera_app/features/get_baseLookUp/data/models/allRegions_model.dart';
import 'package:ithera_app/features/get_baseLookUp/data/models/allSpicialization_model.dart';

enum LookupStatus { initial, loading, success, error }

class BadeLookUpState {
  final LookupStatus citiesStatus;
  final LookupStatus regionsStatus;
  final LookupStatus specialtiesStatus;
  final List<CityModel>? cities;
  final List<RegionModel>? regions;
  final List<SpecializationModel>? specialties;
  final String? errorMessage;

  const BadeLookUpState({
    this.citiesStatus = LookupStatus.initial,
    this.regionsStatus = LookupStatus.initial,
    this.specialtiesStatus = LookupStatus.initial,
    this.specialties,
    this.cities,
    this.regions,
    this.errorMessage,
  });

  BadeLookUpState copyWith({
    LookupStatus? citiesStatus,
    LookupStatus? regionsStatus,
    LookupStatus? specialtiesStatus,
    List<SpecializationModel>? specialties,
    List<CityModel>? cities,
    List<RegionModel>? regions,
    String? errorMessage,
  }) {
    return BadeLookUpState(
      citiesStatus: citiesStatus ?? this.citiesStatus,
      regionsStatus: regionsStatus ?? this.regionsStatus,
      specialtiesStatus: specialtiesStatus ?? this.specialtiesStatus,
      specialties: specialties ?? this.specialties,
      cities: cities ?? this.cities,
      regions: regions ?? this.regions,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
