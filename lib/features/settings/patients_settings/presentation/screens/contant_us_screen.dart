import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_shadows.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';
import 'package:url_launcher/url_launcher.dart';

class ContantUsScreen extends StatelessWidget {
  const ContantUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String email = 'cA7oN@example.com';
    final String subject = 'Subject';
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 70.dg),
          child: Column(
            children: [
              SizedBox(
                height: 60.h,
              ),
              CustomContentUsContainer(
                text: 'تواصل معنا من خلال الواتساب',
                img: AssetsData.whatsApp,
                function: () async {
                  Uri whatsApp = Uri.parse('https://wa.me/+201271507452');
                  launchUrl(whatsApp);
                },
              ),
              SizedBox(
                height: 40.h,
              ),
              CustomContentUsContainer(
                img: AssetsData.mail,
                text: 'تواصل معنا من خلال الإيميل',
                function: () async {
                  Uri mail = Uri.parse("mailto:$email?subject=$subject&body= ");
                  if (await launchUrl(mail)) {
                    //email app opened
                  } else {
                    if (kDebugMode) {
                      print('not working');
                    }
                  }
                },
              )
            ],
          ),
        ));
  }
}

class CustomContentUsContainer extends StatelessWidget {
  const CustomContentUsContainer(
      {super.key,
      required this.text,
      required this.img,
      required this.function});
  final String text;
  final String img;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 170.h,
        width: 300.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
          boxShadow: [
            AppShadows.shadow1,
          ],
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomSvgimage(
                hight: 50.h,
                path: img,
              ),
              SizedBox(
                height: 15.h,
              ),
              Center(
                child: TextButton(
                    onPressed: function,
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font16Regular.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    )),
              )
            ]));
  }
}
