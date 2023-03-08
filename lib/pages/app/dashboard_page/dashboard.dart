import 'dart:async';
import 'dart:math';
import 'package:hsmarthome/bar_chart/resources/app_resources.dart';
import 'package:hsmarthome/bar_chart/extensions/color_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
  final Color touchedBarColor = const Color.fromRGBO(9, 210, 138, 1);

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
      backgroundColor: Color.fromRGBO(242, 242, 246, 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                children: const [
                  Icon(Icons.arrow_back_ios_rounded),
                  Text('This week'),
                  Icon(Icons.arrow_forward_ios_rounded),
                ],
              ),
            ),
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
                  top: 10, bottom: 17, left: 15, right: 15),
              // margin: const EdgeInsets.symmetric(horizontal: 25),
              margin: const EdgeInsets.only(
                  left: 25, right: 25, top: 10, bottom: 25),
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const SizedBox(
                            height: 80,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
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
              // child: Expanded(
              //   child: Scrollbar(
              //     child: SingleChildScrollView(
              //       child: ListView(
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
                        padding: EdgeInsets.symmetric(horizontal: 50.0),
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
                        padding: EdgeInsets.symmetric(horizontal: 50.0),
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
                        padding: EdgeInsets.symmetric(horizontal: 50.0),
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
              // ),
              // ),
              // ),
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
    double width = 16,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor.darken(80))
              : const BorderSide(color: Colors.white, width: 0),
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
            return makeGroupData(5, 250, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 300, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      gridData: FlGridData(
        show: true,
        getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.black,
          strokeWidth: 0.2,
        ),
        getDrawingVerticalLine: (value) => FlLine(
          color: Colors.black,
          strokeWidth: 0.2,
          dashArray: [8, 4],
        ),
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
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      // gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('M', style: style);
        break;
      case 1:
        text = const Text('T', style: style);
        break;
      case 2:
        text = const Text('W', style: style);
        break;
      case 3:
        text = const Text('T', style: style);
        break;
      case 4:
        text = const Text('F', style: style);
        break;
      case 5:
        text = const Text('S', style: style);
        break;
      case 6:
        text = const Text('S', style: style);
        break;
      default:
        text = const Text('', style: style);
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
            Expanded(
              child: Column(
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
                    animationDuration: 2000,
                    lineHeight: 6,
                    percent: widget.percentage,
                    progressColor: Color.fromRGBO(9, 210, 138, 1),
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
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
        // const Expanded(
        const Icon(
          Icons.arrow_forward_ios_outlined,
          size: 17,
        ),
        // ),
      ],
    );
  }
}
