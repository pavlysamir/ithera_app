import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';

import '../data/models/onBoeding_model.dart';

class BuildBoardingItem extends StatelessWidget {
  const BuildBoardingItem({super.key, required this.model});
  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    double scaleFactor = MediaQuery.of(context).textScaleFactor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${model.title}',
          textAlign: TextAlign.center,
          style: AppTextStyles.font25Bold.copyWith(
            fontSize: 25 / scaleFactor,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const CustomSvgimage(
          hight: 50,
          path: AssetsData.onBordingLines,
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              scaleFactor > 1.2
                  ? const Text('')
                  : Text(
                      '${model.messege}',
                      maxLines: scaleFactor > 1.3 ? 3 : 5,
                      style: AppTextStyles.font20Regular.copyWith(
                        fontSize: scaleFactor > 1.3 ? 16 : 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  model.image!,
                  height: 400.h,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
