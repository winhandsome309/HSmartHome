import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hsmarthome/util/smart_device_box.dart';
// import 'package:hsmarthome/pages/dashboard_page/dashboard.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: const Center(
          child: Text(
        'Dashboard',
      )),
    );
  }
}
