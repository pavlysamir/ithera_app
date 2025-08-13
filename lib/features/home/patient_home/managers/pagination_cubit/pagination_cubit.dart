import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ithera_app/features/home/patient_home/data/repos/patient_home_repo.dart';

part 'pagination_state.dart';

class PaginationCubit extends Cubit<PaginationState> {
  final PatientHomeRepo _patientHomeRepo;
  int _currentOffset = 1;
  int? _totalCount;
  bool _hasReachedEnd = false;
  bool _hasInitialized = false;

  // for search functionality
  String? _lastSearchQuery;

  PaginationCubit(this._patientHomeRepo) : super(PaginationInitial());

  // Method جديدة للتأكد من الـ initialization
  Future<void> initializeIfNeeded() async {
    if (!_hasInitialized && state is PaginationInitial) {
      _hasInitialized = true;
      await fetchItems();
    }
  }

  Future<void> fetchItems({String? searchQuery}) async {
    // لو الكلمة الجديدة مختلفة عن آخر كلمة → اعمل reset
    if (_lastSearchQuery != searchQuery && searchQuery != null) {
      _currentOffset = 1;
      _totalCount = null;
      _hasReachedEnd = false;
      emit(PaginationInitial());
    }

    // خزن الكلمة للمرات الجاية (سواء جاية من السيرش أو null من الـ scroll)
    _lastSearchQuery = searchQuery ?? _lastSearchQuery;

    if (state is PaginationLoading || _hasReachedEnd) return;

    emit(PaginationLoading(state.items));

    final result = await _patientHomeRepo.fetchDoctors(
      pageNumber: _currentOffset,
      doctorName: _lastSearchQuery, // 👈 استخدم آخر كلمة محفوظة
    );

    result.fold(
      (error) => emit(PaginationError(error)),
      (data) {
        _totalCount ??= data.count;

        final allItems =
            _currentOffset == 1 ? data.items : [...state.items, ...data.items];

        if (data.items.isEmpty || allItems.length >= _totalCount!) {
          _hasReachedEnd = true;
          emit(PaginationLoadedEnd(allItems));
          return;
        }

        _currentOffset++;
        emit(PaginationLoaded(allItems));
      },
    );
  }

  void reset() {
    _currentOffset = 1;
    _totalCount = null;
    _hasReachedEnd = false;
    _hasInitialized = false; // مهم نعمل reset للـ initialization كمان
    _lastSearchQuery = null;

    emit(PaginationInitial());
  }

  String getAllNameAr(List<dynamic> list) {
    return list.map((e) => e['nameAr'].toString()).join('، ');
  }

  Future<void> filter({String? docName, int? cityId, int? specialtyId}) async {}
}
