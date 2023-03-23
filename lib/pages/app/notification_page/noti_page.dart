import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class NotiPage extends StatefulWidget {
  const NotiPage({super.key});

  @override
  State<NotiPage> createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {
  // padding constants
  final double horizontalPadding = 30;
  final double verticalPadding = 25;

  int countNoti = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 238, 240, 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 25,
                left: 25,
                bottom: 30,
              ),
              child: Text(
                'Notification Center',
                style: GoogleFonts.lexendDeca(
                  fontSize: 23,
                  color: const Color.fromRGBO(72, 72, 74, 1),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: ListView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    Noti(
                      label: 'Something went wrong!',
                      content: 'a.',
                      indexNoti: 0,
                    ),
                    Noti(
                      label: '2',
                      content: 'b.',
                      indexNoti: 1,
                    ),
                    Noti(
                      label: '3',
                      content: 'c.',
                      indexNoti: 2,
                    ),
                    Noti(
                      label: '1',
                      content: 'a.',
                      indexNoti: 3,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Noti extends StatefulWidget {
  String label;
  String content;
  int indexNoti;
  Noti(
      {super.key,
      required this.label,
      required this.content,
      required this.indexNoti});

  @override
  State<Noti> createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  final List<Color> listColor = [
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.pink,
    Colors.blue
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: ((context) {
                  // delete
                }),
                backgroundColor: Colors.white,
                label: 'Options',
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              // SizedBox(
              //   width: 10,
              // ),
              SlidableAction(
                onPressed: ((context) {
                  // delete
                }),
                backgroundColor: Colors.red.shade400,
                label: 'Clear',
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
              ),
            ],
          ),
          child: Container(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 15),
            // margin: const EdgeInsets.symmetric(horizontal: 25),
            margin:
                const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: SizedBox(
              height: 60,
              width: 400,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0,
                      bottom: 0,
                      right: 15,
                      left: 10,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: listColor[widget.indexNoti],
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const SizedBox(
                        height: 70,
                        width: 5,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label,
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(34, 73, 87, 1),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.content,
                        style: const TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
