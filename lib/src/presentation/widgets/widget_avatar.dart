
import 'package:flutter/material.dart';
import 'package:flutter_app/src/configs/configs.dart';

import 'widget_image_network.dart';

class WidgetAvatar extends StatelessWidget {
  final double radius;
  final String url;
  final double? border;

  const WidgetAvatar({required this.radius, required this.url, this.border});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primary,
      child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: radius - (border ?? 0),
          child: KeyedSubtree(
            key: UniqueKey(),
            child: url.trim().isEmpty
                ? CircleAvatar(
                    radius: radius,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      AppImages.imgLogo,
                      fit: BoxFit.fill,
                      width: radius * 2,
                      height: radius * 2,
                    ),
                  )
                : WidgetImageNetwork(
                    shape: ImageNetworkShape.circle,
                    url: url,
                    width: radius * 2,
                    height: radius * 2,
                    fit: BoxFit.fill,
                  ),
          )),
    );
  }
}
