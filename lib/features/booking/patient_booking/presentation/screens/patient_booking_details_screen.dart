import 'package:flutter/material.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/pop_up_dialog.dart';
import 'package:ithera_app/features/booking/doctor_booking/presentation/widgets/seesions_listview.dart';
import 'package:ithera_app/features/booking/patient_booking/data/models/patient_booking_model.dart';

class BookPatientDetailsScreen extends StatelessWidget {
  const BookPatientDetailsScreen({super.key, required this.activeBookings});
  final PatientBookingModel activeBookings;

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
            //  const DoctorBookItemDetails(),
            const SizedBox(height: 20),
            Text(
              'متابعة الجلسات',
              style: AppTextStyles.font16Regular,
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Expanded(
                child: SeesionsList(
              activeBookings: activeBookings.sessions,
            )),
            const SizedBox(height: 10),
            CustomButtonLarge(
                text: 'الغاء الحجز نهائيا',
                color: AppColors.primaryColor,
                function: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => PopUpDialog(
                            function2: () {},
                            function: () {
                              Navigator.pop(context);
                            },
                            title: 'هل تريد بالتأكيد الغاء هذا الحجز بالكامل ؟',
                            img: AssetsData.deleteAccount,
                            subTitle: '',
                            colorButton1: AppColors.primaryColor,
                            colorButton2: AppColors.white,
                            textColortcolor1: Colors.white,
                            textColortcolor2: AppColors.primaryColor,
                            context: context,
                          ));
                }),
          ],
        ),
      ),
    );
  }
}
