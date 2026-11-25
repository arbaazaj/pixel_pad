import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_pad/cubit/canvas_cubit.dart';
import 'package:pixel_pad/screens/pixel_painter_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CanvasCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pixel Pad',
        theme: ThemeData.dark(useMaterial3: true),
        home: PixelPainterScreen(),
      ),
    );
  }
}
