import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:overlay_window/overlay/overlay_screen.dart';

void main() {
  runApp(const MyApp());
}

@pragma("vm:entry-point")
void overlayMain() {
  runApp(const MaterialApp(home: OverlayScreen()));
}

class OverlayScreen extends StatelessWidget {
  const OverlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.blue,
          child: const OverlayScreen1()
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> startOverlay() async {
    bool? permission = await FlutterOverlayWindow.isPermissionGranted();

    if (permission != true) {
      await FlutterOverlayWindow.requestPermission();
    }

    await FlutterOverlayWindow.showOverlay(
      height: 400,
      width: 200,
      enableDrag: true,
      alignment: OverlayAlignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: startOverlay,
            child: const Text("Start Floating Window"),
          ),
        ),
      ),
    );
  }
}