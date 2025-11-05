import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/customised_widgets/custom_text.dart';
import 'package:flutter/material.dart';

extension CustomTextMeasurement on CustomText {
  /// Returns the exact size (width & height) of this CustomText widget.
  Size measureSize(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final style = getStyle();

    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
      textScaleFactor: textScaleFactor,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size;
  }

  /// get width.
  double measureWidth(BuildContext context) => measureSize(context).width;

  /// get height.
  double measureHeight(BuildContext context) => measureSize(context).height;
}
