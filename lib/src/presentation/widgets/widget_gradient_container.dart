import 'package:flutter/material.dart';
import 'package:flutter_app/src/configs/configs.dart';

class WidgetGradientContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Widget child;

  const WidgetGradientContainer(
      {Key? key,
      this.borderRadius,
      this.padding,
      required this.child,
      this.height,
      this.margin,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: child,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
    );
  }
}
