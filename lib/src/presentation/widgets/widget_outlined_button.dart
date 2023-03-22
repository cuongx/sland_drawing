import 'package:flutter/material.dart';
import 'package:flutter_app/src/configs/configs.dart';
import 'package:get/get.dart';

class WidgetOutlinedButton extends StatelessWidget {
  final Function()? action;
  final String title;
  final double? width;
  final TextStyle? textStyle;

  const WidgetOutlinedButton({required this.title, this.action, this.width, this.textStyle});

  @override
  Widget build(BuildContext context) {
    Widget child = Center(
      child: Text(title.tr, style: textStyle ?? AppTextStyles.normalBold),
    );
    return OutlinedButton(
      onPressed: action,
      style: ButtonStyle(
          side: MaterialStateProperty.all(BorderSide(color: AppColors.primary)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
      child: width != null
          ? SizedBox(
              width: width,
              child: child,
            )
          : child,
    );
  }
}
