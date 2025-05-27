import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ithera_app/features/home/patient_home/data/repos/patient_home_repo.dart';

part 'pagination_state.dart';

class PaginationCubit extends Cubit<PaginationState> {
  final PatientHomeRepo _patientHomeRepo;
  int _currentOffset = 1;
  int? _totalCount;
  bool _hasReachedEnd = false;

  PaginationCubit(this._patientHomeRepo) : super(PaginationInitial());

  Future<void> fetchItems() async {
    // تحقق إذا كنا بالفعل بنحمّل أو خلصنا تحميل كل العناصر
    if (state is PaginationLoading || _hasReachedEnd) return;

    emit(PaginationLoading(
        state.items)); // حافظ على العناصر الحالية أثناء التحميل

    final result = await _patientHomeRepo.fetchDoctors(_currentOffset);
    result.fold(
      (error) {
        emit(PaginationError(error));
      },
      (data) {
        // تعيين التوتال مرة واحدة فقط
        _totalCount ??= data.count;

        final allItems = [...state.items, ...data.items];

        // لو مفيش عناصر جديدة راجعة أو وصلنا للنهاية
        if (data.items.isEmpty || allItems.length >= _totalCount!) {
          _hasReachedEnd = true;
          emit(PaginationLoadedEnd(allItems));
          return;
        }

        // في حالة وجود عناصر جديدة
        _currentOffset++;
        emit(PaginationLoaded(allItems));
      },
    );
  }

  void reset() {
    _currentOffset = 1;
    _totalCount = null;
    _hasReachedEnd = false;
    emit(PaginationInitial());
  }

  String getAllNameAr(List<dynamic> list) {
    return list.map((e) => e['nameAr'].toString()).join('، ');
  }
}
