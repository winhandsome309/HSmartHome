import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: Color.fromRGBO(242, 242, 246, 1),
      body: const Center(
          child: Text(
        'Notification',
      )),
    );
  }
}
