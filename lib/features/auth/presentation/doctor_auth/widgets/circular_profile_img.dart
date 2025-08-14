import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:ithera_app/core/theme/app_colors.dart';

class CircularProfileImage extends StatelessWidget {
  const CircularProfileImage({
    super.key,
    this.file,
    required this.function,
    required this.closeFunction,
  });

  final File? file;
  final Function() function;
  final Function() closeFunction;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        alignment: file != null
            ? AlignmentDirectional.topStart
            : AlignmentDirectional.bottomEnd,
        children: [
          ClipOval(
            child: CircleAvatar(
              radius: 41.h,
              backgroundColor: AppColors.black,
              child: ClipOval(
                child: CircleAvatar(
                  radius: 40.h,
                  backgroundColor: AppColors.white,
                  child: file != null
                      ? Image.file(
                          file!,
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : CacheHelper.getString(key: CacheConstants.userImage) ==
                              null
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
                ),
              ),
            ),
          ),
          file != null
              ? const SizedBox()
              : IconButton(
                  onPressed: function,
                  icon: Icon(
                    color: AppColors.textGreen,
                    Icons.add_a_photo,
                    size: 20.h,
                  ),
                ),
          file != null
              ? IconButton(
                  onPressed: closeFunction,
                  icon: CircleAvatar(
                    radius: 13.h,
                    backgroundColor: AppColors.error100,
                    child: Icon(
                      color: AppColors.white,
                      Icons.close,
                      size: 15.h,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
