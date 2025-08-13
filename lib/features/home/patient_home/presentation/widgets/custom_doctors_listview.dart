import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_listview_shimmer.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';
import 'package:ithera_app/features/home/patient_home/managers/pagination_cubit/pagination_cubit.dart';
import 'package:ithera_app/features/home/patient_home/presentation/widgets/custom_item_doctor.dart';

class CustomDoctorsListView extends StatelessWidget {
  const CustomDoctorsListView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginationCubit, PaginationState>(
      builder: (context, state) {
        // Show shimmer list while loading first page
        if (state is PaginationLoading && state.items.isEmpty) {
          return SliverList.builder(
            itemCount: 5, // Number of shimmer items
            itemBuilder: (context, index) => const CustomItemDoctorShimmer(),
          );
        }

        if (state is PaginationLoadedEnd && state.items.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomSvgimage(
                    path: AssetsData.emptyItems,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'غير موجود',
                    style: AppTextStyles.font25Medium.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Show the real list with pagination loading indicator at the bottom
        return SliverList.builder(
          itemCount:
              state.items.length + (state is PaginationLoadedEnd ? 0 : 1),
          itemBuilder: (context, index) {
            if (index == state.items.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              );
            }

            return CustomItemDoctor(
              doctorModel: state.items[index],
            );
          },
        );
      },
    );
  }
}
