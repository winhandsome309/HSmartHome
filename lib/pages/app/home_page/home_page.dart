import 'package:flutter/material.dart';
import 'package:hsmarthome/util/smart_device_box.dart';
import 'package:get/get.dart';
import 'package:hsmarthome/modules/home_controller/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

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
      // backgroundColor: Colors.white,
      backgroundColor: Color.fromRGBO(242, 242, 246, 1),
      body: SafeArea(
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
                              "Welcome Home,",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey.shade800),
                            ),
                            Text(
                              snapshot.data?.docs[0].get('username') ??
                                  "username",
                              style: GoogleFonts.bebasNeue(fontSize: 30),
                            ),
                          ],
                        );
                      },
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

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  // color: const Color.fromARGB(44, 164, 167, 189),
                  color: Colors.white,
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
                  physics: const BouncingScrollPhysics(),
                  // children: [
                  child: GridView.builder(
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
                        onChanged: (value) => powerSwitchChanged(value, index),
                      );
                    },
                  ),
                  // ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
