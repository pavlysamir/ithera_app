part of 'booking_cubit.dart';

@immutable
sealed class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

final class BookingInitial extends BookingState {
  const BookingInitial();
}

final class SuccessfulPickImage extends BookingState {
  final File imageFile;

  const SuccessfulPickImage(this.imageFile);
}

final class FailPickImage extends BookingState {
  const FailPickImage();
}

final class BookingLoading extends BookingState {
  const BookingLoading();
}

final class SuccessfulBookSession extends BookingState {
  final String successMessage;

  const SuccessfulBookSession(this.successMessage);

  @override
  List<Object> get props => [successMessage];
}

final class FailBookSession extends BookingState {
  final String errorMessage;

  const FailBookSession(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
