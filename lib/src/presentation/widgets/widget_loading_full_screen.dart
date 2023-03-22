import 'package:flutter/material.dart';
import 'package:flutter_app/src/configs/configs.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WidgetLoadingFullScreen extends StatelessWidget {
  final Widget child;
  final Stream<bool> loading;

  const WidgetLoadingFullScreen({Key? key, required this.child, required this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        StreamBuilder<bool>(
            stream: loading,
            builder: (_, snapshot) {
              bool status = snapshot.data ?? false;
              return status ? _LoadingWidget() : Container();
            }),
      ],
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black38,
        constraints: BoxConstraints.expand(),
        alignment: Alignment.center,
        child: Center(
            child: SpinKitCircle(
          color: AppColors.primary,
          size: 55,
        )));
  }
}
