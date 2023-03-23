import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hsmarthome/pages/app/home_page/device/fan/fan.dart';

class SmartDeviceBox extends StatefulWidget {
  String smartDeviceName;
  String iconPath;
  bool powerOn;
  void Function(bool)? onChanged;
  VoidCallback onTap;

  SmartDeviceBox({
    super.key,
    required this.smartDeviceName,
    required this.iconPath,
    required this.powerOn,
    required this.onChanged,
    required this.onTap,
  });

  @override
  State<SmartDeviceBox> createState() => _SmartDeviceBoxState();
}

class _SmartDeviceBoxState extends State<SmartDeviceBox> {
  @override
  Widget build(BuildContext context) {
    if (widget.smartDeviceName == 'Add') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: widget.powerOn ? Colors.grey[900] : Colors.white,
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 40, right: 0, top: 30, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      widget.iconPath,
                      height: 60,
                      color:
                          widget.powerOn ? Colors.white : Colors.grey.shade900,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: widget.powerOn ? Colors.grey[900] : Colors.white,
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 0, top: 15, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // icon
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    widget.iconPath,
                    height: 50,
                    color: widget.powerOn ? Colors.white : Colors.grey.shade900,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: (widget.smartDeviceName == 'Gas Detector'
                          ? (widget.powerOn ? Colors.grey[900] : Colors.white)
                          : (widget.powerOn ? Colors.white : Colors.black)),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),

              // smart device name + switch
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Text(
                        widget.smartDeviceName,
                        style: GoogleFonts.lexendDeca(
                            fontSize: 14,
                            color: widget.powerOn
                                ? Colors.white
                                : const Color.fromRGBO(34, 73, 87, 1)),
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: 4 * pi / 2,
                    child: CupertinoSwitch(
                      activeColor: const Color.fromRGBO(9, 210, 138, 1),
                      trackColor: const Color.fromRGBO(34, 73, 87, 1),
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
