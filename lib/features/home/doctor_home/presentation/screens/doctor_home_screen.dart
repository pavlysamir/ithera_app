import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:ithera_app/core/di/service_locator.dart';
import 'package:ithera_app/core/routing/navigation_services.dart';
import 'package:ithera_app/core/routing/routes.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
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
          ),
        ),
        title: const CustomTitleAppBar(),
        actionsPadding: EdgeInsets.symmetric(horizontal: 20.w),
        actions: [
          IconButton(
            icon: CustomSvgimage(
              hight: 30.h,
              color: AppColors.blackLight,
              path: AssetsData.notification,
            ),
            onPressed: () {
              NavigationService().navigateTo(Routes.notificationsScreen);
            },
          ),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<BadeLookUpCubit>()
              ..getAllRegions(
                CacheHelper.getInt(key: CacheConstants.cityId)!,
              ),
          ),
          BlocProvider(
            create: (context) =>
                getIt<DoctorManageSchedulesCubit>()..getManageSchedules(),
          ),
        ],
        child: const _DoctorHomeBody(),
      ),
    );
  }
}

class _DoctorHomeBody extends StatelessWidget {
  const _DoctorHomeBody();

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorManageSchedulesCubit, DoctorManageSchedulesState>(
      listener: (context, state) async {
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
        } else if (state is DoctorManageSchedulesSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColors.textGreenLight,
              content: Text('تم إضافة المواعيد بنجاح'),
            ),
          );
        } else if (state is DoctorManageSchedulesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.error100,
              content: Text(state.errorMessage),
            ),
          );
          await context
              .read<DoctorManageSchedulesCubit>()
              .getManageSchedules(forceRefresh: true);
        }
      },
      child: const SingleChildScrollView(
        child: Column(
          children: [
            AddAppountmentScreen(),
            _SchedulesList(),
          ],
        ),
      ),
    );
  }
}

class _SchedulesList extends StatelessWidget {
  const _SchedulesList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorManageSchedulesCubit, DoctorManageSchedulesState>(
      builder: (context, state) {
        if (state is GetDoctorSchedulesLoading) {
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is GetDoctorSchedulesError) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text(
                  'حدث خطأ',
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<DoctorManageSchedulesCubit>()
                        .getManageSchedules(forceRefresh: true);
                  },
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        } else if (state is GetDoctorSchedulesSuccess) {
          final schedules = state.data.responseData.regionSchedules;

          if (schedules.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  'لا توجد مواعيد محجوزة',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: schedules.length,
            itemBuilder: (context, index) => NewAppointmentDetails(
              schadule: schedules[index],
              onTap: () => _showDeleteDialog(context, schedules[index]),
            ),
          );
        }

        // Handle other states or initial state
        return const SizedBox.shrink();
      },
    );
  }

  void _showDeleteDialog(BuildContext context, RegionSchedule schedule) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<DoctorManageSchedulesCubit>(),
        child: BlocListener<DoctorManageSchedulesCubit,
            DoctorManageSchedulesState>(
          listener: (context, state) {
            if (state is DeleteDoctorSchedulesSuccess ||
                state is DeleteDoctorSchedulesError) {
              Navigator.of(dialogContext).pop();
            }
          },
          child: BlocBuilder<DoctorManageSchedulesCubit,
              DoctorManageSchedulesState>(
            builder: (context, state) {
              final isLoading = state is DeleteDoctorSchedulesLoading;

              return PopUpDialog(
                function2: isLoading
                    ? () {}
                    : () async {
                        await context
                            .read<DoctorManageSchedulesCubit>()
                            .deleteDoctorSchedules(
                              regionId: schedule.regionId,
                              scheduleId: schedule.cardId,
                            );
                      },
                function: isLoading
                    ? () {}
                    : () {
                        Navigator.of(dialogContext).pop();
                      },
                title: 'هل تريد بالتأكيد حذف هذا الحجز؟',
                img: AssetsData.deleteAccount,
                subTitle: isLoading ? 'جاري الحذف...' : '',
                colorButton1: AppColors.primaryColor,
                colorButton2: AppColors.white,
                textColortcolor1: Colors.white,
                textColortcolor2: AppColors.primaryColor,
                context: context,
              );
            },
          ),
        ),
      ),
    );
  }
}
