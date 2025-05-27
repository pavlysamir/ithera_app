import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/features/home/patient_home/managers/pagination_cubit/pagination_cubit.dart';
import 'package:ithera_app/features/home/patient_home/presentation/widgets/custom_doctors_listview.dart';

import 'package:ithera_app/features/home/patient_home/presentation/widgets/home_app_bar.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<PaginationCubit>().fetchItems();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          0.7 * _scrollController!.position.maxScrollExtent) {
        context.read<PaginationCubit>().fetchItems();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Scaffold(
        body: CustomScrollView(controller: _scrollController, slivers: [
      HomeAppbar(controller: controller, userName: 'بيتر يونس'),
      SliverToBoxAdapter(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'جميع الدكاترة',
              style: AppTextStyles.font14Regular
                  .copyWith(color: AppColors.blackLight),
            ),
            SizedBox(height: 2.h),
            const Divider(
              color: AppColors.grey100,
              thickness: 1,
            ),
          ],
        ),
      )),
      const CustomDoctorsListView(),
    ]));
  }
}
