import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithera_app/features/get_baseLookUp/data/repo/base_look_repo.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_state.dart';

class BadeLookUpCubit extends Cubit<BadeLookUpState> {
  BadeLookUpCubit({required this.baseLookRepo})
      : super(const BadeLookUpState());

  final BaseLookRepo baseLookRepo;
  static BadeLookUpCubit get(context) => BlocProvider.of(context);

  void getAllCities() async {
    emit(state.copyWith(citiesStatus: LookupStatus.loading));

    final result = await baseLookRepo.getAllCities();
    if (isClosed) return;
    result.fold(
      (l) => emit(state.copyWith(
        citiesStatus: LookupStatus.error,
        errorMessage: l,
      )),
      (r) => emit(state.copyWith(
        citiesStatus: LookupStatus.success,
        cities: r,
      )),
    );
  }

  void getAllRegions(int cityId) async {
    emit(state.copyWith(regionsStatus: LookupStatus.loading));

    final result = await baseLookRepo.getAllRegions(cityId: cityId);
    if (isClosed) return;

    result.fold(
      (l) => emit(state.copyWith(
        regionsStatus: LookupStatus.error,
        errorMessage: l,
      )),
      (r) => emit(state.copyWith(
        regionsStatus: LookupStatus.success,
        regions: r,
      )),
    );
  }

  void getAllSpecialties() async {
    emit(state.copyWith(specialtiesStatus: LookupStatus.loading));

    final result = await baseLookRepo.getallSpecialties();
    if (isClosed) return;

    result.fold(
      (l) => emit(state.copyWith(
        specialtiesStatus: LookupStatus.error,
        errorMessage: l,
      )),
      (r) => emit(state.copyWith(
        specialtiesStatus: LookupStatus.success,
        specialties: r,
      )),
    );
  }

  String? getCityNameById(int id) {
    final city = state.cities?.firstWhere(
      (element) => element.id == id,
    );
    return city?.nameAr ?? 'مدينة غير معروفه';
  }
}
