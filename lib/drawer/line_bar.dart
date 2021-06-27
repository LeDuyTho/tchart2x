//------ Line Bar

import 'package:flutter/material.dart';
import '../models/animation_path_helpers.dart';

class LineBarWidget extends StatefulWidget {
  LineBarWidget({
    required this.xBeginCd,
    required this.xEndCd,
    required this.yCd,
    required this.width,
    required this.height,
    required this.color,
    required this.strokeWidth,
  });

  double xBeginCd;
  double xEndCd;
  double yCd;

  double width;
  double height;

  double strokeWidth;

  Color color;

  @override
  _LineBarWidgetState createState() => _LineBarWidgetState();
}

class _LineBarWidgetState extends State<LineBarWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  void _startAnimation() {
    _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(widget.width, widget.height),
        painter: LineBarPainter(
          xBeginCd: widget.xBeginCd,
          xEndCd: widget.xEndCd,
          yCd: widget.yCd,
          color: widget.color,
          strokeWidth: widget.strokeWidth,
          animation: _controller,
        ),
      ),
    );
  }
}

class LineBarPainter extends CustomPainter {
  LineBarPainter({
    required this.xBeginCd,
    required this.xEndCd,
    required this.yCd,
    required this.color,
    required this.strokeWidth,
    required this.animation,
  }) : super(repaint: animation);

  double xBeginCd;
  double xEndCd;
  double yCd;

  Color color;

  double strokeWidth;

  Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final animationPercent = //this.animation.value;
        this.animation.drive(CurveTween(curve: Curves.fastOutSlowIn)).value;
    //print("Painting + ${animationPercent} - ${size}");
    final path = createAnimatedPath(_drawPath(size), animationPercent);

    final paint = Paint()
      ..style = PaintingStyle.stroke //PaintingStyle.fill cho _drawLine
      ..strokeWidth = strokeWidth // = 4
      //..strokeCap = StrokeCap.round
      ..color = color;

    var x = size.width;
    var y = size.height;

    canvas.drawPath(path, paint);
  }

  Path _drawPath(Size size) {
    return Path()
      ..moveTo(xBeginCd, yCd)
      ..lineTo(xEndCd, yCd);
  }

  void _drawLine(Canvas canvas, Paint paint) {
    canvas.drawLine(Offset(xBeginCd, yCd), Offset(xEndCd, yCd), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
