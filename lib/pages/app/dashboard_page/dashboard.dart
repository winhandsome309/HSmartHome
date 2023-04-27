import 'dart:async';
import 'dart:math';
import 'package:hsmarthome/bar_chart/resources/app_resources.dart';
import 'package:hsmarthome/bar_chart/extensions/color_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hsmarthome/pages/app/dashboard_page/dashboard_device.dart';

import '../../../modules/home_controller/home_controller.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

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
                            '\$320.09',
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
                              Text(
                                '-5.45%',
                                style: GoogleFonts.lexendDeca(
                                  fontSize: 16,
                                  color: const Color.fromRGBO(9, 210, 138, 1),
                                ),
                              ),
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
                    // ),
                    SizedBox(
                      height: 80,
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '220.88 kWh',
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
                                '-2.56%',
                                style: GoogleFonts.lexendDeca(
                                  fontSize: 16,
                                  color: const Color.fromRGBO(9, 210, 138, 1),
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
                                    percentage: 1,
                                    time: '1h1m'),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 50.0),
                                  child: Divider(
                                    thickness: 1,
                                    color: Color.fromARGB(255, 204, 204, 204),
                                  ),
                                ),
                                OptionsMostUsed(
                                    iconPath: 'lib/images/gas-detector.png',
                                    nameDevice: 'Gas Detector',
                                    percentage: 0.7,
                                    time: '1h1m'),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 50.0),
                                  child: Divider(
                                    thickness: 1,
                                    color: Color.fromARGB(255, 204, 204, 204),
                                  ),
                                ),
                                OptionsMostUsed(
                                    iconPath: 'lib/images/door-camera.png',
                                    nameDevice: 'Camera Door',
                                    percentage: 0.5,
                                    time: '1h1m'),
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
                                    nameDevice: 'Smart Fan',
                                    percentage: 0.7,
                                    time: '1h1m'),
                                // const Padding(
                                //   padding: EdgeInsets.symmetric(horizontal: 50.0),
                                //   child: Divider(
                                //     thickness: 1,
                                //     color: Color.fromARGB(255, 204, 204, 204),
                                //   ),
                                // ),
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

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, HomeController.energy[0],
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, HomeController.energy[1],
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, HomeController.energy[2],
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, HomeController.energy[3],
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, HomeController.energy[4],
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, HomeController.energy[5],
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, HomeController.energy[6],
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      // alignment: BarChartAlignment.center,
      maxY: 500,
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

class OptionsMostUsed extends StatefulWidget {
  String iconPath;
  String nameDevice;
  double percentage;
  String time;
  OptionsMostUsed({
    super.key,
    required this.iconPath,
    required this.nameDevice,
    required this.percentage,
    required this.time,
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
              MaterialPageRoute(builder: (context) => DashboardDevice()),
            ),
          },
        ),
        // ),
      ],
    );
  }
}
