//-----  Ygrid: Lưới

import 'package:flutter/material.dart';

class YGridPainterWidget extends StatelessWidget {
  YGridPainterWidget({
    required this.width,
    required this.height,
    this.numPoint = 0,
    required this.color,
  });

  double width;
  double height;
  Color color;

  int numPoint;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(width, height),
        painter: YGridPainter(numPoint: numPoint, color: color),
      ),
    );
  }
}

class YGridPainter extends CustomPainter {
  YGridPainter({this.numPoint = 0,required this.color});

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

    var each = y / (numPoint + 1);

    for (int i = -1; i < numPoint; i++) {
      var yGrid = each * (i + 1);
      canvas.drawLine(Offset(0, yGrid), Offset(x, yGrid), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
