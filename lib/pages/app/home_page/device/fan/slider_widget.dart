import 'dart:math';

import 'package:hsmarthome/pages/app/home_page/device/fan/fan_utlis.dart';
import 'package:hsmarthome/pages/app/home_page/device/fan/fan_custom_draw.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:hsmarthome/modules/home_controller/home_controller.dart';

class SliderWidget extends StatefulWidget {
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double progressVal = 0.5;
  bool a = true, b = true;

  final controller = Get.put(HomeController());

  @override
  initState() {
    setState(() {
      progressVal = HomeController.fanSpeed / 100;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) {
            return SweepGradient(
              startAngle: degToRad(0),
              endAngle: degToRad(180),
              // colors: [Colors.blue.shade200, Colors.grey.withAlpha(50)],
              colors: [
                const Color.fromRGBO(9, 210, 138, 1),
                Colors.grey.withAlpha(50)
              ],
              stops: [progressVal, progressVal],
              transform: GradientRotation(
                degToRad(180),
              ),
            ).createShader(rect);
          },
          child: Center(
            child: CustomArc(),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 90),
            child: Column(
              children: [
                Container(
                  width: kDiameter - 30,
                  height: kDiameter - 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 20,
                      style: BorderStyle.solid,
                    ),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 30,
                          spreadRadius: 10,
                          color: const Color.fromRGBO(9, 210, 138, 1).withAlpha(
                              normalize(progressVal * 20000, 100, 255).toInt()),
                          offset: const Offset(1, 3))
                    ],
                  ),
                  child: SleekCircularSlider(
                    min: kMinDegree,
                    max: kMaxDegree,
                    initialValue: progressVal * 100,
                    appearance: CircularSliderAppearance(
                      startAngle: 180,
                      angleRange: 180,
                      size: kDiameter - 30,
                      customWidths: CustomSliderWidths(
                        trackWidth: 10,
                        shadowWidth: 0,
                        progressBarWidth: 10,
                        handlerSize: 15,
                      ),
                      customColors: CustomSliderColors(
                        hideShadow: true,
                        progressBarColor: Colors.transparent,
                        trackColor: Colors.transparent,
                        dotColor: const Color.fromRGBO(9, 210, 138, 1),
                      ),
                    ),
                    onChange: (value) {
                      setState(() {
                        controller.fanControl(value);
                        progressVal = normalize(value, kMinDegree, kMaxDegree);
                      });
                    },
                    innerWidget: (percentage) {
                      percentage = progressVal * 100;
                      // controller.fanSpeedControl(percentage);
                      return Center(
                        child: Text(
                          'Speed: ${percentage.toInt()}%',
                          style: GoogleFonts.lexendDeca(
                            fontSize: 30,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (progressVal > 0.01) {
                              progressVal = max(0, progressVal - 0.25);
                            }
                            controller.fanControl(progressVal * 100);
                          });
                        },
                        child: Stack(
                          children: [
                            Icon(Icons.circle,
                                size: 60,
                                color: (a ? Colors.white : Colors.black)),
                            const Padding(
                              padding: EdgeInsets.only(left: 15, top: 15),
                              child: Icon(
                                Icons.remove,
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 130,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (progressVal < 1) {
                              progressVal = min(1, progressVal + 0.25);
                            }
                            controller.fanControl(progressVal * 100);
                          });
                        },
                        child: Stack(
                          children: [
                            Icon(Icons.circle,
                                size: 60,
                                color: (b ? Colors.white : Colors.black)),
                            const Padding(
                              padding: EdgeInsets.only(left: 15, top: 15),
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 30,
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
      ],
    );
  }
}
