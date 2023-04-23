import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gyro/screen/home_screen.dart';
import 'package:gyro/screen/settings_screen.dart';
import 'package:shake/shake.dart';
import 'package:sensors_plus/sensors_plus.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}):super(key:key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  TabController? controller;
  double threshold = 2.7;
  int number = 1;
  ShakeDetector? shakeDetector;
  String gyro = '';

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this);

    // controller!.addListener(tabListener);

    shakeDetector = ShakeDetector.autoStart(
      onPhoneShake: onPhonShake,
      shakeThresholdGravity: threshold, // 민갑도
      shakeSlopTimeMS: 100, // 감지 주기
    );

    userAccelerometerEvents.listen((event) {
      setState(() {
        gyro = '${event.x.toStringAsFixed(1)}, ${event.y.toStringAsFixed(1)}, ${event.z.toStringAsFixed(1)}';
        print(gyro);
      });
    });

  }

  // tabListener() {
  //   setState(() {
  //
  //   });
  // }

  @override
  dispose() {
    // controller!.removeListener(tabListener);
    shakeDetector!.stopListening();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: renderChildren(),
      ),
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren() {
    return [
      HomeScreen(number: number),
      SettingScreen(threshold: threshold, onThresholdChange: onThresholdChange, gyro: gyro),
    ];
  }

  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(
        currentIndex: controller!.index,
        onTap: (int index) {
          setState(() {
            controller!.animateTo(index);
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.edgesensor_high_outlined,), label:'주사위'),
          BottomNavigationBarItem(icon: Icon(Icons.settings,), label: '설정'),
        ]
    );
  }

  void onThresholdChange(double val) {
    setState(() {
      threshold = val;
    });
  }

  void onPhonShake() {
    final rand = Random();

    setState(() {
      number = rand.nextInt(5) + 1;
    });
  }
}


