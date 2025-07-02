import 'package:flutter/material.dart';
import 'dart:math' as math;

/// 1. Center Notch (half-circle)
class CenterNotchNavBarPainter extends CustomPainter {
  final Color color;
  final double notchRadius;
  final double notchCenterX;
  final double cornerRadius;

  CenterNotchNavBarPainter({
    required this.color,
    required this.notchRadius,
    required this.notchCenterX,
    this.cornerRadius = 32.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    // Notch parameters
    final double notchWidth = notchRadius * 2.8; // Wider than FAB
    final double notchDepth = notchRadius * 0.7; // Shallower than FAB

    final double left = 0;
    final double right = size.width;
    final double top = 0;
    final double bottom = size.height;

    final double notchStart = notchCenterX - notchWidth / 2;
    final double notchEnd = notchCenterX + notchWidth / 2;

    final path = Path();
    // Start at top-left corner
    path.moveTo(left + cornerRadius, top);

    // Top left corner
    path.quadraticBezierTo(left, top, left, top + cornerRadius);

    // Left edge
    path.lineTo(left, bottom - cornerRadius);

    // Bottom left corner
    path.quadraticBezierTo(left, bottom, left + cornerRadius, bottom);

    // Bottom edge
    path.lineTo(right - cornerRadius, bottom);

    // Bottom right corner
    path.quadraticBezierTo(right, bottom, right, bottom - cornerRadius);

    // Right edge
    path.lineTo(right, top + cornerRadius);

    // Top right corner
    path.quadraticBezierTo(right, top, right - cornerRadius, top);

    // Top edge to notch start
    path.lineTo(notchEnd, top);

    // Notch right curve (cubic for smoothness)
    path.cubicTo(
      notchEnd - notchWidth * 0.15,
      top, // control point 1
      notchCenterX + notchWidth * 0.22,
      notchDepth, // control point 2
      notchCenterX,
      notchDepth, // end at center bottom of notch
    );

    // Notch left curve (mirror)
    path.cubicTo(
      notchCenterX - notchWidth * 0.22,
      notchDepth, // control point 1
      notchStart + notchWidth * 0.15,
      top, // control point 2
      notchStart,
      top, // end at notch start
    );

    // Close path back to left
    path.lineTo(left + cornerRadius, top);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 2. Center Diamond Notch
class CenterDiamondNotchNavBarPainter extends CustomPainter {
  final Color color;
  final double notchSize;
  final double notchCenterX;
  final double cornerRadius;

  CenterDiamondNotchNavBarPainter({
    required this.color,
    required this.notchSize,
    required this.notchCenterX,
    this.cornerRadius = 20.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    final path =
        Path()
          ..moveTo(0, cornerRadius)
          ..quadraticBezierTo(0, 0, cornerRadius, 0)
          ..lineTo(notchCenterX - notchSize, 0)
          // Diamond notch
          ..lineTo(notchCenterX, -notchSize)
          ..lineTo(notchCenterX + notchSize, 0)
          ..lineTo(size.width - cornerRadius, 0)
          ..quadraticBezierTo(size.width, 0, size.width, cornerRadius)
          ..lineTo(size.width, size.height - cornerRadius)
          ..quadraticBezierTo(
            size.width,
            size.height,
            size.width - cornerRadius,
            size.height,
          )
          ..lineTo(cornerRadius, size.height)
          ..quadraticBezierTo(0, size.height, 0, size.height - cornerRadius)
          ..lineTo(0, cornerRadius)
          ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 3. Rounded Rectangle (for highlight/indicator styles)
class RoundedRectNavBarPainter extends CustomPainter {
  final Color color;
  final double cornerRadius;

  RoundedRectNavBarPainter({required this.color, this.cornerRadius = 20.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(cornerRadius));
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
