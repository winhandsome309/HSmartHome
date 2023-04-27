import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hsmarthome/modules/home_controller/home_controller.dart';

import '../../../data/models/adafruit_get.dart';
import '../../../modules/home_controller/home_controller.dart';

class NotiPage extends StatefulWidget {
  const NotiPage({super.key});

  @override
  State<NotiPage> createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {
  // padding constants
  final double horizontalPadding = 30;
  final double verticalPadding = 25;
  final controller = Get.put(HomeController());

  int countNoti = 0;

  final List<Color> listColor = [
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.pink,
    Colors.blue
  ];

  // void win() {
  //   AwesomeNotifications().initialize(
  //     null,
  //     [
  //       NotificationChannel(
  //         channelKey: 'basic_channel',
  //         channelName: 'Basic notifications',
  //         channelDescription: 'Notification channel for basic tests',
  //       ),
  //     ],
  //     debug: true,
  //   );
  // }

  triggerNotification(String newtitle, String newbody) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: newtitle,
        body: newbody,
      ),
    );
  }

  delete(int index) {
    setState(() {
      HomeController.noti_list.removeAt(index);
    });
  }

  add(int index) {}

  static int count = 0;

  // add(String a, String b) {
  //   setState(() {
  //     HomeController.noti_list.add([a, b]);
  //   });
  // }

  // ignore: non_constant_identifier_names
  // static List noti_list = [
  //   [
  //     'Something went wrong!',
  //     'a.',
  //     0,
  //   ],
  //   [
  //     '2',
  //     'b.',
  //     1,
  //   ],
  //   [
  //     '3',
  //     'c.',
  //     2,
  //   ],
  //   [
  //     '1',
  //     'a.',
  //     3,
  //   ],
  // ];

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Notification'),
    //   ),
    //   body: Center(
    //     child: ElevatedButton(
    //       onPressed: triggerNotification,
    //       child: const Text('Trigger Notification'),
    //     ),
    //   ),
    // );

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
            StreamBuilder<AdafruitGET>(
              stream: controller.alarmStream.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Text(
                    "",
                    style: GoogleFonts.lexendDeca(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(34, 73, 87, 1),
                    ),
                  );
                } else {
                  if (HomeController.noti != '-' &&
                      controller.currTime != HomeController.noti.substring(2)) {
                    controller.currTime = HomeController.noti.substring(2);
                    if (HomeController.noti[0] == '0') {
                      HomeController.noti_list.insert(0, ['Gas', 'Warning']);
                      triggerNotification('Gas', 'Warning');
                    } else if (HomeController.noti[0] == '1') {
                      HomeController.noti_list
                          .insert(0, ['Password', 'Wrong Password 3 times']);
                      triggerNotification('Password', 'Wrong Password 3 times');
                    } else if (HomeController.noti[0] == '2') {
                      HomeController.noti_list
                          .insert(0, ['Password', 'Wrong Password 5 times']);
                      triggerNotification('Password', 'Wrong Password 5 times');
                    }
                    // setState(() {
                    //   HomeController.noti_list.insert(0, ['abc', 'abc']);
                    // });
                  }
                  return Expanded(
                    child: Scrollbar(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: HomeController.noti_list.length,
                        itemBuilder: (context, index) {
                          final noti = HomeController.noti_list[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Slidable(
                              key: UniqueKey(),
                              endActionPane: ActionPane(
                                dismissible: DismissiblePane(onDismissed: () {
                                  delete(index);
                                }),
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
                                      topRight: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  SlidableAction(
                                    onPressed: ((context) {
                                      delete(index);
                                    }),
                                    backgroundColor: Colors.red.shade400,
                                    label: 'Clear',
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                      topLeft: Radius.circular(12),
                                      bottomLeft: Radius.circular(12),
                                    ),
                                  ),
                                ],
                              ),
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10, left: 0, right: 15),
                                // margin: const EdgeInsets.symmetric(horizontal: 25),
                                margin: const EdgeInsets.only(
                                    top: 0, left: 20, right: 20, bottom: 0),
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
                                            color: listColor[index % 5],
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          child: const SizedBox(
                                            height: 70,
                                            width: 5,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            noti[0],
                                            style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: const Color.fromRGBO(
                                                  34, 73, 87, 1),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            noti[1],
                                            style:
                                                const TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
            // Expanded(
            //   child: Scrollbar(
            //     child: ListView.builder(
            //       physics: const BouncingScrollPhysics(
            //           parent: AlwaysScrollableScrollPhysics()),
            //       itemCount: HomeController.noti_list.length,
            //       itemBuilder: (context, index) {
            //         final noti = HomeController.noti_list[index];
            //         return Padding(
            //           padding: const EdgeInsets.only(bottom: 20),
            //           child: Slidable(
            //             key: UniqueKey(),
            //             endActionPane: ActionPane(
            //               dismissible: DismissiblePane(onDismissed: () {
            //                 delete(index);
            //               }),
            //               motion: const StretchMotion(),
            //               children: [
            //                 SlidableAction(
            //                   onPressed: ((context) {
            //                     // delete
            //                   }),
            //                   backgroundColor: Colors.white,
            //                   label: 'Options',
            //                   borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(12),
            //                     bottomLeft: Radius.circular(12),
            //                     topRight: Radius.circular(12),
            //                     bottomRight: Radius.circular(12),
            //                   ),
            //                 ),
            //                 // SizedBox(
            //                 //   width: 10,
            //                 // ),
            //                 SlidableAction(
            //                   onPressed: ((context) {
            //                     delete(index);
            //                   }),
            //                   backgroundColor: Colors.red.shade400,
            //                   label: 'Clear',
            //                   borderRadius: const BorderRadius.only(
            //                     topRight: Radius.circular(12),
            //                     bottomRight: Radius.circular(12),
            //                     topLeft: Radius.circular(12),
            //                     bottomLeft: Radius.circular(12),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             child: Container(
            //               padding: const EdgeInsets.only(
            //                   top: 10, bottom: 10, left: 0, right: 15),
            //               // margin: const EdgeInsets.symmetric(horizontal: 25),
            //               margin: const EdgeInsets.only(
            //                   top: 0, left: 20, right: 20, bottom: 0),
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.circular(14),
            //               ),
            //               child: SizedBox(
            //                 height: 60,
            //                 width: 400,
            //                 child: Row(
            //                   children: [
            //                     Padding(
            //                       padding: const EdgeInsets.only(
            //                         top: 0,
            //                         bottom: 0,
            //                         right: 15,
            //                         left: 10,
            //                       ),
            //                       child: Container(
            //                         decoration: BoxDecoration(
            //                           color: listColor[index % 5],
            //                           borderRadius: BorderRadius.circular(24),
            //                         ),
            //                         child: const SizedBox(
            //                           height: 70,
            //                           width: 5,
            //                         ),
            //                       ),
            //                     ),
            //                     Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Text(
            //                           noti[0],
            //                           style: GoogleFonts.roboto(
            //                             fontSize: 16,
            //                             fontWeight: FontWeight.bold,
            //                             color:
            //                                 const Color.fromRGBO(34, 73, 87, 1),
            //                           ),
            //                         ),
            //                         const SizedBox(height: 5),
            //                         Text(
            //                           noti[1],
            //                           style: const TextStyle(fontSize: 12),
            //                         )
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 160,
            //   ),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       setState(() {
            //         count++;
            //         triggerNotification(count.toString(), 'add');
            //         HomeController.noti_list.add([count.toString(), 'abcd']);
            //       });
            //     },
            //     child: const Text('Add'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}


// class PushNotification {
//   PushNotification({this.title, this.body, this.dataBody, this.dataTitle});
//   String? title;
//   String? body;
//   String? dataTitle;
//   String? dataBody;
// }

// class NotificationBadge extends StatelessWidget {
//   // also take a total notification value
//   final int totalNotifcation;
//   const NotificationBadge({Key? key, required this.totalNotifcation})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//           color: Colors.orange,
//           shape: BoxShape.circle,
//         ),
//         child: Center(
//           child: Padding(
//             padding: EdgeInsets.all(8),
//             child: Text(
//               "$totalNotifcation",
//               style: TextStyle(color: Colors.white, fontSize: 20),
//             ),
//           ),
//         ));
//   }
// }

// class ABC extends StatefulWidget {
//   const ABC({super.key});

//   @override
//   State<ABC> createState() => _ABCState();
// }

// class _ABCState extends State<ABC> {
//   // initialize some values
//   late final FirebaseMessaging messaging;
//   late int totalNotificationCounter;
//   // model
//   PushNotification? notificationInfo;

//   // register notification
//   void registerNotification() async {
//     await Firebase.initializeApp();
//     // instance for firebase messaging
//     messaging = FirebaseMessaging.instance;

//     // three type of state in notification
//     // not determined (null), granted (true) and decline (false)

//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       badge: true,
//       provisional: false,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print("User granted the permission");

//       // main message

//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         PushNotification notification = PushNotification(
//           title: message.notification!.title,
//           body: message.notification!.body,
//           dataTitle: message.data['title'],
//           dataBody: message.data['body'],
//         );
//         setState(() {
//           totalNotificationCounter++;
//           notificationInfo = notification;
//         });

//         showSimpleNotification(Text(notificationInfo!.title!),
//             leading:
//                 NotificationBadge(totalNotifcation: totalNotificationCounter),
//             subtitle: Text(notificationInfo!.body!),
//             background: Colors.cyan.shade700,
//             duration: Duration(seconds: 1));
//       });
//     } else {
//       print("Permission declined by user");
//     }
//   }

//   @override
//   void initState() {
//     registerNotification();
//     totalNotificationCounter = 0;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("PushNotification")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "FlutterPushNotification",
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.black, fontSize: 20),
//             ),
//             SizedBox(height: 15),
//             // showing a notification badge which will
//             // count the total notification that we received
//             NotificationBadge(totalNotifcation: totalNotificationCounter),
//             SizedBox(height: 30),

//             // if notificationInfo is not null
//             notificationInfo != null
//                 ? Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                           "TITLE: ${notificationInfo!.dataTitle ?? notificationInfo!.title}",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 16)),
//                       SizedBox(height: 9),
//                       Text(
//                           "BODY: ${notificationInfo!.dataBody ?? notificationInfo!.body}",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 16)),
//                     ],
//                   )
//                 : Container()
//           ],
//         ),
//       ),
//     );
//   }
// }
