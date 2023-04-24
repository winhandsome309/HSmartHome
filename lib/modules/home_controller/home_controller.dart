// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hsmarthome/util/smart_device_box.dart';

// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hsmarthome/data/provider/getDataAPI.dart';
import 'package:hsmarthome/data/models/adafruit_get.dart';
import 'dart:async';
import 'package:get/get.dart';
// import 'package:hsmarthome/pages/app/home_page/home_page.dart';
import 'package:rxdart/rxdart.dart';

import '../../pages/app/home_page/home_page.dart';

class HomeController extends GetxController {
  // padding constants
  final double horizontalPadding = 30;
  final double verticalPadding = 25;

  final RxInt _currentIndex = 0.obs;
  get currentIndex => _currentIndex.value;

  late StreamController<AdafruitGET> alarmStream =
      StreamController<AdafruitGET>.broadcast();
  late StreamController<AdafruitGET> doorStream =
      StreamController<AdafruitGET>.broadcast();
  late StreamController<AdafruitGET> fanStream =
      StreamController<AdafruitGET>.broadcast();
  late StreamController<AdafruitGET> gasStream =
      StreamController<AdafruitGET>.broadcast();
  late StreamController<AdafruitGET> gasAlarmStream =
      StreamController<AdafruitGET>.broadcast();
  late StreamController<AdafruitGET> ledStream =
      StreamController<AdafruitGET>.broadcast();
  late StreamController<AdafruitGET> lightStream =
      StreamController<AdafruitGET>.broadcast();
  late StreamController<AdafruitGET> lightLedStream =
      StreamController.broadcast();
  late StreamController<AdafruitGET> tempStream = StreamController.broadcast();
  late StreamController<AdafruitGET> tempFanStream =
      StreamController.broadcast();

  static String noti = "";
  static String password = "";
  static double fanSpeed = 0.0;
  static double gasValue = 0.0;
  static String gasAlarm = "";
  static RxString ledValue = "0x000000".obs;
  static double lightValue = 0.0;
  static String lightLed = "";
  static double tempValue = 0.0;
  static String tempFan = "";

  // static List<bool> isToggled = [false, false, false, false];

  onSwitched(int index) {
    if (index == 0) {
      if (ledValue == '#000000'.obs) {
        ledControl('#ffffff'.obs);
      } else {
        HomePage.reset(0);
        ledControl('#000000'.obs);
      }
    } else if (index == 1) {
      if (fanSpeed != 0) {
        HomePage.reset(1);
        fanControl(0);
      } else {
        fanControl(50);
      }
    } else if (index == 2) {
      if (gasAlarm == 'ON') {
        gasAlarmControl('OFF');
      } else {
        gasAlarmControl('ON');
      }
    } else if (index == 3) {
      if (password.length == 10) {
        // String a = password.substring(0, 3);
        String b = password.substring(4);
        passControl('ON-$b');
      } else {
        // String a = password.substring(0, 2);
        String b = password.substring(3);
        passControl('OFF-$b');
      }
    }
  }

  passControl(String value) async {
    // if (value.length == 6) password = value;
    // if (value == "OFF") password = 'OFF';
    // getDataAPI.updateDoorData(value);
    // if (value == 'ON') {
    //   AdafruitGET pass = await getDataAPI.getDoorData();
    //   password = pass.lastValue!;
    // }
    getDataAPI.updateDoorData(value);
    if (value[0] == 'C' || value[1] == 'P') {
      if (value[0] == 'C') {
        password = 'ON-${value.substring(7)}';
      } else {
        password = 'ON-${value.substring(5)}';
      }
    } else {
      password = value;
    }
  }

  fanControl(double value) {
    fanSpeed = value;
    var k = value.round();
    getDataAPI.updateFanData(k.toString());
  }

  gasAlarmControl(String value) {
    gasAlarm = value;
    getDataAPI.updateGasAlarmData(value);
  }

  ledControl(RxString value) {
    ledValue = value;
    getDataAPI.updateLedData(value.toString());
  }

  lightLedControl(String value) {
    lightLed = value;
    getDataAPI.updateLightLedData(value);
  }

  tempFanControl(String value) {
    tempFan = value;
    getDataAPI.updateTempFanData(value);
  }

  // fanSpeedControl(double valueChange) {
  //   fanSpeed = valueChange;
  //   getDataAPI.updateFanSpeedData(valueChange.toString());
  // }

  retreveSensorData() async {
    // AdafruitGET led = await getDataAPI.getLedData();
    // AdafruitGET ledColor = await getDataAPI.getLedColorData();
    // AdafruitGET fanSwitch = await getDataAPI.getFanSwitchData();
    // AdafruitGET fanSpeed = await getDataAPI.getFanSpeedData();
    // AdafruitGET pass = await getDataAPI.getPassData();
    // print(led.lastValue);
    // ledStream.add(led);
    // ledColorStream.add(ledColor);
    // fanSwitchStream.add(fanSwitch);
    // fanSpeedStream.add(fanSpeed);
    // passStream.add(pass);
    AdafruitGET alarm = await getDataAPI.getAlarmData();
    AdafruitGET light = await getDataAPI.getLightData();
    AdafruitGET temp = await getDataAPI.getTempData();
    AdafruitGET gas = await getDataAPI.getGasData();
    noti = alarm.lastValue!;
    lightValue = double.parse(light.lastValue!);
    tempValue = double.parse(temp.lastValue!);
    gasValue = double.parse(gas.lastValue!);
    alarmStream.add(alarm);
    lightStream.add(light);
    tempStream.add(temp);
    gasStream.add(gas);
  }

  getSmartSystemStatus() async {
    var fanSpeedData = await getDataAPI.getFanData();
    var doorData = await getDataAPI.getDoorData();
    var gasAlarmData = await getDataAPI.getGasAlarmData();
    var ledData = await getDataAPI.getLedData();
    var lightLedData = await getDataAPI.getLightLedData();
    var tempFanData = await getDataAPI.getTempFanData();

    fanSpeed = double.parse(fanSpeedData.lastValue!);
    password = doorData.lastValue!;
    gasAlarm = gasAlarmData.lastValue!;
    ledValue.value = ledData.lastValue!;
    lightLed = lightLedData.lastValue!;
    tempFan = tempFanData.lastValue!;

    // var valueLed = int.parse(ledData.lastValue!);
    // led.value = ledData.lastValue!;

    // var valueFanSwitch = int.parse(fanSwitchData.lastValue!);
    // var valueFanSpeed = double.parse(fanSpeedData.lastValue!);
    // var valueAlarm = int.parse(alarmData.lastValue!);
    // var valueDoor = int.parse(doorData.lastValue!);
    // var valuePass = passData.lastValue!;

    // if (valueLed == 1) {
    //   isToggled[0] = true;
    // } else if (valueLed == 0) {
    //   isToggled[0] = false;
    // }
    // if (valueFanSwitch == 1) {
    //   isToggled[1] = true;
    // } else if (valueFanSwitch == 0) {
    //   isToggled[1] = false;
    // }
    // if (valueAlarm == 1) {
    //   isToggled[2] = true;
    // } else if (valueAlarm == 0) {
    //   isToggled[2] = false;
    // }
    // if (valueDoor == 1) {
    //   isToggled[3] = true;
    // } else if (valueDoor == 0) {
    //   isToggled[3] = false;
    // }

    // fanSpeed = valueFanSpeed;
    // password = valuePass;
  }

  streamInit() {
    alarmStream = BehaviorSubject();
    doorStream = BehaviorSubject();
    fanStream = BehaviorSubject();
    gasStream = BehaviorSubject();
    gasAlarmStream = BehaviorSubject();
    ledStream = BehaviorSubject();
    lightStream = BehaviorSubject();
    lightLedStream = BehaviorSubject();
    tempStream = BehaviorSubject();
    tempFanStream = BehaviorSubject();
    getSmartSystemStatus();
    Timer.periodic(
      const Duration(seconds: 3),
      (_) {
        // getSmartSystemStatus();
        retreveSensorData();
      },
    );
  }

  @override
  void onInit() {
    streamInit();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // tempStream.close();
    // gasStream.close();
    // ledStream.close();
    // ledColorStream.close();
    // fanSwitchStream.close();
    // fanSpeedStream.close();
    // alarmStream.close();
    // doorStream.close();
    // passStream.close();
    alarmStream.close();
    doorStream.close();
    fanStream.close();
    gasStream.close();
    gasAlarmStream.close();
    ledStream.close();
    lightStream.close();
    lightLedStream.close();
    tempStream.close();
    tempFanStream.close();
    super.onClose();
  }
}
