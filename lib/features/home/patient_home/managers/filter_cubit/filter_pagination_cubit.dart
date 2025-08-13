import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithera_app/features/home/patient_home/data/repos/patient_home_repo.dart';
import 'package:ithera_app/features/home/patient_home/managers/pagination_cubit/pagination_cubit.dart';

class FilterPaginationCubit extends Cubit<PaginationState> {
  final PatientHomeRepo _repo;
  int _currentPage = 1;
  int? _totalCount;
  bool _hasReachedEnd = false;

  // نفس الفلاتر
  String? _doctorName;
  int? _cityId;
  int? _specialtyId;
  bool? _gender;

  FilterPaginationCubit(this._repo) : super(PaginationInitial());

  void setFilters({
    String? doctorName,
    int? cityId,
    int? specialtyId,
    bool? gender,
  }) {
    _doctorName = doctorName;
    _cityId = cityId;
    _specialtyId = specialtyId;
    _gender = gender;
    _currentPage = 1;
    _totalCount = null;
    _hasReachedEnd = false;
    emit(PaginationInitial());
    fetchNextPage();
  }

  Future<void> fetchNextPage() async {
    if (state is PaginationLoading || _hasReachedEnd) return;

    emit(PaginationLoading(state.items));

    final result = await _repo.fetchDoctors(
      pageNumber: _currentPage,
      doctorName: _doctorName,
      cityId: _cityId,
      fileTypeId: _specialtyId,
      gender: _gender,
    );

    result.fold(
      (error) => emit(PaginationError(error)),
      (data) {
        _totalCount ??= data.count;
        final items =
            _currentPage == 1 ? data.items : [...state.items, ...data.items];

        if (data.items.isEmpty || items.length >= _totalCount!) {
          _hasReachedEnd = true;
          emit(PaginationLoadedEnd(items));
          return;
        }

        _currentPage++;
        emit(PaginationLoaded(items));
      },
    );
  }
}
