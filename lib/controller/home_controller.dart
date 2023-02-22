import 'package:flutter/material.dart';
import 'package:hsmarthome/data/models/adafruit_get.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:hsmarthome/data/provider/tempHumidAPI.dart';
// import 'package:hsmarthome/data/models/room_model.dart';
// import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
// import 'package:logging/logging.dart';
// import 'package:stack_trace/stack_trace.dart';

// import 'package:mqtt_client/mqtt_browser_client.dart';
// import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';

class HomeController extends StatefulWidget {
  const HomeController({super.key});

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  // padding constants

  final RxInt _currentIndex = 0.obs;
  get currentIndex => _currentIndex.value;

  bool isToggled = false;

  final double horizontalPadding = 30;
  final double verticalPadding = 25;

  late StreamController<AdafruitGET> tempStream;

  setCurrentIndex(int index) {
    _currentIndex.value = index;
    if (index == 1 || index == 2) {
      tempStream.close();
    } else if (index == 0) {
      streamInit();
    }
  }

  retreveSensorData() async {
    AdafruitGET led = await TempHumidAPI.getLed1Data();
    tempStream.add(led);
  }

  onSwitched() {
    isToggled = !isToggled;
    var value = isToggled ? "1" : "0";
    TempHumidAPI.updateLed1Data(value);
  }

  streamInit() {
    tempStream = StreamController();
    Timer.periodic(
      const Duration(milliseconds: 500),
      (_) {
        retreveSensorData();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => {
                  setCurrentIndex(0),
                },
                child: const Text(
                  'Register now',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () => {
                  onSwitched(),
                },
                child: const Text(
                  'On/Off',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
