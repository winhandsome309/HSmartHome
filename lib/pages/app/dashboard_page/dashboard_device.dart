import 'dart:async';
import 'dart:math';
import 'package:hsmarthome/bar_chart/resources/app_resources.dart';
import 'package:hsmarthome/bar_chart/extensions/color_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hsmarthome/pages/app/dashboard_page/dashboard.dart';

class DashboardDevice extends StatefulWidget {
  DashboardDevice({super.key});

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
                    padding: const EdgeInsets.only(right: 120),
                    child: Text(
                      'Lamp',
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
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 10,
                                              top: 10,
                                              bottom: 7,
                                            ),
                                            child: Text(
                                              'Light',
                                              style: TextStyle(
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
                                InfoDevice(
                                  title: 'Total hours of use',
                                  content: '10h15m',
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 40.0),
                                  child: Divider(
                                    thickness: 1,
                                    color: Color.fromARGB(255, 204, 204, 204),
                                  ),
                                ),
                                InfoDevice(
                                  title: 'Wattage',
                                  content: '194W',
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 40.0),
                                  child: Divider(
                                    thickness: 1,
                                    color: Color.fromARGB(255, 204, 204, 204),
                                  ),
                                ),
                                InfoDevice(
                                  title: 'Producer',
                                  content: 'Handsome Production',
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

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 100, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 120, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 140, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 150, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 100, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 300, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 400, isTouched: i == touchedIndex);
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
