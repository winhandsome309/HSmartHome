import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import 'package:hsmarthome/bar_chart/resources/app_resources.dart';
import 'package:hsmarthome/bar_chart/extensions/color_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hsmarthome/modules/home_controller/home_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hsmarthome/pages/app/dashboard_page/dashboard.dart';
import 'package:hsmarthome/pages/app/home_page/device/fan/slider_widget.dart';

import '../../../buttom_home.dart';
import '../../home_page.dart';

class Fan extends StatefulWidget {
  Fan({super.key});

  List<Color> get availableColors => const <Color>[
        AppColors.contentColorPurple,
        AppColors.contentColorYellow,
        AppColors.contentColorBlue,
        AppColors.contentColorOrange,
        AppColors.contentColorPink,
        AppColors.contentColorRed,
      ];

  final Color barBackgroundColor = Colors.white;
  final Color barColor = const Color.fromRGBO(242, 242, 246, 1);
  // final Color touchedBarColor = const Color.fromRGBO(9, 210, 138, 1);
  final Color touchedBarColor = Colors.deepPurple;

  @override
  State<StatefulWidget> createState() => FanState();
}

class FanState extends State<Fan> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  final controller = Get.put(HomeController());

  // bool auto = false;

  // bool timer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(242, 242, 246, 1),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(top: 10, bottom: 0, left: 5, right: 0),
              // margin: const EdgeInsets.symmetric(horizontal: 25),
              margin: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Row(
                      children: const [
                        Icon(
                          Icons.arrow_back_ios_rounded,
                          // color: Color.fromRGBO(9, 210, 138, 1),
                          color: Colors.black,
                          size: 25,
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        // Text(
                        //   'Home',
                        //   style: TextStyle(fontSize: 18),
                        // ),
                      ],
                    ),
                    onTap: () => {
                      Navigator.pop(context),
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35),
                    child: Text(
                      'Fan',
                      style: GoogleFonts.lexendDeca(
                        color: const Color.fromRGBO(34, 73, 87, 1),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        // color: Colors.black,
                      ),
                    ),
                  ),
                  Stack(
                    children: const [
                      // Icon(
                      //   Icons.more_vert,
                      //   color: Colors.white,
                      // ),
                      Icon(
                        Icons.circle,
                        size: 40,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8, top: 7),
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: SliderWidget(),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 15, right: 10),
              // margin: const EdgeInsets.symmetric(horizontal: 25),
              margin: const EdgeInsets.only(
                  left: 25, right: 25, top: 10, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 150,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.cloud_outlined,
                            size: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 20),
                            child: Column(
                              children: [
                                Text(
                                  '18\u2103',
                                  style: GoogleFonts.lexendDeca(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromRGBO(34, 73, 87, 1),
                                  ),
                                ),
                                Text(
                                  'Outside',
                                  style: GoogleFonts.lexendDeca(
                                    fontSize: 16,
                                    color: const Color.fromRGBO(34, 73, 87, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Expanded(
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                      ),
                      child: VerticalDivider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                    // ),
                    SizedBox(
                      height: 80,
                      width: 150,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Icon(
                              Icons.thermostat,
                              size: 40,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 20),
                            child: Column(
                              children: [
                                Text(
                                  '26\u2103',
                                  style: GoogleFonts.lexendDeca(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromRGBO(34, 73, 87, 1),
                                  ),
                                ),
                                Text(
                                  'Inside',
                                  style: GoogleFonts.lexendDeca(
                                    fontSize: 16,
                                    color: const Color.fromRGBO(34, 73, 87, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 20, top: 30, left: 30, right: 30),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (HomePage.timerFan == false) {
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((value) {
                            setState(() {
                              HomePage.timeOfDayFan = value!;
                              HomePage.timerFan = true;
                              controller.setTimerFan(
                                  HomePage.timeOfDayFan.hour.toString(),
                                  HomePage.timeOfDayFan.minute.toString());
                            });
                          });
                          // HomePage.timerFan = true;
                          // controller.setTimerFan(
                          //     HomePage.timeOfDayFan.hour.toString(),
                          //     HomePage.timeOfDayFan.minute.toString());
                        } else {
                          HomePage.timerFan = false;
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: HomePage.timerFan
                            ? Colors.grey.shade500
                            : Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: SizedBox(
                        height: 70,
                        width: 120,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.timer_outlined,
                                size: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Timer',
                                  style: GoogleFonts.lexendDeca(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromRGBO(34, 73, 87, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: GestureDetector(
                      onTap: () {
                        controller.onSwitched(1);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                        );
                      },
                      child: Stack(
                        children: const [
                          Icon(
                            Icons.circle,
                            size: 80,
                            color: Colors.red,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 23, top: 22),
                            child: Icon(
                              Icons.power_settings_new,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (HomePage.autoFan == false) {
                          controller.tempFanControl("ON");
                          HomePage.autoFan = true;
                        } else {
                          controller.tempFanControl("OFF");
                          HomePage.autoFan = false;
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: HomePage.autoFan
                            ? Colors.grey.shade500
                            : Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: SizedBox(
                        height: 70,
                        width: 120,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  'Auto',
                                  style: GoogleFonts.lexendDeca(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromRGBO(34, 73, 87, 1),
                                  ),
                                ),
                              ),
                              const Icon(Icons.auto_awesome),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              (HomePage.timerFan == true)
                  ? ("Timer: ${HomePage.timeOfDayFan.hour}:${HomePage.timeOfDayFan.minute}")
                  : "",
              style: GoogleFonts.lexendDeca(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color.fromRGBO(34, 73, 87, 1),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
