import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hsmarthome/util/smart_device_box.dart';
import 'package:get/get.dart';
import 'package:hsmarthome/modules/home_controller/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // _HomePageState asynLed = new _HomePageState();
  // final controller = Get.put(HomeController());

  // initialLed() {
  //   asynLed.mySmartDevices[0][2] = true;
  // }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // padding constants

  // CollectionReference users = FirebaseFirestore.instance('users');

  @override
  initState() {
    super.initState();
    if (HomeController.ledToggled != mySmartDevices[0][2]) {
      setState(() {
        mySmartDevices[0][2] = HomeController.ledToggled;
      });
    }
    // feedPage = FeedPage(this.callback);

    // currentPage = feedPage;
  }

  // readData() {
  //   DocumentReference documentReference = FirebaseFirestore.instance.collection('users')
  // }

  final double horizontalPadding = 30;
  final double verticalPadding = 25;

  final controller = Get.put(HomeController());

  bool a = true;
  // list of smart devices
  static List mySmartDevices = [
    // [ smartDeviceName, iconPath , powerStatus ]
    ["Smart Light", "lib/images/light-bulb.png", false],
    ["Gas Detector", "lib/images/gas-detector.png", false],
    ["Camera Door", "lib/images/door-camera.png", false],
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
      backgroundColor: Colors.white,
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
                  // Icon(
                  //   Icons.menu,
                  //   size: 45,
                  //   color: Colors.grey[800],
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Home,",
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade800),
                        ),
                        Text(
                          'Thang Nguyen',
                          style: GoogleFonts.bebasNeue(fontSize: 40),
                        ),
                      ],
                    ),
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

            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Divider(
                thickness: 1,
                color: Color.fromARGB(255, 204, 204, 204),
              ),
            ),

            const SizedBox(height: 25),

            // Container(
            //   padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            //   height: 220,
            //   width: double.infinity,
            //   decoration: const BoxDecoration(
            //     borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(20),
            //       bottomRight: Radius.circular(20),
            //     ),
            //     gradient: LinearGradient(
            //       colors: [
            //         Color(0xff886ff2),
            //         Color(0xff6849ef),
            //       ],
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //     ),
            //   ),
            //   child: Column(
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             'Welcome home, \n THANG NGUYEN',
            //             style: Theme.of(context).textTheme.titleLarge,
            //           ),
            //           Icon(
            //             Icons.account_circle,
            //             size: 45,
            //             color: Colors.grey[800],
            //           )
            //         ],
            //       ),
            //     ],
            //   ),
            // ),

            // const SizedBox(height: 30),

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
