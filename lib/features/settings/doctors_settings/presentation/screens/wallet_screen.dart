import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/extensions/mediaQuery_extensions.dart';
import 'package:ithera_app/core/routing/routes.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_listview_shimmer.dart';
import 'package:ithera_app/core/widgets/custom_text_rich.dart';
import 'package:ithera_app/features/settings/doctors_settings/managers/cubit/setting_cubit.dart';
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
            child: BlocBuilder<SettingCubit, SettingState>(
              builder: (context, state) {
                if (state is DataWalletLoading) {
                  return const CustomItemDoctorShimmer();
                }
                if (state is DataWalletError) {
                  return Center(
                    child: Text(
                      state.error,
                      style:
                          TextStyle(color: AppColors.error100, fontSize: 16.sp),
                    ),
                  );
                }
                if (state is DataWalletLoaded) {
                  final currentBalance =
                      state.walletData.responseData.currentBalance ?? 0.0;
                  final detectedBalance =
                      state.walletData.responseData.detectedBalance ?? 0.0;
                  final frozenBalance =
                      state.walletData.responseData.frozenBalance ?? 0.0;
                  return Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      MyCurrentBalanceContainer(
                        currentBalance: currentBalance,
                      ),
                      SizedBox(
                        height: 28.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SmallBalanceContainer(
                              colorIcon: AppColors.textGreen,
                              balance: '$detectedBalance جنيه',
                              title: 'الرصيد المسحوب',
                              iconData: Icons.payments_outlined,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: SmallBalanceContainer(
                              colorIcon: AppColors.error100,
                              balance: '$frozenBalance جنيه',
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
                          function: () {
                            Navigator.pushNamed(
                                context, Routes.addBalanceScreen);
                          }),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextRich(
                          firstText: '',
                          secondText: 'سحب الرصيد',
                          onSecondText: AppColors.primaryColor,
                          onSecondTextTap: () {}),
                    ],
                  );
                }
                return const Text(
                  'Something went wrong',
                  style: TextStyle(color: AppColors.error100, fontSize: 16),
                );
              },
            ),
          ),
        ));
  }
}
