import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

const _toRadians = math.pi / 180.0;

class PieChart extends StatelessWidget {
  final List<int> values;
  final List<Color> colors;

  const PieChart({
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
            painter: PieChartPainter(values, colors),
          ),
        ),
      ],
    );
  }
}

class PieChartPainter extends CustomPainter {
  final List<int> values;
  final List<Color> colors;
  PieChartPainter(
    this.values,
    this.colors,
  );

  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height / 2);
    var radius = size.width * 0.75 / 2;

    Rect chartRect = Rect.fromCircle(
      center: center,
      radius: radius,
    );

    int total = values.reduce((a, b) => a + b);

    _paintCircle(canvas, total, chartRect);
  }

  void _paintCircle(Canvas canvas, int total, Rect chartRect) {
    Paint sectionPaint = Paint()..style = PaintingStyle.fill;

    double startAngle = -90;
    for (var i = 0; i < values.length; i++) {
      final value = values[i];
      final color = colors[i];

      double sweepAngle = ((value * 360.0) / total);

      sectionPaint.color = color;
      canvas.drawArc(
        chartRect,
        (startAngle + 2) * _toRadians,
        (sweepAngle - 2) * _toRadians,
        true,
        sectionPaint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(PieChartPainter oldDelegate) {
    return !ListEquality().equals(oldDelegate.values, values) ||
        !ListEquality().equals(oldDelegate.colors, colors);
  }
}
