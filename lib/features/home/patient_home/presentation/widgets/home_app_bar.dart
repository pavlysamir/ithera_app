import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/routing/navigation_services.dart';
import 'package:ithera_app/core/routing/routes.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';
import 'package:animate_do/animate_do.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    super.key,
    required this.controller,
    required this.userName,
  });

  final TextEditingController controller;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: 185.0.h,
      floating: false,
      pinned: true,
      actions: [
        SlideInDown(
          animate: true,
          duration: const Duration(milliseconds: 300),
          from: 8,
          child: IconButton(
            icon: CustomSvgimage(
              hight: 30.h,
              path: 'assets/icons/notification_icon.svg',
            ),
            onPressed: () {},
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
      ],
      titleSpacing: 20.w,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.backgroundHomeAppBar,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Hide the FlexibleSpaceBar when scrolling
            bool isCollapsed = constraints.biggest.height <=
                kToolbarHeight + MediaQuery.of(context).padding.top + 80.h;
            return isCollapsed
                ? Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: AppColors.backgroundHomeAppBar,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ) // Empty when collapsed
                : SlideInDown(
                    animate: true,
                    duration: const Duration(milliseconds: 300),
                    from: 8,
                    child: FlexibleSpaceBar(
                      centerTitle: true,
                      expandedTitleScale: 1,
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          height: 60.h,
                          child: TextFormField(
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            controller: controller,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 10.h,
                              ),
                              hintText: 'ابحث عن دكتورك',
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Row(
                                children: [
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  CustomSvgimage(
                                    path: 'assets/icons/search_icon.svg',
                                    hight: 25,
                                  ),
                                ],
                              ),
                              prefixIconConstraints: BoxConstraints(
                                maxHeight: 25.h,
                                maxWidth: 50.w,
                              ),
                              suffixIcon: SizedBox(
                                height: 50.h,
                                width: 80.w, // Adjust the width as needed
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .end, // Align items to the end
                                  children: [
                                    IconButton(
                                      icon: CustomSvgimage(
                                        hight: 40.h,
                                        path: 'assets/icons/filter_icon.svg',
                                      ),
                                      onPressed: () {
                                        //controller.clear();
                                        NavigationService()
                                            .navigateTo(Routes.filterScreen);
                                      },
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                  ],
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
      title: SlideInDown(
        animate: true,
        duration: const Duration(milliseconds: 300),
        from: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'أهلا بك',
              style:
                  AppTextStyles.font14Regular.copyWith(color: AppColors.white),
            ),
            Text(
              userName,
              style: AppTextStyles.font20Regular
                  .copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
      collapsedHeight: 70,
    );
  }
}
