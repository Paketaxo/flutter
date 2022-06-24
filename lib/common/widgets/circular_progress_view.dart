import 'dart:math' as math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:base/common/theme/styles.dart';
import 'package:flutter/material.dart';

class CircularProgressView extends StatefulWidget {
  const CircularProgressView({Key? key, this.size = 120}) : super(key: key);

  final double size;

  @override
  _CircularProgressViewState createState() => _CircularProgressViewState();
}

class _CircularProgressViewState extends State<CircularProgressView> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 20));
    animation = Tween(begin: 0.0, end: 100.0).animate(controller)
    ..addListener(() {
      setState(() {});
    })
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.repeat();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Transform.rotate(
                angle: animation.value,
                child: CustomPaint(
                  painter: CustomCircleProgressIndicator(progress: 75),
                  child: SizedBox(
                    height: widget.size,
                    width: widget.size,
                  )
                )
              )
            ),
            AutoSizeText(
              'Cargando'.toUpperCase(),
              style: headline5,
              textScaleFactor: query.textScaleFactor.clamp(0.8, 1.35),
            )
          ]
        );
      }
    );
  }
}

class CustomCircleProgressIndicator extends CustomPainter {
  double progress;

  CustomCircleProgressIndicator({this.progress = 0});

  @override
  void paint(Canvas canvas, Size size) {
    final completeArc = Paint()
      ..strokeWidth = 3
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset offset = Offset(size.width / 2, size.height / 2);
    double radius = math.min(size.width / 2, size.height / 2);

    double angle = 2 * math.pi * (progress / 100);

    canvas.drawArc(
      Rect.fromCircle(center: offset, radius: radius),
      0,
      angle,
      false,
      completeArc
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}