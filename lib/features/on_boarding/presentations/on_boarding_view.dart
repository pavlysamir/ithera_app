import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:ithera_app/core/routing/navigation_services.dart';
import 'package:ithera_app/core/routing/routes.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../data/models/onBoeding_model.dart';
import 'on_boarding_item.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});
  bool isLast = false;
  var boardController = PageController();

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void dispose() {
    widget.boardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<OnBoardingModel> modelBoarding = [
      OnBoardingModel(
          image: AssetsData.onBording_1,
          title: 'اول ابلكيشن فى مصر\nمختص بخدمات العلاج\nالطبيعي فقط',
          messege: 'الحل الذكي للعلاج الطبيعي\n بيقدملك أفضل جودة بأحسن سعر'),
      OnBoardingModel(
          image: AssetsData.onBording_2,
          title: 'احجز جلستك\nبدوسة زرار',
          messege:
              'دلوقتي تقدر تحجز جلسة علاج طبيعي \nبسهولة وفي أي وقت يناسبك.'),
      OnBoardingModel(
          image: AssetsData.onBording_3,
          title: 'دكاترة متخصصون في\nجميع مجالات\nالعلاج الطبيعى',
          messege:
              'بنوصلك بأفضل أخصائيين العلاج \nالطبيعي المعتمدين، أينما كنت.'),
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.white,
        shape:
            ShapeBorder.lerp(const CircleBorder(), const StadiumBorder(), 0.5),
        onPressed: submit,
        child: const Icon(Icons.arrow_forward,
            color: AppColors.textGreen, size: 34),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      if (widget.isLast == true) {
                        submit();
                      } else {
                        widget.boardController.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Text(
                      'تخطي',
                      style: AppTextStyles.font14Regular.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.grey, // لون الخط
                      ),
                    )),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: SmoothPageIndicator(
                      controller: widget.boardController,
                      count: modelBoarding.length,
                      effect: WormEffect(
                          activeDotColor: AppColors.textGreen,
                          dotColor: Colors.grey,
                          dotHeight: 10.h,
                          dotWidth: 8.w,
                          spacing: 8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    BuildBoardingItem(model: modelBoarding[index]),
                itemCount: modelBoarding.length,
                physics: const BouncingScrollPhysics(),
                controller: widget.boardController,
                onPageChanged: (int index) {
                  if (index == modelBoarding.length - 1) {
                    setState(() {
                      if (kDebugMode) {
                        print('last');
                      }
                      widget.isLast = true;
                    });
                  } else {
                    setState(() {
                      if (kDebugMode) {
                        print('not last');
                      }
                      widget.isLast = false;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submit() {
    CacheHelper.set(
            key: CacheConstants.onBoardingViewed,
            value: CacheConstants.onBoardingViewed)
        .then((value) {
      NavigationService().navigateAndRemoveUntil(Routes.onBoardingScreen);
    });
  }
}
