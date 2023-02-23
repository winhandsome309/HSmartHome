// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hsmarthome/util/smart_device_box.dart';
import 'package:hsmarthome/data/provider/tempHumidAPI.dart';
import 'package:hsmarthome/data/models/adafruit_get.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:hsmarthome/pages/app/home_page/home_page.dart';

class HomeController extends GetxController {
  // padding constants
  final double horizontalPadding = 30;
  final double verticalPadding = 25;

  RxInt _currentIndex = 0.obs;
  get currentIndex => _currentIndex.value;

  late StreamController<AdafruitGET> ledStream;

  static bool ledToggled = false;

  HomePage a = new HomePage();

  // bool funct() {
  //   initialStateLed();
  //   return ledToggled;
  // }

  // Future initialStateLed() async {
  //   ledStream = StreamController();
  //   var data = await TempHumidAPI.getLed1Data();
  //   var value = int.parse(data.lastValue!);
  //   if (value == 1) {
  //     ledToggled = true;
  //   } else if (value == 0) {
  //     ledToggled = false;
  //   }
  //   AdafruitGET led = await TempHumidAPI.getLed1Data();
  //   print(led.lastValue);
  //   ledStream.add(led);
  // }

  // setCurrentIndex(int index) {
  //   _currentIndex.value = index;
  //   if (index == 1 || index == 2) {
  //     ledStream.close();
  //   } else if (index == 0) {
  //     streamInit();
  //   }
  // }

  onSwitched(int index) {
    ledToggled = !ledToggled;
    if (index == 0) {
      var value = ledToggled ? "1" : "0";
      TempHumidAPI.updateLed1Data(value);
    }
  }

  retreveSensorData() async {
    // AdafruitGET humidity data fetch
    AdafruitGET led = await TempHumidAPI.getLed1Data();
    print(led.lastValue);
    ledStream.add(led);
  }

  getSmartSystemStatus() async {
    var data = await TempHumidAPI.getLed1Data();
    var value = int.parse(data.lastValue!);
    print('Hello$value');
    if (value == 1) {
      ledToggled = true;
    } else if (value == 0) {
      ledToggled = false;
    }
  }

  streamInit() {
    ledStream = StreamController();
    getSmartSystemStatus();
    retreveSensorData();
  }

  // @override
  // void onInit() {
  //   streamInit();
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  //   ledStream.close();
  // }
}
