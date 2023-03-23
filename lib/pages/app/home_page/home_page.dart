import 'package:flutter/material.dart';
import 'package:hsmarthome/util/smart_device_box.dart';
import 'package:get/get.dart';
import 'package:hsmarthome/modules/home_controller/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hsmarthome/pages/app/home_page/device/led/led.dart';
import 'package:hsmarthome/pages/app/home_page/device/fan/fan.dart';
import 'package:hsmarthome/pages/app/home_page/device/door/door.dart';

import '../../../data/models/adafruit_get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  initState() {
    // for (int i = 0; i < 2; i++) {
    //   if (HomeController.isToggled[i] != mySmartDevices[i][2]) {
    //     setState(() {
    //       mySmartDevices[i][2] = HomeController.isToggled[i];
    //     });
    //   }
    // }
    if (HomeController.ledValue != "0x000000".obs) {
      setState(() {
        mySmartDevices[0][2] = true;
      });
    }
    if (HomeController.fanSpeed != 0) {
      setState(() {
        mySmartDevices[1][2] = true;
      });
    }
    if (HomeController.gasAlarm == 'ON') {
      setState(() {
        mySmartDevices[2][2] = true;
      });
    }
    if (HomeController.password == "ON") {
      setState(() {
        mySmartDevices[3][2] = true;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // controller.tempStream.close();
    // controller.gasStream.close();
  }

  final double horizontalPadding = 30;
  final double verticalPadding = 25;

  final controller = Get.put(HomeController());

  bool a = true;
  // list of smart devices
  static List mySmartDevices = [
    // [ smartDeviceName, iconPath , powerStatus ]
    ["Smart Light", "lib/images/light-bulb.png", false],
    ["Smart Fan", "lib/images/fan.png", false],
    ["Gas Detector", "lib/images/gas-detector.png", false],
    ["Camera Door", "lib/images/door-camera.png", false],
    ["Add", "lib/images/add.png", false],
  ];

  // power button switched
  powerSwitchChanged(bool value, int index) {
    setState(() {
      mySmartDevices[index][2] = value;
    });
    controller.onSwitched(index);
  }

  void showAlarm(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog());
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unrelated_type_equality_checks
    // if (HomeController.isToggled[2] == 1) {
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         icon: const Icon(
    //           Icons.check_circle_outline_sharp,
    //           size: 100,
    //           color: Colors.green,
    //         ),
    //         backgroundColor: Colors.white,
    //         title: Center(
    //           child: Column(
    //             children: [
    //               const Text(
    //                 'Success!',
    //                 style: TextStyle(color: Colors.black, fontSize: 30),
    //               ),
    //               const SizedBox(height: 10.0),
    //               const Text(
    //                 'Registered successfully',
    //                 style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 15,
    //                   fontWeight: FontWeight.w100,
    //                 ),
    //               ),
    //               const SizedBox(height: 15.0),
    //               GestureDetector(
    //                 onTap: () => {
    //                   Navigator.pop(context),
    //                 },
    //                 child: Container(
    //                   padding: const EdgeInsets.all(10),
    //                   margin: const EdgeInsets.symmetric(horizontal: 75),
    //                   decoration: BoxDecoration(
    //                     color: Colors.blue,
    //                     borderRadius: BorderRadius.circular(30),
    //                   ),
    //                   child: const Center(
    //                     child: Text(
    //                       'Login',
    //                       style: TextStyle(
    //                         color: Colors.white,
    //                         fontWeight: FontWeight.bold,
    //                         fontSize: 12,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   );
    // }
    return Scaffold(
      backgroundColor: const Color.fromRGBO(242, 242, 246, 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // app bar
            Padding(
              padding: EdgeInsets.only(
                top: horizontalPadding + 0,
                left: verticalPadding + 0,
                right: verticalPadding + 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection("users")
                          .where('email', isEqualTo: auth.currentUser?.email)
                          .get(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data?.docs[0].get('username') ??
                                  "username",
                              style: GoogleFonts.lexendDeca(
                                  fontSize: 20,
                                  color: const Color.fromRGBO(34, 73, 87, 1)),
                            ),
                            const Text(
                              "Welcome back home",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(34, 73, 87, 1)),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  // account icon
                  Icon(
                    Icons.account_circle,
                    size: 50,
                    color: Colors.grey[800],
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  // color: const Color.fromARGB(44, 164, 167, 189),
                  // color: Colors.deepPurple[200],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 25.0,
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Today 10 March, 2023',
                        style: GoogleFonts.lexendDeca(
                            color: const Color.fromRGBO(34, 73, 87, 1)),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 204, 204, 204),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.wb_sunny_outlined,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            // Text(
                            //   'Today 10 March, 2023',
                            //   style: GoogleFonts.lexendDeca(
                            //       color:
                            //           const Color.fromRGBO(34, 73, 87, 1)),
                            // ),
                            // const SizedBox(
                            //   height: 5,
                            // ),
                            Text(
                              'Sunny',
                              style: GoogleFonts.lexendDeca(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(34, 73, 87, 1),
                              ),
                              //   ),
                              // ],
                            ),
                            const Spacer(),

                            StreamBuilder<AdafruitGET>(
                              stream: controller.tempStream.stream,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData ||
                                    snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                  return Text(
                                    'Waiting',
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          const Color.fromRGBO(34, 73, 87, 1),
                                    ),
                                  );
                                } else {
                                  return Text(
                                    '${snapshot.data!.lastValue}\u2103',
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          const Color.fromRGBO(34, 73, 87, 1),
                                    ),
                                  );
                                }
                              },
                            ),

                            // Text(
                            //   '${HomeController.tempValue}\u2103',
                            //   style: GoogleFonts.lexendDeca(
                            //     fontSize: 18,
                            //     fontWeight: FontWeight.bold,
                            //     color: const Color.fromRGBO(34, 73, 87, 1),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 204, 204, 204),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              // Icons.electric_bolt,
                              Icons.gas_meter,
                              size: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 40,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   'Energy Expenses',
                                  //   style: GoogleFonts.lexendDeca(
                                  //       color: const Color.fromRGBO(
                                  //           34, 73, 87, 1)),
                                  // ),
                                  Text(
                                    'Gas\nconcentration',
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          const Color.fromRGBO(34, 73, 87, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            StreamBuilder<AdafruitGET>(
                              stream: controller.gasStream.stream,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData ||
                                    snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                  return Text(
                                    'Waiting',
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          const Color.fromRGBO(34, 73, 87, 1),
                                    ),
                                  );
                                } else {
                                  return Text(
                                    '${snapshot.data!.lastValue}%',
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          const Color.fromRGBO(34, 73, 87, 1),
                                    ),
                                  );
                                }
                              },
                            ),
                            // Text(
                            //   '${HomeController.gasValue}',
                            //   style: GoogleFonts.lexendDeca(
                            //     fontSize: 18,
                            //     fontWeight: FontWeight.bold,
                            //     color: const Color.fromRGBO(34, 73, 87, 1),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

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
            const SizedBox(height: 10),

            // grid
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  // children: [
                  child: Column(
                    children: [
                      GridView.builder(
                        itemCount: mySmartDevices.length - 1,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 0.8,
                        ),
                        itemBuilder: (context, index) {
                          return SmartDeviceBox(
                            smartDeviceName: mySmartDevices[index][0],
                            iconPath: mySmartDevices[index][1],
                            powerOn: mySmartDevices[index][2],
                            onChanged: (value) =>
                                powerSwitchChanged(value, index),
                            onTap: () => {
                              if (index == 0)
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Led()),
                                  ),
                                }
                              else if (index == 1)
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Fan()),
                                  ),
                                }
                              else if (index == 2)
                                {}
                              else if (index == 3)
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Door()),
                                  ),
                                }
                            },
                          );
                        },
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 28, right: 28, top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 15, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Add',
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromRGBO(
                                              34, 73, 87, 1)),
                                    ),
                                    Text(
                                      'New device',
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: 14,
                                          color: const Color.fromRGBO(
                                              34, 73, 87, 1)),
                                    ),
                                  ],
                                ),
                                Image.asset(
                                  'lib/images/add.png',
                                  height: 50,
                                  color: Colors.grey.shade900,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// abstract class GetTemp extends GetWidget<HomeController>{
//   const GetTemp({super.key});

// }