import 'package:flutter/material.dart';
import 'package:flutter_app/src/configs/configs.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class WidgetImageView extends StatelessWidget {
  static const double HEIGHT_APP_BAR = 55;
  final ImageProvider image;

  const WidgetImageView(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: HEIGHT_APP_BAR,
              color: Colors.black,
              child: Center(
                child: Row(
                  children: [
                    _buildLeading(context),
                    _buildTitle(context),
                    _buildAction()
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
                    child: PhotoView(
              imageProvider: image,
            )))
          ],
        ),
      ),
    );
  }

  Widget _buildAction() {
    return SizedBox(
      width: Get.width / 8,
      height: double.maxFinite,
      child: Center(
        child: SizedBox(),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Expanded(
        child: Center(
      child: Text(
        // AppLocalizations.of(context).translate(keyTitle)
        "Image View",
        style: AppTextStyles.normalBold,
      ),
    ));
  }

  Widget _buildLeading(BuildContext context) {
    return SizedBox(
        width: Get.width / 8,
        height: double.maxFinite,
        child: Center(
          child: InkWell(
            onTap: () => Navigator.pop(context, false),
            borderRadius: BorderRadius.circular(100),
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
        ));
  }
}
