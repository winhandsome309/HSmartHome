import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hsmarthome/util/smart_device_box.dart';
// import 'package:hsmarthome/pages/dashboard_page/dashboard.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // padding constants
  final double horizontalPadding = 30;
  final double verticalPadding = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: const Center(
          child: Text(
        'Thanh',
      )),
    );
  }
}
