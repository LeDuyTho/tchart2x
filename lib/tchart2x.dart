library tchart2x;

import 'package:flutter/material.dart';

import 'drawer/coordinate_axis.dart';
import 'drawer/line_bar.dart';
import 'drawer/x_axis_text.dart';
import 'drawer/x_grid.dart';
import 'drawer/y_axis_text.dart';
import 'drawer/y_grid.dart';
import 'models/line_bar_item.dart';
import 'models/t_chart_style.dart';
export 'models/t_chart_style.dart';
export 'models/line_bar_item.dart';

class HorizontalLineChart extends StatefulWidget {
  HorizontalLineChart({
    Key? key,
    this.xGridNumPoint = 0,
    this.yGridNumPoint = 0,
    required this.width,
    required this.height,
    this.paddingTop = 0,
    this.paddingLeft = 0,
    this.paddingRight = 0,
    this.paddingBottom = 0,
    this.xLabels = const [],
    this.yLabels = const [],
    required this.dataBuilder,
    this.chartStyle,
  }) : super(key: key);

  List<String> xLabels;
  List<String> yLabels;
  List<List<LineBarItem>> Function(List<double> xGrids) dataBuilder;

  double width;
  double height;

  double paddingTop;
  double paddingLeft;
  double paddingRight;
  double paddingBottom;

  int xGridNumPoint;
  int yGridNumPoint;

  TChartStyle? chartStyle;

  @override
  _HorizontalLineChartState createState() => _HorizontalLineChartState();
}

class _HorizontalLineChartState extends State<HorizontalLineChart> {
  late double w;
  late double h;

  List<double> xGrids = [];
  List<double> yGrids = [];
  late TChartStyle chartStyle;

  @override
  void initState() {
    w = widget.width - (widget.paddingLeft + widget.paddingRight);
    h = widget.height - (widget.paddingTop + widget.paddingBottom);

    _calcXGrid();
    _calcYGrid();

    super.initState();
  }

  _configStyle() {
    if (widget.chartStyle == null) {
      chartStyle = new TChartStyle();
    } else {
      chartStyle = widget.chartStyle!;
    }
  }

  _calcXGrid() {
    int len = widget.xLabels.length;

    var each = w / (len + 1);

    for (int i = 0; i < len; i++) {
      var xGrid = each * (i + 1);
      xGrids.add(xGrid);
    }

    yGrids = yGrids.reversed.toList();
  }

  _calcYGrid() {
    int len = widget.yLabels.length;

    var each = h / (len + 1);

    for (int i = 0; i < len; i++) {
      var yGrid = each * (i + 1);
      yGrids.add(yGrid);
    }

    yGrids = yGrids.reversed.toList();
  }

  _prepareXAxisTextWidget() {
    List<XAxisTextWidget> xas = [];
    int len = widget.xLabels.length;

    var each =
        (widget.width - (widget.paddingLeft + widget.paddingRight)) / (len + 1);

    for (int i = 0; i < len; i++) {
      var x = each * (i + 1) + widget.paddingLeft;
      xas.add(new XAxisTextWidget(
        xCd: x,
        text: widget.xLabels[i],
        color: chartStyle.textColor,
      ));
    }

    return xas;
  }

  _prepareYAxisTextWidget() {
    List<YAxisTextWidget> yas = [];
    int len = widget.yLabels.length;

    var each = (widget.height - (widget.paddingTop + widget.paddingBottom)) /
        (len + 1);

    for (int i = 0; i < len; i++) {
      var y = each * (i + 1) + widget.paddingBottom;
      yas.add(new YAxisTextWidget(
        yCd: y,
        text: widget.yLabels[i],
        color: chartStyle.textColor,
      ));
    }

    return yas;
  }

  ///== Build Line Bar
  _buildLineBarWidget() {
    List<LineBarWidget> lineBarItems = [];

    var lst = widget.dataBuilder(xGrids);

    for (int i = 0; i < lst.length; i++) {
      List<LineBarItem> childList = lst[i];
      for (int j = 0; j < childList.length; j++) {
        var item = childList[j];
        lineBarItems.add(new LineBarWidget(
          xBeginCd: item.x1,
          xEndCd: item.x2,
          yCd: yGrids[i],
          width: w,
          height: h,
          color: (item.color != null) ? item.color! : chartStyle.lineBarColor,
          strokeWidth: (item.strokeWidth != null)
              ? item.strokeWidth!
              : chartStyle.lineBarStrokeWidth,
        ));
      }
    }

    return lineBarItems;
  }

  @override
  Widget build(BuildContext context) {
    _configStyle();
    return Container(
      color: chartStyle.backgroundColor,
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(widget.paddingLeft, widget.paddingTop,
                widget.paddingRight, widget.paddingBottom),
            child: Stack(
              children: [
                CoordinateAxisWidget(
                  width: w,
                  height: h,
                  color: chartStyle.axisColor,
                  strokeWidth: chartStyle.axisStrokeWidth,
                ),
                XGridPainterWidget(
                  width: w,
                  height: h,
                  numPoint: widget.xGridNumPoint,
                  color: chartStyle.gridColor,
                ),
                YGridPainterWidget(
                  width: w,
                  height: h,
                  numPoint: widget.yGridNumPoint,
                  color: chartStyle.gridColor,
                ),
                (widget.dataBuilder != null &&
                        widget.dataBuilder(xGrids).length > 0)
                    ? Stack(
                        children: _buildLineBarWidget(),
                      )
                    : Center(),
                // LineBarWidget(
                //   xBeginCd: 0,
                //   xEndCd: 100,
                //   yCd: 260 / 3,
                //   width: w,
                //   height: h,
                // ),
              ],
            ),
          ),
          Stack(
            children: _prepareXAxisTextWidget(),
          ),
          Stack(
            children: _prepareYAxisTextWidget(),
          )

          // XAxisTextWidget(
          //   xCd: 0,
          //   text: 'value',
          // ),
          // Stack(
          //   children: [
          //     YAxisTextWidget(
          //       yCd: 20.0 + (60 * 1),
          //       text: '1',
          //     ),
          //     YAxisTextWidget(
          //       yCd: 20.0 + (60 * 2),
          //       text: '2',
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
