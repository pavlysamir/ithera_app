import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                        :
                        // getIt
                        //             .get<CashHelperSharedPreferences>()
                        //             .getData(key: ApiKey.profilePic) !=
                        //         null
                        //     ?
                        // ClipOval(
                        //     child: CachedNetworkImage(
                        //         fit: BoxFit.fill,
                        //         width: double.infinity,
                        //         height: double.infinity,
                        //         imageUrl: getIt
                        //             .get<CashHelperSharedPreferences>()
                        //             .getData(key: ApiKey.profilePic)),
                        //   )
                        // :
                        Icon(
                            Icons.person,
                            size: 40.h,
                            color: Colors.black,
                          )),
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
