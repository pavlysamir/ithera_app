import 'package:flutter/material.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
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
        body: ListView.builder(
          itemBuilder: (context, index) => const NotificationItem(),
          itemCount: 10,
        ));
  }
}
