import 'package:flutter/material.dart';

class WidgetResponse extends StatelessWidget {
  final Widget? small;
  final Widget? medium;
  final Widget? large;
  final Widget? child;

  const WidgetResponse({this.child, this.large, this.medium, this.small});

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1200;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 800 &&
        MediaQuery.of(context).size.width < 1200;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return small ?? child ?? SizedBox();
        } else if (constraints.maxWidth < 1200 && constraints.maxWidth > 800) {
          return medium ?? child ?? SizedBox();
        } else {
          return large ?? child ?? SizedBox();
        }
      },
    );
  }
}
