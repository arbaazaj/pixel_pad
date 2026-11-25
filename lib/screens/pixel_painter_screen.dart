import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_pad/cubit/canvas_cubit.dart';
import 'package:pixel_pad/cubit/canvas_state.dart';
import 'package:pixel_pad/widgets/pixel_canvas_painter.dart';

class PixelPainterScreen extends StatelessWidget {
  const PixelPainterScreen({super.key});

  static const List<Color> _palette = [
    Colors.black,
    Colors.redAccent,
    Colors.orange,
    Colors.amber,
    Colors.green,
    Colors.blueAccent,
    Colors.purpleAccent,
    Colors.white,
  ];

  void _handleTouch(
    Offset localPosition,
    double canvasSize,
    int gridSize,
    BuildContext context,
  ) {
    final double pixelSize = canvasSize / gridSize;
    final int col = (localPosition.dx / pixelSize).floor();
    final int row = (localPosition.dy / pixelSize).floor();

    context.read<CanvasCubit>().paintPixel(row, col);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121214),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Pixel Pad',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          BlocBuilder<CanvasCubit, CanvasState>(
            buildWhen: (prev, curr) => prev.showGrid != curr.showGrid,
            builder: (context, state) {
              return IconButton(
                onPressed: () => context.read<CanvasCubit>().toggleGrid(),
                icon: Icon(
                  state.showGrid ? Icons.grid_on : Icons.grid_off,
                  color: Colors.white,
                ),
              );
            },
          ),
          IconButton(
            onPressed: () => context.read<CanvasCubit>().clearCanvas(),
            icon: Icon(Icons.delete_outline, color: Colors.redAccent),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.4),
                            blurRadius: 16,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: LayoutBuilder(
                        builder: (context, constrains) {
                          final canvasSize = constrains.maxWidth;

                          return BlocBuilder<CanvasCubit, CanvasState>(
                            builder: (context, state) {
                              return GestureDetector(
                                onTapDown: (details) => _handleTouch(
                                  details.localPosition,
                                  canvasSize,
                                  state.gridSize,
                                  context,
                                ),
                                onPanStart: (details) => _handleTouch(
                                  details.localPosition,
                                  canvasSize,
                                  state.gridSize,
                                  context,
                                ),
                                onPanUpdate: (details) => _handleTouch(
                                  details.localPosition,
                                  canvasSize,
                                  state.gridSize,
                                  context,
                                ),
                                child: CustomPaint(
                                  size: Size(canvasSize, canvasSize),
                                  painter: PixelCanvasPainter(
                                    pixels: state.pixels,
                                    gridSize: state.gridSize,
                                    showGrid: state.showGrid,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                color: Color(0xFF1E1E2C),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: BlocBuilder<CanvasCubit, CanvasState>(
                buildWhen: (prev, curr) =>
                    prev.selectedColor != curr.selectedColor,
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _palette.map((color) {
                      final isSelected = state.selectedColor == color;
                      final isEraser = color == Colors.white;

                      return GestureDetector(
                        onTap: () =>
                            context.read<CanvasCubit>().selectColor(color),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 150),
                          width: isSelected ? 42 : 34,
                          height: isSelected ? 42 : 34,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.cyanAccent
                                  : Colors.white24,
                              width: isSelected ? 3 : 1.5,
                            ),
                          ),
                          child: isEraser
                              ? Icon(
                                  Icons.cleaning_services,
                                  size: 18,
                                  color: Colors.black87,
                                )
                              : null,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
