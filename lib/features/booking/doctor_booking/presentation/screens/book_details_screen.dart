import 'package:flutter/material.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/features/booking/doctor_booking/presentation/widgets/book_item_details.dart';
import 'package:ithera_app/features/booking/doctor_booking/presentation/widgets/seesions_listview.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        title: Text('الحجوزات',
            style: AppTextStyles.font14Regular.copyWith(
              color: AppColors.black,
            )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BookItemDetails(),
            const SizedBox(height: 20),
            Text(
              'متابعة الجلسات',
              style: AppTextStyles.font16Regular,
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            const Expanded(
                child: SeesionsList(
              isDimmed: false,
            ))
          ],
        ),
      ),
    );
  }
}
