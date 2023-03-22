import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configs/configs.dart';

class AppHeader extends StatelessWidget {
  final double headerHeight;
  final String headerImage;
  final Color headerColor;
  final bool isApplyLeading;
  final String title;
  final Color titleColor;
  final Widget? actionWidget;

  const AppHeader(
      {required this.headerHeight,
      required this.headerImage,
      this.headerColor = Colors.white,
      required this.isApplyLeading,
      required this.title,
      this.titleColor = Colors.white,
      this.actionWidget});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: headerHeight,
            width: Get.width,
            color: headerColor,
           ),
        Padding(
            padding: EdgeInsets.only(left: 10, top: 12, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: SizedBox(
                    height: 28,
                    width: 28,
                    child: isApplyLeading ? Icon(Icons.arrow_back) : Container(),
                  ),
                  onTap: isApplyLeading
                      ? () {
                          Get.back();
                        }
                      : null,
                ),
                title != ""
                    ? Text(title,
                        style: headerHeight == 80
                            ? AppStyles.DEFAULT_UTM_HELEVE.copyWith(fontSize: 22, color: titleColor)
                            : AppStyles.DEFAULT_UTM_HELEVE
                                .copyWith(fontSize: 19, color: titleColor))
                    : Image.asset(AppImages.imgLogo, height: 28, width: 110, fit: BoxFit.fitHeight),
                actionWidget == null
                    ? SizedBox(
                        height: 28,
                        width: 28,
                      )
                    : actionWidget!,
              ],
            ))
      ],
    );
  }
}
