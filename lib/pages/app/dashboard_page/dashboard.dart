import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hsmarthome/util/smart_device_box.dart';
import 'package:hsmarthome/data/provider/tempHumidAPI.dart';
import 'package:hsmarthome/data/models/adafruit_get.dart';
import 'dart:async';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // padding constants
  final double horizontalPadding = 30;
  final double verticalPadding = 25;

  ///heheheh
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Dashboard'),
    );
  }
}
