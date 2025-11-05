import 'package:flutter/material.dart';

enum FontType { sfPro, balooBhai2, balsamiqSans }

class CustomText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final FontWeight weight;
  final FontType fontFamily;
  final TextAlign alignment;
  final int maxLines;

  const CustomText({
    super.key,
    required this.text,
    this.size = 24.0,
    this.color = Colors.black,
    this.weight = FontWeight.w500,
    this.fontFamily = FontType.sfPro,
    this.alignment = TextAlign.left,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color, fontWeight: weight),
      textAlign: alignment,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  TextStyle getStyle() {
    return TextStyle(fontSize: size, color: color, fontWeight: weight);
  }
}
