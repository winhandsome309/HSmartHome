import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hsmarthome/bar_chart/resources/app_resources.dart';
import 'package:hsmarthome/bar_chart/extensions/color_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hsmarthome/pages/app/dashboard_page/dashboard.dart';

import '../../../modules/home_controller/home_controller.dart';

class DashboardDevice extends StatefulWidget {
  String nameDevice = "";
  String info = "";
  String info_hour = "";
  DashboardDevice(
      {super.key,
      required this.nameDevice,
      required this.info,
      required this.info_hour});

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
  State<StatefulWidget> createState() => DashboardDeviceState();
}

class DashboardDeviceState extends State<DashboardDevice> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(242, 242, 246, 1),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 0, right: 15),
              // margin: const EdgeInsets.symmetric(horizontal: 25),
              margin: const EdgeInsets.only(
                  top: 20, left: 10, right: 25, bottom: 20),
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
                          size: 20,
                        ),
                        Text('Dashboard'),
                      ],
                    ),
                    onTap: () => {
                      Navigator.pop(context),
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 130),
                    child: Text(
                      widget.nameDevice,
                      style: GoogleFonts.lexendDeca(
                        color: const Color.fromRGBO(34, 73, 87, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        // color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "ENERGY USED",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 17, left: 0, right: 25),
                        // margin: const EdgeInsets.symmetric(horizontal: 25),
                        margin: const EdgeInsets.only(
                            left: 25, right: 25, top: 10, bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: AspectRatio(
                          aspectRatio: 1.2,
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0),
                                        child: FutureBuilder(
                                          future: FirebaseFirestore.instance
                                              .collection(widget.info_hour)
                                              .get(),
                                          builder: (context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            num sum = 0;
                                            // List energy = [
                                            //   0.0,
                                            //   0.0,
                                            //   0.0,
                                            //   0.0,
                                            //   0.0,
                                            //   0.0,
                                            //   0.0
                                            // ];
                                            List day = [
                                              'Mon',
                                              'Tue',
                                              'Wed',
                                              'Thu',
                                              'Fri',
                                              'Sat',
                                              'Sun'
                                            ];
                                            List consume_energy = [
                                              0.0,
                                              0.0,
                                              0.0,
                                              0.0,
                                              0.0,
                                              0.0,
                                              0.0
                                            ];
                                            DateTime curr = DateTime.now();
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              for (var i
                                                  in snapshot.data!.docs) {
                                                for (int j = curr.weekday - 1;
                                                    j >= 0;
                                                    j--) {
                                                  int p = curr.day - j;
                                                  // print('Thang');
                                                  // print(p.toString());
                                                  // print(i.get('day'));
                                                  if (p.toString() ==
                                                      i.get('day')) {
                                                    int a = i.get('time');
                                                    if (widget.info_hour ==
                                                        'Led') {
                                                      a *= HomeController
                                                          .energy_led;
                                                    } else {
                                                      a *= HomeController
                                                          .energy_fan;
                                                    }
                                                    consume_energy[j] += a;
                                                    break;
                                                  }
                                                }
                                              }
                                            }
                                            return BarChart(
                                              mainBarData(consume_energy),
                                              swapAnimationDuration:
                                                  animDuration,
                                            );
                                          },
                                        ),
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
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "INFO",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 15, right: 15),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'lib/images/light-bulb.png',
                                        height: 40,
                                        color: Colors.black,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              top: 10,
                                              bottom: 7,
                                            ),
                                            child: Text(
                                              widget.nameDevice,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 40.0),
                                  child: Divider(
                                    thickness: 1,
                                    color: Color.fromARGB(255, 204, 204, 204),
                                  ),
                                ),
                                FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection(widget.info_hour)
                                      .get(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    num sum = 0;
                                    String s = "Waiting";
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      for (var i in snapshot.data!.docs) {
                                        sum += i.get('time');
                                      }
                                      s = "";
                                      int p = sum as int;
                                      double a = p / 3600;
                                      double b = (p.toInt() % 3600) / 60;
                                      double c = p.toInt() % 60;
                                      int x = a.toInt();
                                      int y = b.toInt();
                                      int z = c.toInt();
                                      // String s = "";
                                      if (x > 0) s += "${x}h";
                                      if (y > 0) s += "${y}m";
                                      s += "${z}s";
                                    }
                                    return InfoDevice(
                                      title: 'Total hours of use',
                                      content: s,
                                    );
                                  },
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 40.0),
                                  child: Divider(
                                    thickness: 1,
                                    color: Color.fromARGB(255, 204, 204, 204),
                                  ),
                                ),
                                FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection(widget.info)
                                      .get(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    return InfoDevice(
                                      title: 'Wattage',
                                      content: snapshot.data?.docs[0]
                                              .get('wattage') ??
                                          "Waiting",
                                    );
                                  },
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 40.0),
                                  child: Divider(
                                    thickness: 1,
                                    color: Color.fromARGB(255, 204, 204, 204),
                                  ),
                                ),
                                FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection(widget.info)
                                      .get(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    return InfoDevice(
                                      title: 'Producer',
                                      content: snapshot.data?.docs[0]
                                              .get('producer') ??
                                          "Waiting",
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
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

// }
  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 18,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          color: isTouched
              ? widget.touchedBarColor
              : const Color.fromRGBO(9, 210, 138, 1),
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(List arr) => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, arr[0], isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, arr[1], isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, arr[2], isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, arr[3], isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, arr[4], isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, arr[5], isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, arr[6], isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData(List arr) {
    return BarChartData(
      // alignment: BarChartAlignment.center,
      maxY: 200000,
      minY: 0,
      gridData: FlGridData(
        // show: true,
        checkToShowHorizontalLine: (value) => value % 10 == 0,
        getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.black,
          strokeWidth: 0.2,
        ),
        drawVerticalLine: false,
        // getDrawingVerticalLine: (value) => FlLine(
        //   color: Colors.black,
        //   strokeWidth: 0.2,
        //   dashArray: [8, 4],
        // ),
      ),
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'Monday';
                break;
              case 1:
                weekDay = 'Tuesday';
                break;
              case 2:
                weekDay = 'Wednesday';
                break;
              case 3:
                weekDay = 'Thursday';
                break;
              case 4:
                weekDay = 'Friday';
                break;
              case 5:
                weekDay = 'Saturday';
                break;
              case 6:
                weekDay = 'Sunday';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        // leftTitles: AxisTitles(
        //   sideTitles: SideTitles(
        //     showTitles: true,
        //   ),
        // ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(arr),
      // gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    TextStyle style = GoogleFonts.lexendDeca(
      color: Colors.grey,
      // fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('Mon', style: style);
        break;
      case 1:
        text = Text('Tue', style: style);
        break;
      case 2:
        text = Text('Wed', style: style);
        break;
      case 3:
        text = Text('Thu', style: style);
        break;
      case 4:
        text = Text('Fri', style: style);
        break;
      case 5:
        text = Text('Sat', style: style);
        break;
      case 6:
        text = Text('Sun', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
  }
}

class InfoDevice extends StatefulWidget {
  String title;
  String content;

  InfoDevice({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  State<InfoDevice> createState() => _InfoDeviceState();
}

class _InfoDeviceState extends State<InfoDevice> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            widget.content,
            style: const TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(122, 115, 115, 1),
            ),
          ),
        )
      ],
    );
  }
}
