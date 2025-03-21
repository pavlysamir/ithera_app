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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('${model.title}',
            textAlign: TextAlign.center, style: AppTextStyles.font25Bold),
        const SizedBox(
          height: 10,
        ),
        CustomSvgimage(
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
              Text(
                '${model.messege}',
                style: AppTextStyles.font20Regular,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  model.image!,
                  height: 350.h,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
