import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_listview_shimmer.dart';
import 'package:ithera_app/features/notification/managers/cubit/notifications_cubit.dart';
import 'package:ithera_app/features/notification/presentation/widgets/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.white,
          forceMaterialTransparency: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppColors.primaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
        ),
        body: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            if (state is GetNotificationError) {
              return Center(
                child: Text(state.errorMessage),
              );
            }
            if (state is GetNotificationLoading) {
              return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (_, __) {
                    return const CustomItemDoctorShimmer();
                  });
            }
            if (state is GetNotificationLoaded &&
                state.notificationsResponse.isNotEmpty) {
              return ListView.builder(
                itemCount: state.notificationsResponse.length,
                itemBuilder: (context, index) {
                  return NotificationWidgetItem(
                    notificationItem: state.notificationsResponse[index],
                  );
                },
              );
            }
            return Center(
                child: Text(
              'لا يوجد اشعارات',
              style: AppTextStyles.font16Regular
                  .copyWith(color: AppColors.primaryColor),
            ));
          },
        ));
  }
}
