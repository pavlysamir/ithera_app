import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:ithera_app/core/di/service_locator.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/widgets/custom_listview_loading_indicator.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';
import 'package:ithera_app/core/widgets/pop_up_dialog.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_cubit.dart';
import 'package:ithera_app/features/home/doctor_home/data/models/doctor_schadules_model.dart';
import 'package:ithera_app/features/home/doctor_home/managers/cubit/doctor_manage_schedules_cubit.dart';
import 'package:ithera_app/features/home/doctor_home/presentation/screens/add_appountment_screen.dart';
import 'package:ithera_app/features/home/doctor_home/presentation/widgets/custom_title_appBar.dart';
import 'package:ithera_app/features/home/doctor_home/presentation/widgets/new_appountment_details.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          forceMaterialTransparency: true,
          toolbarHeight: 70.h,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  margin: EdgeInsets.only(top: 10.h),
                  height: 1,
                  color: AppColors.grey100,
                ),
              )),
          title: const CustomTitleAppBar(),
          actionsPadding: EdgeInsets.symmetric(horizontal: 20.w),
          actions: [
            IconButton(
              icon: CustomSvgimage(
                hight: 30.h,
                color: AppColors.blackLight,
                path: AssetsData.notification,
              ),
              onPressed: () {},
            ),
          ]),
      body: BlocProvider(
        create: (context) => getIt<BadeLookUpCubit>()
          ..getAllRegions(
            CacheHelper.getInt(key: CacheConstants.cityId)!,
          ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AddAppountmentScreen(),
              BlocConsumer<DoctorManageSchedulesCubit,
                  DoctorManageSchedulesState>(
                listener: (context, state) {
                  if (state is DeleteDoctorSchedulesSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: AppColors.textGreenLight,
                        content: Text('تم حذف الموعد بنجاح'),
                      ),
                    );
                  } else if (state is DeleteDoctorSchedulesError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.error100,
                        content: Text(state.errorMessage),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is GetDoctorSchedulesLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is GetDoctorSchedulesSuccess) {
                    final regions = state.data.responseData.regionSchedules;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: regions.length,
                      itemBuilder: (context, index) => NewApppountmentDetails(
                        schadule: regions[index],
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => PopUpDialog(
                                    function2: () async {
                                      await DoctorManageSchedulesCubit.get(
                                              context)
                                          .deleteDoctorSchadules(
                                              regionId: regions[index].regionId,
                                              scheduleId:
                                                  regions[index].cardId);
                                    },
                                    function: () {
                                      Navigator.pop(context);
                                    },
                                    title:
                                        'هل تريد بالتأكيد الغاء هذا الحجز بالكامل ؟',
                                    img: AssetsData.deleteAccount,
                                    subTitle: '',
                                    colorButton1: AppColors.primaryColor,
                                    colorButton2: AppColors.white,
                                    textColortcolor1: Colors.white,
                                    textColortcolor2: AppColors.primaryColor,
                                    context: context,
                                  ));
                        },
                      ),
                    );
                  } else if (state is GetDoctorSchedulesError) {
                    return Text('حدث خطأ: ${state.errorMessage}');
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),

      //AcceptedAccount(),
    );
  }
}
