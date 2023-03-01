// import 'dart:html';

// import 'dart:html';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:hsmarthome/util/smart_device_box.dart';
import 'package:get/get.dart';
import 'package:hsmarthome/modules/home_controller/home_controller.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:hsmarthome/data/read_firestore/read_username.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    if (HomeController.ledToggled != mySmartDevices[0][2]) {
      setState(() {
        mySmartDevices[0][2] = HomeController.ledToggled;
      });
    }
    super.initState();
  }

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
    ["Add Device", "lib/images/fan.png", false]
  ];

  // power button switched
  powerSwitchChanged(bool value, int index) {
    setState(() {
      mySmartDevices[index][2] = value;
    });
    controller.onSwitched(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // child: SizedBox(
        //   height: 800,
        //   child: Scrollbar(
        //     child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // app bar
            Padding(
              padding: EdgeInsets.only(
                top: horizontalPadding + 10,
                left: verticalPadding,
                right: verticalPadding,
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
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Home,",
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade800),
                        ),

                        // Text(

                        // documentSnapshot['username'].toString(),
                        //   style: GoogleFonts.bebasNeue(fontSize: 40),
                        // ),
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

            // const SizedBox(height: 10),

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

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: const Color.fromARGB(44, 164, 167, 189),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 35, right: 35),
                        child: Text('00:00\nTP.HCM'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 35, right: 35),
                        child: Text('30'),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: 20,
            //   ),
            //   child: SizedBox(
            //     height: 100,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: <Widget>[
            //         SizedBox(width: 5),
            //         Image.asset(
            //           'lib/images/sun.png',
            //           height: 60,
            //           scale: 10,
            //         ),
            //         SizedBox(width: 5),
            //         Text('30'),
            //         SizedBox(width: 20),
            //         Text('20'),
            //         SizedBox(width: 10),
            //       ],
            //     ),
            //   ),
            // ),

            const SizedBox(
              height: 30,
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Divider(
                thickness: 1,
                color: Color.fromARGB(255, 204, 204, 204),
              ),
            ),

            // SizedBox(
            //   height: 10,
            // ),

            // Container(
            //   padding: const EdgeInsets.all(60),
            //   // margin: const EdgeInsets.symmetric(horizontal: 38),
            //   margin: const EdgeInsets.symmetric(horizontal: 60),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(24),
            //     color: Color.fromARGB(44, 164, 167, 189),
            // ),
            // child: Row(
            //   children: [
            //     Image.asset(
            //       'lib/images/sun.png',
            //       height: 60,
            //       color:  Colors.white ,
            //     ),
            //   ],
            // ),
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           Icon(Icons.energy_savings_leaf_outlined),
            //           Text(
            //             'Estimate energy\nexpenses this month',
            //           )
            //         ],
            //       ),
            //     ],
            //   ),
            // ),

            // const SizedBox(height: 25),

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
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            //   child: Text(
            //     "Smart Devices",
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       fontSize: 20,
            //       color: Colors.grey.shade800,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 10),

            // grid

            // Scrollbar(
            //   child: SizedBox(
            //     height: 492,
            //     child: ListView(
            //       physics: const BouncingScrollPhysics(),
            // children: [
            Expanded(
              child: Scrollbar(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    GridView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.3,
                      ),
                      itemBuilder: (context, index) {
                        return SmartDeviceBox(
                          smartDeviceName: mySmartDevices[index][0],
                          iconPath: mySmartDevices[index][1],
                          powerOn: mySmartDevices[index][2],
                          onChanged: (value) =>
                              powerSwitchChanged(value, index),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            // ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
