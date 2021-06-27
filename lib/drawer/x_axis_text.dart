//------ Text
import 'dart:math';

import 'package:flutter/material.dart';

class XAxisTextWidget extends StatelessWidget {
  XAxisTextWidget({
    required this.text,
    required this.xCd,
    this.fontSize = 14,
    required this.color,
  });

  String text;
  double xCd;
  double fontSize;
  Color color;

  @override
  Widget build(BuildContext context) {
    print(xCd);
    return Positioned(
      left: xCd - text.length * (fontSize / 4),
      bottom: 0,
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
