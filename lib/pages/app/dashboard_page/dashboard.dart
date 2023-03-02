import 'dart:async';
import 'dart:math';

import 'package:hsmarthome/bar_chart/resources/app_resources.dart';
import 'package:hsmarthome/bar_chart/extensions/color_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 242, 246, 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "MOST USED",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 17, left: 15, right: 10),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      OptionsMostUsed(
                          iconPath: 'lib/images/light-bulb.png',
                          nameDevice: 'Light',
                          percentage: 0.9),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 204, 204, 204),
                        ),
                      ),
                      OptionsMostUsed(
                          iconPath: 'lib/images/gas-detector.png',
                          nameDevice: 'Gas Detector',
                          percentage: 0.7),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 204, 204, 204),
                        ),
                      ),
                      OptionsMostUsed(
                          iconPath: 'lib/images/door-camera.png',
                          nameDevice: 'Camera Door',
                          percentage: 0.5),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 204, 204, 204),
                        ),
                      ),
                      OptionsMostUsed(
                          iconPath: 'lib/images/fan.png',
                          nameDevice: 'Smart Fan',
                          percentage: 0.2),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 204, 204, 204),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 70, right: 50),
            //   child: LinearPercentIndicator(
            //     barRadius: const Radius.circular(20.0),
            //     // animation: true,
            //     // animationDuration: 1000,
            //     lineHeight: 10,
            //     percent: 0.9,
            //     progressColor: Colors.deepPurple,
            //     backgroundColor: Colors.deepPurple.shade200,
            //   ),

            // child: ClipRRect(
            //   borderRadius: BorderRadius.circular(8),
            //   child: Container(
            //     height: 10,
            //     child: LinearProgressIndicator(
            //       value: 0.35, // percent filled
            //       valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            //       backgroundColor: Color(0xFFFFDAB8),
            //     ),
            //   ),
            // ),
            // ),
          ],
        ),
      ),
    );
  }
}

class OptionsMostUsed extends StatefulWidget {
  String iconPath;
  String nameDevice;
  double percentage;
  OptionsMostUsed({
    super.key,
    required this.iconPath,
    required this.nameDevice,
    required this.percentage,
  });

  @override
  State<OptionsMostUsed> createState() => _OptionsMostUsedState();
}

class _OptionsMostUsedState extends State<OptionsMostUsed> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          widget.iconPath,
          height: 40,
          color: Colors.black,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 10,
                  bottom: 5,
                ),
                child: Text(
                  widget.nameDevice,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Stack(
                children: [
                  LinearPercentIndicator(
                    barRadius: const Radius.circular(20.0),
                    animation: true,
                    animationDuration: 2000,
                    lineHeight: 5,
                    percent: widget.percentage,
                    progressColor: Color.fromRGBO(9, 210, 138, 1),
                    backgroundColor: Colors.white,
                    // trailing: Text('Thang'),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        const Icon(Icons.arrow_forward_ios_outlined),
        // const Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 30.0),
        //   child: Divider(
        //     thickness: 1,
        //     color: Color.fromARGB(255, 204, 204, 204),
        //   ),
        // ),
      ],
    );
  }
}
