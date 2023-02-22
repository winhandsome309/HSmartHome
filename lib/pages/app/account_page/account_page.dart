import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:hsmarthome/data/models/adafruit_get.dart';
// import 'package:get/get.dart';
// import 'dart:async';
// import 'package:hsmarthome/data/provider/tempHumidAPI.dart';
// import 'package:hsmarthome/data/models/room_model.dart';
// import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
// import 'package:logging/logging.dart';
// import 'package:stack_trace/stack_trace.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // padding constants

  void singUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final double horizontalPadding = 30;
  final double verticalPadding = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                'Profile',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('lib/images/icon_google.png'),
                    ),
                    Positioned(
                      right: -12,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 46,
                          width: 46,
                          decoration:
                              BoxDecoration(color: Colors.grey.shade300),
                          child: const Center(child: Icon(Icons.camera_alt)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              Options(
                iconRow: Icons.person,
                s: 'My Account',
                k: 149,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              Options(
                iconRow: Icons.settings,
                s: 'Settings',
                k: 172,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              Options(
                iconRow: Icons.help_center,
                s: 'Help Center',
                k: 150,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              Options(
                iconRow: Icons.logout,
                s: 'Log Out',
                k: 175,
                onTap: () => {singUserOut()},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Options extends StatelessWidget {
  final IconData iconRow;
  final String s;
  final double k;
  final Function()? onTap;
  const Options({
    super.key,
    required this.iconRow,
    required this.s,
    required this.k,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(iconRow),
            const SizedBox(width: 20),
            Text(s, style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(width: k),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
