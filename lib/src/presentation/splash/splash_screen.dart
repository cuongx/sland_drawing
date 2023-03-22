import 'package:flutter/material.dart';
import 'package:flutter_app/src/configs/configs.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';
import '../presentation.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<SplashViewModel>(
        viewModel: SplashViewModel(),
        onViewModelReady: (viewModel) {
          viewModel.init();
        },
        childMobile: _buildBodyMobile(context),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: child,
          );
        },
        child: _buildBody(context));
  }

  mapLand(int type) {
    return {
      "type": type,
      "provinceId": AppPrefs.provinceGeo.id ?? AppValues.DEFAULT_PROVINCE_ID,
      "callFromSlandStore": true
    };
  }

  Widget _buildBodyMobile(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: GestureDetector(
          onTap: () {
            Get.toNamed(Routers.listLand, arguments: mapLand(0));
            // Navigator.pushNamed(context, Routers.landMap, arguments: mapLand(0));
          },
          child: Text(
            'app_name'.tr,
            style: AppStyles.DEFAULT_TEXT_DRAWER,
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('app_name'.tr),
      ),
    );
  }
}
