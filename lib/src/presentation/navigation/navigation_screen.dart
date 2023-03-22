import 'package:flutter/material.dart';
import '../../configs/configs.dart';
import '../presentation.dart';
import 'package:get/get.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> with ResponsiveWidget {
  late NavigationViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<NavigationViewModel>(
        viewModel: NavigationViewModel(),
        onViewModelReady: (viewModel) {
          _viewModel = viewModel..init();
        },
        child: _buildAppbar(context),
        childMobile: _buildMobileAppbar(context),
        builder: (context, viewModel, appbar) {
          return Scaffold(
            body: Column(
              children: [
                appbar ?? const SizedBox(),
                Expanded(
                  child: Center(
                    child: buildUi(context: context),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return Text("NavigationScreen Desktop");
  }

  @override
  Widget buildMobile(BuildContext context) {
    return Text("NavigationScreen Mobile");
  }

  @override
  Widget buildTablet(BuildContext context) {
    return Text("NavigationScreen Tablet");
  }

  Widget _buildMobileAppbar(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          'app_name'.tr,
        ),
      ),
    );
  }

  Widget _buildAppbar(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('app_name'.tr),
      ),
    );
  }
}
