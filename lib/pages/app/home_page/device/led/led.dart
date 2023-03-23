import 'package:get/get.dart';
import 'package:hsmarthome/bar_chart/resources/app_resources.dart';
import 'package:flutter/material.dart';
// import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hsmarthome/modules/home_controller/home_controller.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class Led extends StatefulWidget {
  Led({super.key});

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
  State<StatefulWidget> createState() => LedState();
}

class LedState extends State<Led> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  double lighting = 50;

  static RxString oldColor = '#301b1b'.obs;

  final controller = Get.put(HomeController());

  @override
  initState() {
    setState(() {
      oldColor = HomeController.ledValue;
    });
    super.initState();
  }

  Color pickerColor = Colors.blue;
  void onColorChanged(Color color) {
    setState(() {
      pickerColor = color;
      oldColor = '#${color.value.toRadixString(16).substring(2)}'.obs;
    });
  }

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
                      ],
                    ),
                    onTap: () => {
                      Navigator.pop(context),
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35),
                    child: Text(
                      'Light',
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
            //     ],
            //   ),
            // ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.sunny,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 330,
                      child: Slider(
                        min: 0,
                        max: 100,
                        value: lighting,
                        onChanged: (newRating) {
                          setState(() {
                            lighting = newRating;
                          });
                        },
                        thumbColor: Colors.white,
                        label: "$lighting",
                        activeColor: Colors.black.withOpacity(0.6),
                        divisions: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),
            // ColorPicker(
            //   paletteType: PaletteType.hueWheel,
            //   pickerColor: HexColor(oldColor.value),
            //   // ignore: deprecated_member_use
            //   showLabel: false,
            //   colorHistory: [HexColor(oldColor.value)],
            //   onColorChanged: (color) => setState(
            //     () => {
            //       oldColor =
            //           '#${color.value.toRadixString(16).substring(2)}'.obs,
            //     },
            //   ),
            // ),
            // MaterialColorPicker(
            //   allowShades: false,
            // onColorChange: (color) {
            // Handle color changes
            // oldColor = '#${color.value.toRadixString(16).substring(2)}'.obs;
            // print(oldColor);
            //   oldColor =
            //       '#${color!.value.toRadixString(16).substring(2)}'.obs;
            // },
            // onMainColorChange: (color) => setState(
            //   () => oldColor =
            //       '#${color!.value.toRadixString(16).substring(2)}'.obs,
            // ),

            // onColorChange: (color) => setState(
            //   () => {
            //     oldColor =
            //         '#${color.value.toRadixString(16).substring(2)}'.obs,
            //   },
            // ),

            //   selectedColor: Colors.red,
            //   circleSize: 55,
            //   spacing: 25,
            //   colors: const [
            //     // Color(0xffb74093);
            //     Colors.deepOrange,
            //     Colors.yellow,
            //     Colors.lightGreen,
            //     Colors.grey,
            //     Colors.red,
            //     Colors.pink,
            //     Colors.purple,
            //     Colors.blue,
            //     Colors.amber,
            //   ],
            // ),
            BlockPicker(
              pickerColor: pickerColor,
              onColorChanged: onColorChanged,
              availableColors: const [
                Color(0xffffffff),
                Color(0xffff0000),
                Color(0xffffa500),
                Color(0xffffff00),
                Color(0xff00ff00),
                Color(0xff0000ff),
                Color(0xff4b0082),
                Color(0xff800080),
                Color(0xff000000),
              ],
            ),
            const SizedBox(
              height: 0,
            ),
            SizedBox(
              height: 50,
              width: 100,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(34.0))),
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromRGBO(32, 223, 127, 1)),
                ),
                child: const Text('Select',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                onPressed: () => {
                  controller.ledControl(oldColor),
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 70, top: 30, left: 30, right: 30),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
