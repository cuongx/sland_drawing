import 'package:flutter/material.dart';
import 'package:flutter_app/src/configs/configs.dart';

class WidgetGradientText extends StatelessWidget {
  WidgetGradientText(
    this.text, {
    this.style,
    this.gradient,
  });

  final String text;
  final TextStyle? style;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => (gradient ??
              LinearGradient(
                  colors: [AppColors.primary, AppColors.primary]))
          .createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style ?? AppTextStyles.normalBold,
      ),
    );
  }
}
