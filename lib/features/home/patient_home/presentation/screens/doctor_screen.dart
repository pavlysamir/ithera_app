import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/di/service_locator.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_cubit.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_state.dart';
import 'package:ithera_app/features/home/patient_home/data/models/doctors_model.dart';
import 'package:ithera_app/features/home/patient_home/presentation/widgets/custom_apountments_doctor_list_view.dart';
import 'package:ithera_app/features/home/patient_home/presentation/widgets/custom_star_rating.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key, required this.doctorModel});
  final DoctorModel doctorModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // forceMaterialTransparency: true,
            backgroundColor: AppColors.blueLight,
            expandedHeight: 270.0.h,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CachedNetworkImage(
                      height: 270.0.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: doctorModel.profilePicture ??
                          'https://thumbs.dreamstime.com/b/young-male-doctor-close-up-happy-looking-camera-56751540.jpg'),
                  Container(
                    height: 20,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'د/ ${doctorModel.doctorName}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.font22Regular.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      StarRating(
                        rating:
                            doctorModel.averageRating, // خليها القيمه اللي عندك
                        size: 20,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    doctorModel.specializationFields.isNotEmpty
                        ? doctorModel.specializationFields.first.nameAr
                        : 'تخصص غير محدد',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.font14Regular.copyWith(
                      color: AppColors.blackLight,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text('نبذة عن الدكتور',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font16Regular.copyWith(
                        color: AppColors.primaryColor,
                      )),
                  const SizedBox(height: 10.0),
                  Text(
                    'علاج طبيعي معتمد، يتمتع بخبرة واسعة في تشخيص وعلاج الحالات العضلية والعصبية والهيكلية. يقدّم برامج تأهيلية مخصصة تساعد المرضى على استعادة حركتهم الطبيعية وتحسين جودة حياتهم',
                    style: AppTextStyles.font14Regular.copyWith(
                      color: AppColors.blackLight,
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Divider(
                    color: AppColors.grey300,
                    thickness: 1,
                  ),
                  ListTile(
                    leading: CustomSvgimage(
                      path: 'assets/icons/cash.svg',
                      hight: 16.sp,
                    ),
                    title: Text(
                      'سعر الجلسة : ${doctorModel.sessionPrice} جنيه',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font14Regular
                          .copyWith(color: AppColors.blackLight),
                    ),
                  ),
                  BlocProvider(
                    create: (context) =>
                        getIt<BadeLookUpCubit>()..getAllCities(),
                    child: BlocBuilder<BadeLookUpCubit, BadeLookUpState>(
                      builder: (context, state) {
                        return ListTile(
                          leading: CustomSvgimage(
                            path: 'assets/icons/location.svg',
                            hight: 16.sp,
                          ),
                          title: Text(
                            BadeLookUpCubit.get(context)
                                    .getCityNameById(doctorModel.cityId) ??
                                'المدينه....',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.font14Regular
                                .copyWith(color: AppColors.blackLight),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text('المواعيد المتاحة',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font16Regular.copyWith(
                        color: AppColors.primaryColor,
                      )),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
          doctorModel.regionSchedules!.isEmpty
              ? SliverToBoxAdapter(
                  child: Center(
                    child: Text('لا يوجد مواعيد متاحة',
                        style: AppTextStyles.font14Regular),
                  ),
                )
              : SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        height: 10.h,
                        color: AppColors.white,
                      ),
                      CustomApountmentsDoctorListView(
                        regionSchedule: doctorModel.regionSchedules ?? [],
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  String getAllNameAr(List<dynamic> list) {
    return list.map((e) => e.nameAr.toString()).join(', ');
  }
}
