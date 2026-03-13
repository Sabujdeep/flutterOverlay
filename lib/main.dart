import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:overlay_window/overlay/overlay_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();

  runApp(const MyApp());
}

/// Overlay entry point
@pragma("vm:entry-point")
void overlayMain() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OverlayScreen(),
    ),
  );
}

/// Alarm callback
@pragma("vm:entry-point")
Future<void> overlayAlarmCallback() async {

    debugPrint("ALARM TRIGGERED");

  await FlutterOverlayWindow.showOverlay(
    height: 400,
    width: 200,
    enableDrag: true,
    alignment: OverlayAlignment.center,
  );
}

class OverlayScreen extends StatelessWidget {
  const OverlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.transparent,
      child: Center(
        child: OverlayScreen1(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    scheduleOverlay();   // Automatically schedule alarm
  }

  Future<void> scheduleOverlay() async {

    DateTime now = DateTime.now();

    /// schedule 1 minute from now (testing)
    DateTime alarmTime = now.add(const Duration(minutes: 1));

    await AndroidAlarmManager.oneShot(
      const Duration(seconds: 10),
      1,
      overlayAlarmCallback,
      // exact: true,
      wakeup: true,
    );

    debugPrint("Overlay scheduled at: $alarmTime");
  }

  /// Manual overlay (kept for testing)
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
        appBar: AppBar(title: const Text("Overlay Test")),
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