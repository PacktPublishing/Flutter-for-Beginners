import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

const _toRadians = math.pi / 180.0;

class RadialChart extends StatelessWidget {  
  final List<int> values;
  final List<Color> colors;

  const RadialChart({
    Key key,
    @required this.values,
    this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: CustomPaint(
            painter: RadialChartPainter(
              values,
              colors,
              Theme.of(context).textTheme.display1,
              Directionality.of(context),
            ),
          ),
        ),
      ],
    );
  }
}

class RadialChartPainter extends CustomPainter {
  final List<int> values;
  final List<Color> colors;
  final TextStyle textStyle;
  final TextDirection textDirection;
  RadialChartPainter(
      this.values, this.colors, this.textStyle, this.textDirection);

  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height / 2);
    var radius = size.width * 0.75 / 2;

    Rect chartRect = Rect.fromCircle(
      center: center,
      radius: radius,
    );

    int total = values.reduce((a, b) => a + b);

    _paintTotal(canvas, total, chartRect);
    _paintCircle(canvas, total, chartRect);
  }

  void _paintTotal(Canvas canvas, int total, Rect chartRect) {
    final totalPainter = TextPainter(
      maxLines: 1,
      text: TextSpan(
        style: textStyle,
        text: "$total",
      ),
      textDirection: textDirection,
    );

    totalPainter.layout(maxWidth: chartRect.width);
    totalPainter.paint(
      canvas,
      chartRect.center.translate(
        -totalPainter.width / 2.0,
        -totalPainter.height / 2.0,
      ),
    );
  }

  void _paintCircle(Canvas canvas, int total, Rect chartRect) {
    Paint sectionPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30.0;

    double startAngle = -90;
    for (var i = 0; i < values.length; i++) {
      final value = values[i];
      final color = colors[i];

      double sweepAngle = ((value * 360.0) / total);

      sectionPaint.color = color;
      canvas.drawArc(
        chartRect,
        (startAngle + 2) * _toRadians,
        (sweepAngle  - 2)* _toRadians,
        false,
        sectionPaint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(RadialChartPainter oldDelegate) {
    return !ListEquality().equals(oldDelegate.values, values);
  }
}
