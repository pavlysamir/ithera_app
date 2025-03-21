import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgimage extends StatelessWidget {
  const CustomSvgimage({super.key, this.path, this.hight = 200});
  final String? path;
  final double? hight;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path!,
      height: hight,
    );
  }
}
