import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/extensions/mediaQuery_extensions.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_text_rich.dart';
import 'package:ithera_app/features/settings/doctors_settings/presentation/widgets/my_current_balance_container.dart';
import 'package:ithera_app/features/settings/doctors_settings/presentation/widgets/small_balance_container.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20).r,
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                const MyCurrentBalanceContainer(),
                SizedBox(
                  height: 28.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: SmallBalanceContainer(
                        colorIcon: AppColors.textGreen,
                        balance: '0 جنيه',
                        title: 'الرصيد المسحوب',
                        iconData: Icons.payments_outlined,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    const Expanded(
                      child: SmallBalanceContainer(
                        colorIcon: AppColors.error100,
                        balance: '0 جنيه',
                        title: 'الرصيد المجمد',
                        iconData: Icons.pause_circle_outlined,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: context.hightMediaQuery * 0.3,
                ),
                CustomButtonLarge(
                    text: 'اضافة رصيد',
                    color: AppColors.primaryColor,
                    function: () {}),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextRich(
                    firstText: '',
                    secondText: 'سحب الرصيد',
                    onSecondText: AppColors.primaryColor,
                    onSecondTextTap: () {}),
              ],
            ),
          ),
        ));
  }
}
