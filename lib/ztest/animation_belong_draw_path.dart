import 'dart:ui';

import 'package:flutter/material.dart';

/// === this is simple example for animation belong draw path

class AnimatedPathPainter extends CustomPainter {
  final Animation<double> _animation;

  AnimatedPathPainter(this._animation) : super(repaint: _animation);

  Path _createAnyPath(Size size) {
    return Path()
      ..moveTo(size.height / 4, size.height / 4)
      ..lineTo(size.height, size.width / 2)
      ..lineTo(size.height / 2, size.width)
      ..quadraticBezierTo(size.height / 2, 100, size.width, size.height);
  }

  ///So given a path and an animation percent, we need to extract a path from the start until that percent:
  Path createAnimatedPath(
    Path originalPath,
    double animationPercent,
  ) {
    // ComputeMetrics can only be iterated once!
    final totalLength =
        originalPath.computeMetrics().fold(0.0, (double prev, PathMetric metric) => prev + metric.length);

    final currentLength = totalLength * animationPercent;

    return extractPathUntilLength(originalPath, currentLength);
  }

  ///So now I only need to extract a path until a given length (not the percent). We need to combine all existing paths until a certain distance.
  ///Then add to this existing path some part of the last path segment.
  // Doing that is pretty straightforward.
  Path extractPathUntilLength(
    Path originalPath,
    double length,
  ) {
    var currentLength = 0.0;

    final path = new Path();

    var metricsIterator = originalPath.computeMetrics().iterator;

    while (metricsIterator.moveNext()) {
      var metric = metricsIterator.current;

      var nextLength = currentLength + metric.length;

      final isLastSegment = nextLength > length;
      if (isLastSegment) {
        final remainingLength = length - currentLength;
        final pathSegment = metric.extractPath(0.0, remainingLength);

        path.addPath(pathSegment, Offset.zero);
        break;
      } else {
        // There might be a more efficient way of extracting an entire path
        final pathSegment = metric.extractPath(0.0, metric.length);
        path.addPath(pathSegment, Offset.zero);
      }

      currentLength = nextLength;
    }

    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final animationPercent = this._animation.value;

    print("Painting + ${animationPercent} - ${size}");

    final path = createAnimatedPath(_createAnyPath(size), animationPercent);

    final Paint paint = Paint();
    paint.color = Colors.amberAccent;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 10.0;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class AnimatedPathDemo extends StatefulWidget {
  //https://stackoverflow.com/questions/50978603/how-to-animate-a-path-in-flutter
  @override
  _AnimatedPathDemoState createState() => _AnimatedPathDemoState();
}

class _AnimatedPathDemoState extends State<AnimatedPathDemo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  void _startAnimation() {
    // _controller.stop();
    // _controller.reset();
    // _controller.repeat(
    //   period: Duration(seconds: 5),
    // );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: const Text('Animated Paint')),
      body: SizedBox(
        height: 300,
        width: 300,
        child: new CustomPaint(
          painter: new AnimatedPathPainter(_controller),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _startAnimation,
        child: new Icon(Icons.play_arrow),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(vsync: this, duration: Duration(seconds: 5));
    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
