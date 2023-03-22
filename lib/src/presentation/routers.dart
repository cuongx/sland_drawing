import 'package:flutter/material.dart';
import 'package:flutter_app/src/presentation/presentation.dart';

import 'navigation/navigation_screen.dart';

class Routers {
  static const String navigation = "/navigation";
  static const String listLand = "/listLand";
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic arguments = settings.arguments;
    switch (settings.name) {
      case navigation:
        return animRoute(NavigationScreen(), name: navigation);
      case listLand:
        return animRoute(
            ListLandsScreen(
              initInfo: arguments,
            ),
            name: listLand,
            arguments: arguments);
      default:
        return animRoute(Center(child: Text('No route defined for ${settings.name}')),
            name: "/error");
    }
  }

  static Route animRoute(Widget page,
      {Offset? beginOffset, required String name, Object? arguments}) {
    return PageRouteBuilder(
      settings: RouteSettings(name: name, arguments: arguments),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = beginOffset ?? Offset(0.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Offset _center = Offset(0.0, 0.0);
  static Offset _top = Offset(0.0, 1.0);
  static Offset _bottom = Offset(0.0, -1.0);
  static Offset _left = Offset(-1.0, 0.0);
  static Offset _right = Offset(1.0, 0.0);
}
