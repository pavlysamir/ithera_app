import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_small.dart';
import 'package:ithera_app/core/widgets/pop_up_dialog.dart';
import 'package:ithera_app/features/booking/doctor_booking/presentation/widgets/custom_circle_line.dart';

class SeesionsList extends StatelessWidget {
  const SeesionsList({super.key, this.isDimmed = false});
  final bool isDimmed;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCircleLine(
                isDimmed: isDimmed,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' السبت من 4 الي 6 مساءً',
                    style: AppTextStyles.font14Regular.copyWith(
                        color:
                            isDimmed ? AppColors.blackLight : AppColors.black),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    ' 10/10/2023',
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.blackLight,
                    ),
                  )
                ],
              ),
              const Spacer(),
              isDimmed
                  ? const SizedBox()
                  : SizedBox(
                      height: 45.h,
                      child: CustomButtonSmall(
                        width: 80.w,
                        function: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => PopUpDialog(
                                    function2: () {},
                                    function: () {
                                      Navigator.pop(context);
                                    },
                                    title: 'هل تريد بالتأكيد الغاء هذه الجلسة؟',
                                    img: AssetsData.deleteAccount,
                                    subTitle: '',
                                    colorButton1: AppColors.primaryColor,
                                    colorButton2: AppColors.white,
                                    textColortcolor1: Colors.white,
                                    textColortcolor2: AppColors.primaryColor,
                                    context: context,
                                  ));
                        },
                        text: 'تأجيل',
                        color: AppColors.white,
                        borderColor: AppColors.primaryColor,
                        textColortcolor: AppColors.primaryColor,
                      ),
                    ),
            ],
          );
        });
  }
}
