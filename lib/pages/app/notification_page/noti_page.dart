import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hsmarthome/util/smart_device_box.dart';
// import 'package:hsmarthome/pages/dashboard_page/dashboard.dart';

class NotiPage extends StatefulWidget {
  const NotiPage({super.key});

  @override
  State<NotiPage> createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {
  // padding constants
  final double horizontalPadding = 30;
  final double verticalPadding = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: const Center(
          child: Text(
        'Notification',
      )),
    );
  }
}
