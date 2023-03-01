import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class SmartDeviceBox extends StatefulWidget {
  String smartDeviceName;
  String iconPath;
  bool powerOn;
  void Function(bool)? onChanged;

  SmartDeviceBox({
    super.key,
    required this.smartDeviceName,
    required this.iconPath,
    required this.powerOn,
    required this.onChanged,
  });

  @override
  State<SmartDeviceBox> createState() => _SmartDeviceBoxState();
}

class _SmartDeviceBoxState extends State<SmartDeviceBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: widget.powerOn
              ? Colors.grey[900]
              : const Color.fromARGB(44, 164, 167, 189),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // icon
              Row(
                children: [
                  const SizedBox(
                    width: 13,
                  ),
                  Image.asset(
                    widget.iconPath,
                    height: 60,
                    color: widget.powerOn ? Colors.white : Colors.grey.shade900,
                  ),
                  const SizedBox(
                    width: 33,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: widget.powerOn ? Colors.white : Colors.black,
                  ),
                ],
              ),

              // smart device name + switch
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        widget.smartDeviceName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: widget.powerOn ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: pi / 2,
                    child: CupertinoSwitch(
                      value: widget.powerOn,
                      onChanged: widget.onChanged,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
