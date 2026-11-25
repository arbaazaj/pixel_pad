import 'package:flutter/material.dart';

class CanvasState {
  final int gridSize;
  final List<Color> pixels;
  final Color selectedColor;
  final bool showGrid;

  CanvasState({
    required this.gridSize,
    required this.pixels,
    required this.selectedColor,
    this.showGrid = true,
  });

  factory CanvasState.initial({int gridSize = 16}) {
    return CanvasState(
      gridSize: gridSize,
      pixels: List<Color>.filled(gridSize * gridSize, Colors.white),
      selectedColor: Colors.black,
      showGrid: true,
    );
  }

  CanvasState copyWith({
    List<Color>? pixels,
    Color? selectedColor,
    bool? showGrid,
  }) {
    return CanvasState(
      gridSize: gridSize,
      pixels: pixels ?? this.pixels,
      selectedColor: selectedColor ?? this.selectedColor,
      showGrid: showGrid ?? this.showGrid,
    );
  }
}
