import 'package:flutter/material.dart';
import 'overlay_screen.dart';

@pragma("vm:entry-point")
void overlayMain() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OverlayScreen1(),
    ),
  );
}