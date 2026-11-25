import 'package:flutter/material.dart';

class PixelCanvasPainter extends CustomPainter {
  final List<Color> pixels;
  final int gridSize;
  final bool showGrid;

  PixelCanvasPainter({
    super.repaint,
    required this.pixels,
    required this.gridSize,
    required this.showGrid,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double pixelSize = size.width / gridSize;
    final Paint fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = false;

    for (int i = 0; i < pixels.length; i++) {
      final int row = i ~/ gridSize;
      final int col = i % gridSize;

      fillPaint.color = pixels[i];
      canvas.drawRect(
        Rect.fromLTWH(col * pixelSize, row * pixelSize, pixelSize, pixelSize),
        fillPaint,
      );
    }

    if (showGrid) {
      final Paint gridPaint = Paint()
        ..color = Colors.grey.shade300
        ..strokeWidth = 0.8;

      for (int i = 0; i <= gridSize; i++) {
        final double pos = i * pixelSize;
        canvas.drawLine(Offset(pos, 0), Offset(pos, size.height), gridPaint);
        canvas.drawLine(Offset(0, pos), Offset(size.width, pos), gridPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant PixelCanvasPainter oldDelegate) {
    return oldDelegate.pixels != pixels || oldDelegate.showGrid != showGrid;
  }
}
