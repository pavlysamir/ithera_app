import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';

class PricesScreen extends StatelessWidget {
  const PricesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> prices = [
      {'region': 'مدينة نصر', 'price': '300 جنيه'},
      {'region': 'مصر الجديدة', 'price': '400 جنيه'},
      {'region': 'الزيتون', 'price': '250 جنيه'},
      {'region': 'حدائق القبة', 'price': '320 جنيه'},
      {'region': 'غمرة', 'price': '150 جنيه'},
      {'region': 'الزاوية الحمراء', 'price': '50 جنيه'},
      {'region': 'عزبة النخل', 'price': '50 جنيه'},
      {'region': 'سراي القبة', 'price': '300 جنيه'},
      {'region': 'المعادى', 'price': '350 جنيه'},
      {'region': 'زهراء المعادي', 'price': '350 جنيه'},
      {'region': 'الهرم', 'price': '200 جنيه'},
      {'region': 'بدر', 'price': '500 جنيه'},
      {'region': 'فيصل', 'price': '300 جنيه'},
      {'region': 'أكتوبر', 'price': '300 جنيه'},
      {'region': 'التجمع الخامس', 'price': '400 جنيه'},
    ];

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اسعار الجلسات',
              style: AppTextStyles.font14Regular
                  .copyWith(color: AppColors.blackLight),
            ),
            SizedBox(height: 2.h),
            const Divider(
              color: AppColors.grey50,
              thickness: 1,
            ),
            SizedBox(height: 20.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.blueMoreLight,
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      alignment: Alignment.center,
                      child: Text(
                        'المنطقة',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      alignment: Alignment.center,
                      child: Text(
                        'السعر',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: prices.length,
                itemBuilder: (context, index) {
                  final item = prices[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            alignment: Alignment.center,
                            child: Text(
                              item['region']!,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            alignment: Alignment.center,
                            child: Text(
                              item['price']!,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
