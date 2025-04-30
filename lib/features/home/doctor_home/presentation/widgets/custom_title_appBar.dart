import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';

class CustomTitleAppBar extends StatelessWidget {
  const CustomTitleAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
            radius: 20.r,
            child: ClipOval(
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                  placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                  imageUrl:
                      'https://thumbs.dreamstime.com/b/young-male-doctor-close-up-happy-looking-camera-56751540.jpg'),
            )),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'أهلا بك',
                style: AppTextStyles.font14Regular
                    .copyWith(color: AppColors.primaryColor),
              ),
              Text(
                // getIt
                //         .get<CashHelperSharedPreferences>()
                //         .getData(key: ApiKey.userName) ??
                'د/ بيتر يونس',
                style: AppTextStyles.font20Regular.copyWith(
                  color: AppColors.primaryColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
      ],
    );
  }
}
