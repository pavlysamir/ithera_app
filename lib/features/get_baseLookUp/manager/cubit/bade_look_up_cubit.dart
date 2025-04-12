import 'package:bloc/bloc.dart';
import 'package:ithera_app/features/get_baseLookUp/data/models/allCities_model.dart';
import 'package:ithera_app/features/get_baseLookUp/data/repo/base_look.dart';
import 'package:meta/meta.dart';

part 'bade_look_up_state.dart';

class BadeLookUpCubit extends Cubit<BadeLookUpState> {
  BadeLookUpCubit({required this.baseLookRepo}) : super(BadeLookUpInitial());
  BaseLookRepo baseLookRepo;
  void getAllCities() async {
    emit(GettAllCitiesLoading());
    final result = await baseLookRepo.getAllCities();
    result.fold(
      (l) => emit(GettAllCitiesError(l)),
      (r) => emit(GettAllCitiesSuccess(r)),
    );
  }
}
