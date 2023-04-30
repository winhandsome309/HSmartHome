import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:hsmarthome/bar_chart/resources/app_resources.dart';
import 'package:hsmarthome/bar_chart/extensions/color_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hsmarthome/pages/app/dashboard_page/dashboard_device.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../modules/home_controller/home_controller.dart';
import 'package:firebase_core/firebase_core.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

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
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  // DatabaseReference ref = FirebaseDatabase.instance.ref().child("thang");
  // DatabaseReference ref = FirebaseDatabase.instance.ref();

  Widget listItem() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 5,
      color: Colors.amberAccent,
      child: const Text('Temp'),
    );
  }

  static DateTime curr = DateTime.now();

  List day = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  List device = ['Fan', 'Led'];

  getSumLastWeek() async {
    // HomeController.sum_energy_last_week = 0;
    double sum_energy_last_week = 0;
    for (int i = 0; i < 7; i++) {
      double sum_led = 0, sum_fan = 0;
      for (var j in device) {
        double p = 0;
        int curr_day = 17 + i;
        String k = curr_day.toString();
        await FirebaseFirestore.instance
            .collection(j)
            .where('date', isEqualTo: day[i])
            .where('day', isEqualTo: k)
            .get()
            .then(
          (querySnapshot) {
            for (var result in querySnapshot.docs) {
              if (j == 'Led')
                sum_led += result.get('time');
              else
                sum_fan += result.get('time');
              p += result.get('time');
            }
          },
        );
      }
      // HomeController.sum_energy_last_week +=
      //     sum_led * HomeController.energy_led +
      //         sum_fan * HomeController.energy_fan;
      sum_energy_last_week += sum_led * HomeController.energy_led +
          sum_fan * HomeController.energy_fan;
    }
    HomeController.sum_energy_last_week = sum_energy_last_week;
  }

  getSum() async {
    // HomeController.sum_energy = 0;
    // HomeController.sum_energy_led = 0;
    // HomeController.sum_energy_fan = 0;
    double sum_energy = 0;
    double sum_energy_led = 0;
    double sum_energy_fan = 0;
    for (int i = curr.weekday - 1; i >= 0; i--) {
      double sum_led = 0, sum_fan = 0;
      for (var j in device) {
        double p = 0;
        int curr_day = curr.day - (curr.weekday - 1 - i);
        String k = curr_day.toString();
        await FirebaseFirestore.instance
            .collection(j)
            .where('date', isEqualTo: day[i])
            .where('day', isEqualTo: k)
            .get()
            .then(
          (querySnapshot) {
            for (var result in querySnapshot.docs) {
              if (j == 'Led')
                sum_led += result.get('time');
              else
                sum_fan += result.get('time');
              p += result.get('time');
            }
            if (i == curr.weekday - 1) {
              if (j == 'Led') {
                HomeController.time_led[curr.weekday - 1] = p;
                double a = p / 3600;
                double b = (p.toInt() % 3600) / 60;
                double c = p.toInt() % 60;
                int x = a.toInt();
                int y = b.toInt();
                int z = c.toInt();
                String s = "";
                if (x > 0) s += "${x}h";
                if (y > 0) s += "${y}m";
                s += "${z}s";
                HomeController.time_led_curr = s;
              } else {
                HomeController.time_fan[curr.weekday - 1] = p;
                double a = p / 3600;
                double b = (p.toInt() % 3600) / 60;
                double c = p.toInt() % 60;
                int x = a.toInt();
                int y = b.toInt();
                int z = c.toInt();
                String s = "";
                if (x > 0) s += "${x}h";
                if (y > 0) s += "${y}m";
                s += "${z}s";
                HomeController.time_fan_curr = s;
              }
            }
          },
        );
      }
      HomeController.energy_consume[i] = sum_led * HomeController.energy_led +
          sum_fan * HomeController.energy_fan;
      // HomeController.sum_energy += HomeController.energy_consume[i];
      // HomeController.sum_energy_led += sum_led * HomeController.energy_led;
      // HomeController.sum_energy_fan += sum_fan * HomeController.energy_fan;
      sum_energy += HomeController.energy_consume[i];
      sum_energy_led += sum_led * HomeController.energy_led;
      sum_energy_fan += sum_fan * HomeController.energy_fan;
    }
    HomeController.max_val = max(HomeController.time_led[curr.weekday - 1],
        HomeController.time_fan[curr.weekday - 1]);
    if (HomeController.max_val == 0) {
      HomeController.max_val = 10000;
    }
    HomeController.sum_energy = sum_energy;
    HomeController.sum_energy_led = sum_energy_led;
    HomeController.sum_energy_fan = sum_energy_fan;
  }

  @override
  void initState() {
    getSum();
    getSumLastWeek();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(242, 242, 246, 1),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 15, right: 15),
              // margin: const EdgeInsets.symmetric(horizontal: 25),
              margin: const EdgeInsets.only(
                  top: 20, left: 25, right: 25, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.arrow_back_ios_rounded,
                    // color: Color.fromRGBO(9, 210, 138, 1),
                    color: Colors.black,
                  ),
                  Text(
                    'This week',
                    style: GoogleFonts.roboto(
                      // color: const Color.fromRGBO(9, 210, 138, 1),
                      color: Colors.black,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey[300],
                  ),
                ],
              ),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$ ${(HomeController.sum_energy * 2000 / (23000 * 1000)).toStringAsFixed(2)}',
                            style: GoogleFonts.lexendDeca(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(34, 73, 87, 1),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Cost',
                                style: GoogleFonts.lexendDeca(
                                  fontSize: 16,
                                  color: const Color.fromRGBO(34, 73, 87, 1),
                                ),
                              ),
                              // Text(
                              //   ((HomeController.sum_energy /
                              //               HomeController
                              //                   .sum_energy_last_week) >
                              //           1.0)
                              //       ? "+ ${(HomeController.sum_energy / HomeController.sum_energy_last_week).toStringAsFixed(2)} %"
                              //       : "- ${(HomeController.sum_energy / HomeController.sum_energy_last_week).toStringAsFixed(2)} %",
                              //   // '${(HomeController.sum_energy / HomeController.sum_energy_last_week).toStringAsFixed(2)} %',
                              //   style: GoogleFonts.lexendDeca(
                              //     fontSize: 16,
                              //     color: ((HomeController.sum_energy /
                              //                 HomeController
                              //                     .sum_energy_last_week) >
                              //             1.0)
                              //         ? Colors.red
                              //         : const Color.fromRGBO(9, 210, 138, 1),
                              //   ),
                              // ),
                            ],
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

                    SizedBox(
                      height: 80,
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${HomeController.sum_energy / 1000} kWh',
                            style: GoogleFonts.lexendDeca(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(34, 73, 87, 1),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Usage',
                                style: GoogleFonts.lexendDeca(
                                  fontSize: 16,
                                  color: const Color.fromRGBO(34, 73, 87, 1),
                                ),
                              ),
                              Text(
                                ((HomeController.sum_energy /
                                            HomeController
                                                .sum_energy_last_week) >
                                        1.0)
                                    ? "+ ${(HomeController.sum_energy / HomeController.sum_energy_last_week).toStringAsFixed(2)} %"
                                    : "- ${(HomeController.sum_energy / HomeController.sum_energy_last_week).toStringAsFixed(2)} %",
                                // '${(HomeController.sum_energy / HomeController.sum_energy_last_week).toStringAsFixed(2)} %',
                                style: GoogleFonts.lexendDeca(
                                  fontSize: 16,
                                  color: ((HomeController.sum_energy /
                                              HomeController
                                                  .sum_energy_last_week) >
                                          1.0)
                                      ? Colors.red
                                      : const Color.fromRGBO(9, 210, 138, 1),
                                ),
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
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 0),
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
                                        child: BarChart(
                                          mainBarData(),
                                          swapAnimationDuration: animDuration,
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
                          "MOST USED",
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
                            top: 10, bottom: 15, left: 15, right: 15),
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
                                    percentage: HomeController
                                            .time_led[curr.weekday - 1] /
                                        HomeController.max_val,
                                    time: HomeController.time_led_curr,
                                    info: "led-info",
                                    info_hour: "Led"),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 50.0),
                                  child: Divider(
                                    thickness: 1,
                                    color: Color.fromARGB(255, 204, 204, 204),
                                  ),
                                ),
                                OptionsMostUsed(
                                  iconPath: 'lib/images/fan.png',
                                  nameDevice: 'Fan',
                                  percentage: HomeController
                                          .time_fan[curr.weekday - 1] /
                                      HomeController.max_val,
                                  time: HomeController.time_fan_curr,
                                  info: "fan-info",
                                  info_hour: "Fan",
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 50.0),
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
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            // ElevatedButton(
            //   onPressed: getSum,
            //   child: const Text('Press'),
            // ),
          ],
        ),
      ),
    );
  }

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

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, HomeController.energy_consume[0],
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, HomeController.energy_consume[1],
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, HomeController.energy_consume[2],
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, HomeController.energy_consume[3],
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, HomeController.energy_consume[4],
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, HomeController.energy_consume[5],
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, HomeController.energy_consume[6],
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      // alignment: BarChartAlignment.center,
      maxY: 300000,
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
      barGroups: showingGroups(),
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

// ignore: must_be_immutable
class OptionsMostUsed extends StatefulWidget {
  String iconPath;
  String nameDevice;
  double percentage;
  String time;
  String info;
  String info_hour;
  OptionsMostUsed({
    super.key,
    required this.iconPath,
    required this.nameDevice,
    required this.percentage,
    required this.time,
    required this.info,
    required this.info_hour,
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
        Stack(
          children: [
            // Expanded(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                LinearPercentIndicator(
                  width: 190,
                  barRadius: const Radius.circular(20.0),
                  animation: true,
                  animationDuration: 1000,
                  lineHeight: 7,
                  percent: widget.percentage,
                  progressColor: const Color.fromRGBO(9, 210, 138, 1),
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 10),
              ],
            ),
            // ),
            Padding(
              padding: EdgeInsets.only(
                top: 31,
                left: 170 * widget.percentage + 20,
              ),
              child: Text(
                widget.time,
                style: const TextStyle(
                  fontSize: 8.5,
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          child: const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 17,
          ),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardDevice(
                  nameDevice: widget.nameDevice,
                  info: widget.info,
                  info_hour: widget.info_hour,
                ),
              ),
            ),
          },
        ),
        // ),
      ],
    );
  }
}
