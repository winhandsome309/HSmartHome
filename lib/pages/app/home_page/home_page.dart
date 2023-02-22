import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hsmarthome/util/smart_device_box.dart';
import 'package:hsmarthome/data/provider/tempHumidAPI.dart';
import 'package:hsmarthome/data/models/adafruit_get.dart';
import 'dart:async';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // padding constants
  final double horizontalPadding = 30;
  final double verticalPadding = 25;
  int count = 0;

  RxInt _currentIndex = 0.obs;
  get currentIndex => _currentIndex.value;

  late StreamController<AdafruitGET> ledStream;

  bool ledToggled = false;

  setCurrentIndex(int index) {
    _currentIndex.value = index;
    if (index == 1 || index == 2) {
      ledStream.close();
    } else if (index == 0) {
      streamInit();
    }
  }

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
    bool temp = ledToggled;
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
    // Timer.periodic(
    //   const Duration(seconds: 3),
    //   (_) {
    //     getSmartSystemStatus();
    //     retreveSensorData();
    //   },
    // );
    if (ledToggled == true) {
      setState(() {
        mySmartDevices[0][2] = true;
      });
    }
  }

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
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    setState(() {
      mySmartDevices[index][2] = value;
    });
    onSwitched(0);
    // });
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
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Welcome Home,",
            //         style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
            //       ),
            //       Text(
            //         'Thang Nguyen',
            //         style: GoogleFonts.bebasNeue(fontSize: 60),
            //       ),
            //     ],
            //   ),
            // ),
            GestureDetector(
              onTap: streamInit,
              child: const Text(
                'Register now',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
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
