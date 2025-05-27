part of 'pagination_cubit.dart';

abstract class PaginationState extends Equatable {
  final List<dynamic> items;
  const PaginationState(this.items);
  @override
  List<Object> get props => [items];
}

class PaginationInitial extends PaginationState {
  PaginationInitial() : super([]);
}

class PaginationLoading extends PaginationState {
  const PaginationLoading(super.items);
}

class PaginationLoaded extends PaginationState {
  const PaginationLoaded(super.items);
}

class PaginationLoadedEnd extends PaginationState {
  const PaginationLoadedEnd(super.items);
}

class PaginationError extends PaginationState {
  final String message;
  PaginationError(this.message) : super([]);
  @override
  List<Object> get props => [message];
}
