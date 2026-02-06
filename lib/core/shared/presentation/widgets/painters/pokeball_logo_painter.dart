import 'package:flutter/material.dart';

class PokeballLogoPainter extends CustomPainter {
  final Color color;

  PokeballLogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final gapHeight = size.height * 0.05;
    final centerRadius = size.width * 0.18;
    final centerInnerRadius = size.width * 0.1;

    final outerCircle = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));

    final middleStrip = Path()
      ..addRect(
        Rect.fromLTWH(
          0,
          size.height / 2 - gapHeight / 2,
          size.width,
          gapHeight,
        ),
      );

    final centerHole = Path()
      ..addOval(Rect.fromCircle(center: center, radius: centerRadius));

    final innerButton = Path()
      ..addOval(Rect.fromCircle(center: center, radius: centerInnerRadius));
    final standardShape = Path.combine(
      PathOperation.difference,
      outerCircle,
      middleStrip,
    );

    final withHole = Path.combine(
      PathOperation.difference,
      standardShape,
      centerHole,
    );

    final finalPath = Path.combine(PathOperation.union, withHole, innerButton);

    canvas.drawPath(finalPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
