import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
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
              child:
                  CacheHelper.getString(key: CacheConstants.userImage) == null
                      ? const Icon(
                          Icons.person,
                          color: AppColors.primaryColor,
                        )
                      : CachedNetworkImage(
                          placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                  strokeWidth: 2,
                                ),
                              ),
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: double.infinity,
                          imageUrl: CacheHelper.getString(
                                  key: CacheConstants.userImage) ??
                              ''),
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

                CacheHelper.getString(key: CacheConstants.userName) ??
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
