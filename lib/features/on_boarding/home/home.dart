import 'package:flutter/material.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart' show AppTextStyles;

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'مرحبا بيك ادخل برجلك اليمين',
          style: AppTextStyles.font25Bold,
        ),
      ),
    );
  }
}
