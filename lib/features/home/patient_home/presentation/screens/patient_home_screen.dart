import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
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

class _PatientHomeScreenState extends State<PatientHomeScreen>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController controller = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // هنا بس نتأكد إن البيانات موجودة، والـ cubit هيتعامل مع الباقي
    context.read<PaginationCubit>().initializeIfNeeded();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        0.7 * _scrollController.position.maxScrollExtent) {
      context.read<PaginationCubit>().fetchItems();
    }
  }

  Future<void> _onRefresh() async {
    controller.clear();
    context.read<PaginationCubit>().reset();
    await context.read<PaginationCubit>().fetchItems();
  }

  Future<void> onChange(String value) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      context.read<PaginationCubit>().fetchItems(
            searchQuery: value,
          );
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    controller.dispose();
    _debounce?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppColors.primaryColor,
        backgroundColor: Colors.white,
        child: CustomScrollView(
          controller: _scrollController,
          physics:
              const AlwaysScrollableScrollPhysics(), // مهم عشان الـ refresh يشتغل
          slivers: [
            HomeAppbar(
                onChange: onChange,
                controller: controller,
                userName:
                    CacheHelper.getString(key: CacheConstants.userName) ?? ''),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 10),
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
              ),
            ),
            const CustomDoctorsListView(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
