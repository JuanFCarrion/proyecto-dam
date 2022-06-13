import 'package:flutter/material.dart';

import 'package:proyecto_dam/src/constants/constant.dart';
import 'package:proyecto_dam/src/widgets/widgets.dart';

// ignore: must_be_immutable
class ProgressiveCount extends StatefulWidget {
  final double percentage;
  final double maxValue;

  final int duration;
  final int reverseDuration;
  final Curve curve;

  Color textColor;
  double size;
  bool bold;

  ProgressiveCount({Key? key, 
    required this.percentage,
    required this.maxValue,
    this.duration = 1200,
    this.reverseDuration = 1500,
    this.curve = Curves.decelerate,
    this.textColor = redBackground,
    this.size = 38,
    this.bold = true,
  }) : super(key: key);

  @override
  _ProgressiveCountState createState() => _ProgressiveCountState();
}

class _ProgressiveCountState extends State<ProgressiveCount>
    with SingleTickerProviderStateMixin {
  late final AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      upperBound: widget.maxValue,
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
    // Future.delayed(
    //   Duration(milliseconds: 250),
    //   () async {
    _controller!
      ..forward(from: 0)
      ..addStatusListener(
        (AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            _controller!
                .animateBack(
              widget.percentage / 100 * widget.maxValue,
              curve: widget.curve,
            )
                .then(
              (value) {
                if (_controller!.value < widget.maxValue * 0.1) {
                  widget.textColor = yellow;
                  if (_controller!.value < widget.maxValue * 0.05) {
                    widget.textColor = red;
                  }
                }
              },
            );
          }
        },
      );
    //   },
    // );

    return AnimatedBuilder(
      animation: _controller!,
      builder: (BuildContext context, Widget? child) {
        return text(
          _controller!.value.toStringAsFixed(2) + 'GB',
          size: widget.size,
          bold: widget.bold,
          color: widget.textColor,
        );
      },
    );
  }
}
