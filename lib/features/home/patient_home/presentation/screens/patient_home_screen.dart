import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          expandedHeight: 185.0.h,
          floating: false,
          pinned: true,
          actions: [
            IconButton(
              icon: CustomSvgimage(
                hight: 30.h,
                path: 'assets/icons/notification_icon.svg',
              ),
              onPressed: () {},
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
                    : FlexibleSpaceBar(
                        centerTitle: true,
                        expandedTitleScale: 1,
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: SizedBox(
                            height: 60.h,
                            child: TextFormField(
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
                                suffixIcon: Row(
                                  children: [
                                    IconButton(
                                      icon: CustomSvgimage(
                                        hight: 40.h,
                                        path: 'assets/icons/filter_icon.svg',
                                      ),
                                      onPressed: () {
                                        //controller.clear();
                                      },
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                  ],
                                ),
                                suffixIconConstraints: BoxConstraints(
                                  maxHeight: 50.h,
                                  maxWidth: 60.w,
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
                      );
              },
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'أهلا بك',
                style: AppTextStyles.font14Regular
                    .copyWith(color: AppColors.white),
              ),
              Text(
                'بيتر يونس',
                style: AppTextStyles.font20Regular
                    .copyWith(color: AppColors.primaryColor),
              ),
            ],
          ),
          collapsedHeight: 70,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                height: 50,
                color: index.isEven ? Colors.white : Colors.black12,
                child: Center(
                  child: Text('$index', textScaleFactor: 2),
                ),
              );
            },
            childCount: 50,
          ),
        ),
      ]),
    );
  }
}
