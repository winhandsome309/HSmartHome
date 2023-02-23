import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hsmarthome/util/smart_device_box.dart';
import 'package:hsmarthome/data/provider/tempHumidAPI.dart';
import 'package:hsmarthome/data/models/adafruit_get.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:hsmarthome/modules/home_controller/home_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  _HomePageState asynLed = new _HomePageState();

  initialLed() {
    asynLed.mySmartDevices[0][2] = true;
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // padding constants
  final double horizontalPadding = 30;
  final double verticalPadding = 25;

  final controller = Get.put(HomeController());

  bool a = true;
  // list of smart devices
  List mySmartDevices = [
    // [ smartDeviceName, iconPath , powerStatus ]
    ["Smart Light", "lib/images/light-bulb.png", false],
    ["Smart AC", "lib/images/air-conditioner.png", false],
    ["Smart TV", "lib/images/smart-tv.png", false],
    ["Smart Fan", "lib/images/fan.png", false],
  ];

  // power button switched
  powerSwitchChanged(bool value, int index) {
    setState(() {
      mySmartDevices[index][2] = value;
    });
    controller.onSwitched(0);
  }

  // void onReady() {
  //   super.onReady();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // app bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // menu icon
                  Icon(
                    Icons.menu,
                    size: 45,
                    color: Colors.grey[800],
                  ),

                  // account icon
                  Icon(
                    Icons.account_circle,
                    size: 45,
                    color: Colors.grey[800],
                  )
                ],
              ),
            ),

            const SizedBox(height: 10),

            // welcome home
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Home,",
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
                  ),
                  Text(
                    'Thang Nguyen',
                    style: GoogleFonts.bebasNeue(fontSize: 60),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Divider(
                thickness: 1,
                color: Color.fromARGB(255, 204, 204, 204),
              ),
            ),

            const SizedBox(height: 25),

            // smart devices grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                "Smart Devices",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // grid
            Expanded(
              child: GridView.builder(
                itemCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 25),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.3,
                ),
                itemBuilder: (context, index) {
                  return SmartDeviceBox(
                    smartDeviceName: mySmartDevices[index][0],
                    iconPath: mySmartDevices[index][1],
                    powerOn: mySmartDevices[index][2],
                    onChanged: (value) => powerSwitchChanged(value, index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
