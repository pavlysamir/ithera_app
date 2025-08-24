import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ithera_app/features/notification/data/models/booking_details_model.dart';
import 'package:ithera_app/features/notification/data/models/notifications_model.dart';
import 'package:ithera_app/features/notification/data/repo/notification_repo.dart';
import 'package:path_provider/path_provider.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._notificationsRepo) : super(NotificationsInitial());

  final NotificationRepo _notificationsRepo;

  Future<void> getNotificatios({required int role, required int userId}) async {
    emit(GetNotificationLoading());
    final result = await _notificationsRepo.getNotification(
      role: role,
      userId: userId,
    );
    result.fold(
      (error) => emit(GetNotificationError(errorMessage: error)),
      (patientData) => emit(GetNotificationLoaded(
          notificationsResponse: patientData.responseData)),
    );
  }

  Future<void> getBookingDetails({required int bookingId}) async {
    emit(GetBookingDetailsLoading());
    final result = await _notificationsRepo.getBookingDetails(
      bookingId: bookingId,
    );
    result.fold(
      (error) => emit(GetBookingDetailsError(errorMessage: error)),
      (bookingDetails) => emit(GetBookingDetailsLoaded(
          bookingDetailsResponse: bookingDetails.responseData)),
    );
  }

  Future<void> downloadImage(BuildContext context, String imageUrl) async {
    try {
      // Get app's directory
      final dir = await getApplicationDocumentsDirectory();
      String savePath = "${dir.path}/downloaded_image.png";

      // Download with Dio
      await Dio().download(imageUrl, savePath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Downloaded to: $savePath")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Download failed: $e")),
      );
    }
  }
}
