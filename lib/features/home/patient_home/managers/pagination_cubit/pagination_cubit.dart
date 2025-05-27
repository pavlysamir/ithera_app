import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ithera_app/features/home/patient_home/data/repos/patient_home_repo.dart';
part 'pagination_state.dart';

class PaginationCubit extends Cubit<PaginationState> {
  final PatientHomeRepo _patientHomeRepo;
  int _currentOffset = 1;
  PaginationCubit(this._patientHomeRepo) : super(PaginationInitial());

  Future<void> fetchItems() async {
    if (state is PaginationLoading) return;
    emit(PaginationLoading(state.items)); // <-- خد العناصر الحالية
    final result = await _patientHomeRepo.fetchDoctors(_currentOffset);
    result.fold(
      (error) {
        emit(PaginationError(error));
      },
      (data) {
        if (data.items.isEmpty) {
          emit(PaginationLoadedEnd(state.items));
        } else {
          _currentOffset += 1;
          emit(PaginationLoaded([...state.items, ...data.items]));
        }
      },
    );
  }
}
