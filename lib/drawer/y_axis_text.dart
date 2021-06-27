import 'dart:math';

import 'package:flutter/material.dart';

class YAxisTextWidget extends StatelessWidget {
  YAxisTextWidget({
    required this.text,
    required this.yCd,
    this.fontSize = 14,
    required this.color,
  });

  String text;
  double yCd;
  double fontSize;
  Color color;

  @override
  Widget build(BuildContext context) {
    double bottom = max(yCd - fontSize / 2, 0);

    return Positioned(
      left: 0,
      bottom: bottom,
      child: Container(
        // color: Colors.red,
        // width: width,
        // height: height,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize, color: color),
          ),
        ),
      ),
    );
  }
}
