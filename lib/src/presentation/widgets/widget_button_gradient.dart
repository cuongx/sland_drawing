import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configs/configs.dart';
import '../presentation.dart';

class WidgetButtonGradient extends StatelessWidget {
  final bool loading;
  final String title;
  final Function action;
  final Color? colorStart;
  final Color? colorEnd;
  final Color? colorLoading;
  final Alignment? alignmentStart;
  final Alignment? alignmentEnd;
  final EdgeInsets? padding;

  const WidgetButtonGradient(
      {this.alignmentStart,
      this.alignmentEnd,
      this.colorLoading,
      this.colorEnd,
      this.colorStart,
      this.loading = false,
      this.padding,
      required this.title,
      required this.action});

  static const double HEIGHT = 40.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: HEIGHT,
      child: ElevatedButton(
        onPressed: loading ? null : action() ?? () {},
        // shape:
        //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        // padding: const EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorStart ?? AppColors.primary, colorEnd ?? AppColors.primary],
                begin: alignmentStart ?? Alignment.bottomCenter,
                end: alignmentEnd ?? Alignment.topCenter,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            padding: padding ?? const EdgeInsets.all(0.0),
            alignment: Alignment.center,
            child: !loading
                ? Text(
                    title.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  )
                : Center(
                    child: WidgetLoading(
                      dotOneColor: colorLoading ?? Colors.white,
                      dotTwoColor: colorLoading ?? Colors.white,
                      dotThreeColor: colorLoading ?? Colors.white,
                      dotType: DotType.circle,
                      duration: Duration(milliseconds: 1000),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
