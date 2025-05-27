import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
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
        return SliverList.builder(
            itemCount:
                state.items.length + (state is PaginationLoadedEnd ? 0 : 1),
            itemBuilder: (context, index) {
              if (index == state.items.length) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ));
              }
              return CustomItemDoctor(
                doctorModel: state.items[index],
              );
            });
      },
    );
  }
}
