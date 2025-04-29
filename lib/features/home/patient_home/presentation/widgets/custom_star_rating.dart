import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating; // الريتنج مثلا 4.5 - 3.0 الخ
  final double size; // حجم النجوم
  final Color color; // لون النجوم المليانة

  const StarRating({
    super.key,
    required this.rating,
    this.size = 24,
    this.color = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (rating >= index + 1) {
          // نجمة كاملة
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon(Icons.star, color: color, size: size),
          );
        } else if (rating > index && rating < index + 1) {
          // نص نجمة
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon(Icons.star_half, color: color, size: size),
          );
        } else {
          // نجمة فاضية
          return Icon(Icons.star_border, color: color, size: size);
        }
      }),
    );
  }
}
