import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/features/home/patient_home/managers/filter_cubit/filter_pagination_cubit.dart';
import 'package:ithera_app/features/home/patient_home/presentation/widgets/custom_filter_doctors_listview.dart';

class FilterResultsScreen extends StatefulWidget {
  const FilterResultsScreen({super.key});

  @override
  State<FilterResultsScreen> createState() => _FilterResultsScreenState();
}

class _FilterResultsScreenState extends State<FilterResultsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _hasInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_hasInitialized) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      context.read<FilterPaginationCubit>().setFilters(
            doctorName: args?['doctorName'],
            cityId: args?['cityId'],
            specialtyId: args?['specialtyId'],
            gender: args?['gender'],
          );

      _scrollController.addListener(_onScroll);
      _hasInitialized = true;
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        0.7 * _scrollController.position.maxScrollExtent) {
      context.read<FilterPaginationCubit>().fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const SliverAppBar(
            backgroundColor: Colors.transparent,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'نتائج البحث',
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
          const CustomFilterDoctorsListView()
        ],
      ),
    );
  }
}
