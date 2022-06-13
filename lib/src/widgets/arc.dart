import 'dart:math';

import 'package:flutter/material.dart';

class ProgressiveArc extends StatefulWidget {
  final double percentage;
  final Color backgroundColor;
  final Color color;
  final double? backgroundThickness;
  final double thickness;
  final int startAngle;
  final int sweepAngle;
  final StrokeCap strokeCap;
  final PaintingStyle style;
  final bool useCenter;
  final int duration;
  final int reverseDuration;
  final Curve curve;

  /// [startAngle] 0º = 3:00h
  const ProgressiveArc({Key? key, 
    required this.percentage,
    this.backgroundColor = Colors.grey,
    this.color = Colors.blue,
    this.backgroundThickness,
    this.thickness = 15,
    this.startAngle = 180,
    this.sweepAngle = 180,
    this.strokeCap = StrokeCap.butt,
    this.style = PaintingStyle.stroke,
    this.useCenter = false,
    this.duration = 1500,
    this.reverseDuration = 2500,
    this.curve = Curves.decelerate,
  }) : super(key: key);

  @override
  _ProgressiveArcState createState() => _ProgressiveArcState();
}

class _ProgressiveArcState extends State<ProgressiveArc>
    with SingleTickerProviderStateMixin {
  late final AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
      reverseDuration: Duration(milliseconds: widget.reverseDuration),
      // Duration(
      //   milliseconds: widget.reverseDuration ~/ (1 - widget.percentage / 100),
      // ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(milliseconds: 250), () async {
    _controller!
      ..forward(from: 0)
      ..addStatusListener(
        (AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            _controller!.animateBack(
              widget.percentage / 100,
              curve: widget.curve,
            );
          }
        },
      );
    //});
    return AnimatedBuilder(
      animation: _controller!,
      builder: (BuildContext context, Widget? child) {
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: _Arc(
              _controller!.value,
              widget.backgroundColor,
              widget.color,
              widget.backgroundThickness,
              widget.thickness,
              widget.startAngle,
              widget.sweepAngle,
              widget.strokeCap,
              widget.style,
              widget.useCenter,
            ),
          ),
        );
      },
    );
  }
}

class _Arc extends CustomPainter {
  final double percentage;
  final Color backgroundColor;
  final Color color;
  final double? backgroundThickness;
  final double thickness;
  final int startAngle;
  final int sweepAngle;
  final StrokeCap strokeCap;
  final PaintingStyle style;
  final bool useCenter;

  _Arc(
    this.percentage,
    this.backgroundColor,
    this.color,
    this.backgroundThickness,
    this.thickness,
    this.startAngle,
    this.sweepAngle,
    this.strokeCap,
    this.style,
    this.useCenter,
  );

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  @override
  Widget? paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final double radius = min(size.width * 0.5, size.height * 0.5);

    double _toRad(degrees) => degrees * pi / 180;
    final double start = _toRad(startAngle); // 0º = 3:00
    final double sweep = _toRad(sweepAngle);

    // Background
    final background = Paint()
      ..color = backgroundColor
      ..strokeWidth = backgroundThickness ?? thickness
      ..strokeCap = strokeCap
      ..style = style;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      start,
      sweep,
      useCenter,
      background,
    );

    // Arc
    final arc = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = strokeCap
      ..style = style;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      start,
      sweep * percentage,
      useCenter,
      arc,
    );
    return null;
  }
}
