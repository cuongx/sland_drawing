import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WidgetShimmer extends StatelessWidget {
  final Widget child;
  final MaterialColor color;

  const WidgetShimmer( {required this.child,this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: child,
      baseColor: color[300]!,
      highlightColor: color[100]!,
      enabled: true,
    );
  }
}
