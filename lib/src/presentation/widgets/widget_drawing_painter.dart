import 'dart:ui';
import 'package:flutter/material.dart';

class DrawingPainter extends CustomPainter {
  DrawingPainter({this.pointsList});

  List<DrawingPoints>? pointsList;
  List<Offset> offsetPoints = [];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList!.length - 1; i++) {
      var point1 = pointsList?[i].points;
      var point2 = pointsList?[i + 1].points;
      var paint = pointsList?[i].paint;
      if (pointsList?[i] != null && pointsList?[i + 1] != null) {
        if (point2 == null) {
          if (point1 == null) {
            if (paint == null) {
              canvas.drawLine(Offset.infinite, Offset.infinite, Paint());
            } else {
              canvas.drawLine(Offset.infinite, Offset.infinite, paint);
            }
          } else {
            canvas.drawLine(point1, point1, paint!);
          }
        } else {
          if (point1 == null) {
            if (paint == null) {
              canvas.drawLine(Offset.infinite, Offset.infinite, Paint());
            } else {
              canvas.drawLine(Offset.infinite, Offset.infinite, paint);
            }
          } else {
            canvas.drawLine(point1, point2, paint!);
          }
        }
      } else if (pointsList?[i] != null && pointsList?[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(point1!);
        offsetPoints.add(Offset(point1.dx + 0.1, point1.dy + 0.1));
        canvas.drawPoints(PointMode.points, offsetPoints, paint!);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

class DrawingPoints {
  Paint? paint;
  Offset? points;

  DrawingPoints({this.points, this.paint});
}
