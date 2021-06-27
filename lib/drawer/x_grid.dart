//-----  Xgrid: Lưới

import 'package:flutter/material.dart';

class XGridPainterWidget extends StatelessWidget {
  XGridPainterWidget({
    required this.width,
    required this.height,
    this.numPoint = 0,
    required this.color,
  });

  int numPoint;

  double width;
  double height;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(width, height),
        painter: XGridPainter(numPoint: numPoint, color: color),
      ),
    );
  }
}

class XGridPainter extends CustomPainter {
  XGridPainter({this.numPoint = 0,required this.color});

  Color color;
  int numPoint;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
    //..strokeWidth = 1
      ..color = color;

    var x = size.width;
    var y = size.height;

    var each = x / (numPoint + 1);

    for (int i = 0; i <= numPoint; i++) {
      double xGrid = each * (i + 1);
      canvas.drawLine(Offset(xGrid, y), Offset(xGrid, 0), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}