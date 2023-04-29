import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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
  static bool autoLed = false;
  static bool autoFan = false;
  static bool timerLed = false;
  static bool timerFan = false;
  static TimeOfDay timeOfDayLed = const TimeOfDay(hour: 8, minute: 30);
  static TimeOfDay timeOfDayFan = const TimeOfDay(hour: 8, minute: 30);
  static DateTime curr = DateTime.now();
  static List month = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  static void reset(int index) {
    if (index == 0) {
      autoLed = false;
      timerLed = false;
    } else if (index == 1) {
      autoFan = false;
      timerFan = false;
    }
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // static bool autoLed = false;
  // static bool autoFan = false;
  // static bool timerLed = false;
  // static bool timerFan = false;
  final passwordAccount = TextEditingController();
  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Oh no!',
        message: message,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.failure,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void enterAccountPassword() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Column(
              children: [
                Text(
                  'Enter your password to coninue',
                  style:
                      GoogleFonts.lexendDeca(color: Colors.red, fontSize: 15),
                ),
                const SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: TextFormField(
                    style: GoogleFonts.lexendDeca(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(32, 223, 127, 1)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      fillColor: const Color.fromRGBO(34, 73, 87, 1),
                      filled: true,
                      hintText: 'Enter your password',
                      hintStyle: GoogleFonts.lexendDeca(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      // prefixIcon: const Icon(Icons.person),
                    ),
                    controller: passwordAccount,
                    obscureText: false,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    // if (_key.currentState!.validate()) {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: HomeController.emailAccount,
                        password: passwordAccount.text,
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      // ignore: use_build_context_synchronously
                      setState(() {
                        HomeController.mySmartDevices[3][2] = true;
                        HomeController.countOpenDoor = 0;
                        HomeController.wrong5times = false;
                        // Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const Door()),
                        // );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Door()),
                        );
                      });
                    } on FirebaseAuthException catch (e) {
                      // Navigator.pop(context);
                      showErrorMessage(e.code);
                    }
                    // if (_key.currentState!.validate()) {
                    // await signUserIn();
                    // Navigator.pop(context);
                    // resetPassword();
                    // }
                  },
                  // child: GestureDetector(
                  //   onTap: () async {
                  //     if (_key.currentState!.validate()) {
                  //       await signUserIn();
                  //     }
                  //   },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 75),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  //   ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  initState() {
    // Led
    if (HomeController.ledValue != "#000000".obs) {
      setState(() {
        HomeController.mySmartDevices[0][2] = true;
      });
    } else {
      setState(() {
        HomeController.mySmartDevices[0][2] = false;
      });
    }
    // Fan
    if (HomeController.fanSpeed != 0) {
      setState(() {
        HomeController.mySmartDevices[1][2] = true;
      });
    } else {
      setState(() {
        HomeController.mySmartDevices[1][2] = false;
      });
    }
    // GasAlarm
    if (HomeController.gasAlarm == 'ON') {
      setState(() {
        HomeController.mySmartDevices[2][2] = true;
      });
    } else {
      setState(() {
        HomeController.mySmartDevices[2][2] = false;
      });
    }
    // Door
    if (HomeController.password.length == 9) {
      setState(() {
        HomeController.mySmartDevices[3][2] = true;
      });
    } else {
      setState(() {
        HomeController.mySmartDevices[3][2] = false;
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
  // static List mySmartDevices = [
  //   // [ smartDeviceName, iconPath , powerStatus ]
  //   ["Smart Light", "lib/images/light-bulb.png", false],
  //   ["Smart Fan", "lib/images/fan.png", false],
  //   ["Gas Detector", "lib/images/gas-detector.png", false],
  //   ["Camera Door", "lib/images/door-camera.png", false],
  //   ["Add", "lib/images/add.png", false],
  // ];

  // power button switched
  powerSwitchChanged(bool value, int index) {
    if (index == 3 &&
        HomeController.mySmartDevices[index][2] == false &&
        HomeController.wrong5times == true) {
      enterAccountPassword();
    } else {
      setState(() {
        HomeController.mySmartDevices[index][2] = value;
      });
      controller.onSwitched(index);
    }
  }

  void showAlarm(BuildContext context) {
    showDialog(context: context, builder: (context) => const AlertDialog());
  }

  static double? gasPercent = 0.0;

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
                    // child: StreamBuilder<QuerySnapshot>(
                    //   stream: FirebaseFirestore.instance
                    //       .collection('users')
                    //       // .where('email', isEqualTo: auth.currentUser?.email)
                    //       .snapshots(),
                    //   builder: (BuildContext context,
                    //       AsyncSnapshot<QuerySnapshot> snapshot) {
                    //     if (snapshot.hasError) {
                    //       return const Text('Something went wrong');
                    //     }

                    //     if (snapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       return const Text("Loading");
                    //     }
                    //     // return Text(
                    //     //   snapshot.data?.docs[0].get('username') ?? "username",
                    //     //   style: GoogleFonts.lexendDeca(
                    //     //       fontSize: 20,
                    //     //       color: const Color.fromRGBO(34, 73, 87, 1)),
                    //     // );
                    //     return ListView(
                    //       children: snapshot.data!.docs
                    //           .map((DocumentSnapshot document) {
                    //         Map<String, dynamic> data =
                    //             document.data()! as Map<String, dynamic>;
                    //         return ListTile(
                    //           title: Text(data['full_name']),
                    //           subtitle: Text(data['company']),
                    //         );
                    //       }).toList(),
                    //     );
                    //   },
                    // ),
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
                        'Today ${HomePage.curr.day} ${HomePage.month[HomePage.curr.month - 1]}, ${HomePage.curr.year}',
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
                                  if (snapshot.data != null) {
                                    gasPercent = double.parse(
                                            snapshot.data!.lastValue!) /
                                        10000;
                                  }
                                  return Text(
                                    '${gasPercent.toString()} ppm',
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
                        itemCount: HomeController.mySmartDevices.length - 1,
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
                            smartDeviceName:
                                HomeController.mySmartDevices[index][0],
                            iconPath: HomeController.mySmartDevices[index][1],
                            powerOn: HomeController.mySmartDevices[index][2],
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
