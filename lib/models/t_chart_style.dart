import 'package:flutter/material.dart';

class TChartStyle {
  TChartStyle({
    this.backgroundColor = Colors.white,
    this.lineBarColor = Colors.blue,
    this.lineBarStrokeWidth = 4.0,
    this.textColor = Colors.black87,
    this.gridColor = const Color(0xffdddddd),
    this.axisColor = const Color(0xffb3b3b3), //(0xffccd6eb),
    this.axisStrokeWidth = 1.1,
  });

  // màu nền
  Color backgroundColor;

  // màu thanh ngang
  Color lineBarColor;

  // độ rộng thanh ngang
  double lineBarStrokeWidth;

  // màu text
  Color textColor;

  // màu lưới
  Color gridColor;

  // màu trục tọa độ
  Color axisColor;

  // độ rộng trục tọa độ
  double axisStrokeWidth;
}
