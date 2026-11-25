import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_pad/cubit/canvas_state.dart';
import 'package:flutter/material.dart';

class CanvasCubit extends Cubit<CanvasState> {
  CanvasCubit() : super(CanvasState.initial());

  void paintPixel(int row, int col) {
    if (row < 0 || row >= state.gridSize || col < 0 || col >= state.gridSize) {
      return;
    }
    final index = row * state.gridSize + col;
    if (state.pixels[index] == state.selectedColor) return;
    final updatedPixel = List<Color>.from(state.pixels);
    updatedPixel[index] = state.selectedColor;
    emit(state.copyWith(pixels: updatedPixel));
  }

  void selectColor(Color color) {
    emit(state.copyWith(selectedColor: color));
  }

  void toggleGrid() {
    emit(state.copyWith(showGrid: !state.showGrid));
  }

  void clearCanvas() {
    emit(
      state.copyWith(
        pixels: List<Color>.filled(
          state.gridSize * state.gridSize,
          Colors.white,
        ),
      ),
    );
  }
}
