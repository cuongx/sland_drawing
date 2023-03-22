import 'package:flutter/material.dart';
import 'widget_gradient_container.dart';

class WidgetGradientBorder extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Widget child;
  final double borderSize;
  final Color color;

  const WidgetGradientBorder(
      {Key? key,
      this.borderRadius,
      this.padding,
      required this.color,
      required this.borderSize,
      required this.child,
      required this.height,
      this.margin,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WidgetGradientContainer(
            width: width,
            height: height,
            child: child,
            padding: padding,
            margin: margin,
            borderRadius: borderRadius),
        Center(
          child: Container(
            width: width - borderSize,
            height: height - borderSize,
            child: child,
            padding: padding,
            margin: margin,
            decoration: BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
