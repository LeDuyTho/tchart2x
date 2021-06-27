//----- coordinate axis: trục tọa độ

import 'dart:ui';

import 'package:flutter/material.dart';

class CoordinateAxisWidget extends StatelessWidget {
  CoordinateAxisWidget(
      {required this.width,
      required this.height,
      required this.color,
      required this.strokeWidth});

  double width;
  double height;
  Color color;
  double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(width, height),
        painter: CoordinateAxisPainter(color, strokeWidth: strokeWidth),
      ),
    );
  }
}

class CoordinateAxisPainter extends CustomPainter {
  CoordinateAxisPainter(this.color, {this.strokeWidth = 1});

  Color color;
  double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;

    var x = size.width;
    var y = size.height;

    final pointMode = PointMode.polygon;
    final points = [
      Offset(0, 0),
      Offset(0, y),
      Offset(x, y),
    ];
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
