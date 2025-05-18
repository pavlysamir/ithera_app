import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PaginatedCubit<T> extends Cubit<List<T>> {
  PaginatedCubit(this.fetchFunction) : super([]);

  final Future<List<T>> Function(int page) fetchFunction;

  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMore = true;

  Future<void> loadInitial() async {
    currentPage = 1;
    hasMore = true;
    final result = await fetchFunction(currentPage);
    emit(result);
  }

  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore) return;
    isLoadingMore = true;
    currentPage++;
    final newItems = await fetchFunction(currentPage);
    if (newItems.isEmpty) {
      hasMore = false;
    } else {
      emit([...state, ...newItems]);
    }
    isLoadingMore = false;
  }
}
