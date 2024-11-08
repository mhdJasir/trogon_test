import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class AppLoader extends StatefulWidget {
  const AppLoader({super.key});

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Transform.rotate(
            angle: _controller.value * 2 * math.pi,
            child: CustomPaint(
              painter: IncreasingStrokeArcPainter(),
            ),
          );
        },
      ),
    );
  }
}

class IncreasingStrokeArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: 25,
    );

    final path = Path();
    path.arcTo(
      rect,
      math.pi,
      math.pi * 0.9,
      false,
    );

    PathMetrics pathMetrics = path.computeMetrics();

    for (var pathMetric in pathMetrics) {
      double totalLength = pathMetric.length;
      double currentLength = 0.0;
      double step = 10.0;
      while (currentLength < totalLength) {
        double t = currentLength / totalLength;
        double strokeWidth = 2.0 + (t * 4.0);
        Path extractPath =
        pathMetric.extractPath(currentLength, currentLength + step);
        canvas.drawPath(extractPath, paint..strokeWidth = strokeWidth);
        currentLength += step;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}