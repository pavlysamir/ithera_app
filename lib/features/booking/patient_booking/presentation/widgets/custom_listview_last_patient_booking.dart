import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_shadows.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_small.dart';

class LastPatinetBooking extends StatelessWidget {
  const LastPatinetBooking({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 8,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [AppShadows.shadow1],
          ),
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.blackLight)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                        placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity,
                        imageUrl:
                            'https://thumbs.dreamstime.com/b/young-male-doctor-close-up-happy-looking-camera-56751540.jpg'),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(' د/ أمجد هاني ',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.font16Regular.copyWith(
                      color: AppColors.primaryColor,
                    )),
              ),
              Expanded(
                  flex: 2,
                  child: CustomButtonSmall(
                      width: 120.w,
                      function: () {},
                      text: 'اعادة الحجز',
                      color: AppColors.textGreen,
                      borderColor: AppColors.textGreen))
            ],
          ),
        );
      },
      itemCount: 10,
    );
  }
}
