import 'package:flutter/material.dart';
import 'package:flutter_app/src/configs/configs.dart';
import 'package:get/get.dart';

class WidgetElevatedButton extends StatelessWidget {
  final Function() action;
  final String title;
  final double? width;
  final TextStyle? textStyle;
  final Color? color;

  const WidgetElevatedButton(
      {required this.title, required this.action, this.width, this.textStyle, this.color});

  @override
  Widget build(BuildContext context) {
    Widget child = Center(
      child: Text(title.tr, style: textStyle ?? AppTextStyles.normalBold),
    );
    return ElevatedButton(
      onPressed: action,
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
          backgroundColor: MaterialStateProperty.all<Color>(color ?? AppColors.primary)),
      child: width != null
          ? SizedBox(
              width: width,
              child: child,
            )
          : child,
    );
  }
}
