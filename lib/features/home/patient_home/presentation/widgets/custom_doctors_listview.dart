import 'package:flutter/material.dart';
import 'package:ithera_app/features/home/patient_home/presentation/widgets/custom_item_doctor.dart';

class CustomDoctorsListView extends StatelessWidget {
  const CustomDoctorsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return CustomItemDoctor();
        });
  }
}
