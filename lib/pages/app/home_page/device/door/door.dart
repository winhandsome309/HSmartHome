import 'package:flutter/material.dart';
import 'package:hsmarthome/pages/app/home_page/device/door/numeric_pad.dart';
// import 'package:hsmarthome/pages/app/home_page/device/door/door_utlis.dart';
// import 'package:hsmarthome/pages/app/home_page/device/door/door_custom_draw.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:animate_icons/animate_icons.dart';
import 'package:hsmarthome/modules/home_controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:google_fonts/google_fonts.dart';

enum _MenuValues {
  reset,
}

class Door extends StatefulWidget {
  const Door({super.key});

  @override
  _DoorState createState() => _DoorState();
}

class _DoorState extends State<Door> {
  String phoneNumber = "";
  double progressVal = 0.5;
  final String wrongPass = "Wrong password";
  double targetValue = 24.0;
  bool isUnlock = false;
  final oldPasswordDoor = TextEditingController();
  final newPasswordDoor = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final controller = Get.put(HomeController());

  AnimateIconController controllerAnimated = AnimateIconController();

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Oh no!',
        message: message,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.failure,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Congrats!',
        message: message,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.success,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void resetPassword() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Form(
              key: _key,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Reset password',
                      style: GoogleFonts.lexendDeca(
                          color: Colors.green, fontSize: 20),
                    ),
                    const SizedBox(height: 25.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextFormField(
                        style: GoogleFonts.lexendDeca(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        validator: validatePasswordDoor,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(32, 223, 127, 1)),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          fillColor: const Color.fromRGBO(34, 73, 87, 1),
                          filled: true,
                          hintText: 'Old password',
                          hintStyle: GoogleFonts.lexendDeca(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          // prefixIcon: const Icon(Icons.person),
                        ),
                        controller: oldPasswordDoor,
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextFormField(
                        style: GoogleFonts.lexendDeca(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        validator: validatePasswordDoor,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(32, 223, 127, 1)),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          fillColor: const Color.fromRGBO(34, 73, 87, 1),
                          filled: true,
                          hintText: 'New password',
                          hintStyle: GoogleFonts.lexendDeca(
                            fontSize: 15,
                            color: Colors.white,
                          ),

                          // prefixIcon: const Icon(Icons.person),
                        ),
                        controller: newPasswordDoor,
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () => {
                        if (_key.currentState!.validate())
                          {
                            if (oldPasswordDoor.text !=
                                HomeController.password.substring(3))
                              {
                                showErrorMessage('Old password does not match'),
                              }
                            else
                              {
                                Navigator.pop(context),
                                showSuccessMessage('Successfully'),
                                controller.passControl(
                                    'CHANGE-${newPasswordDoor.text}'),
                              }
                          }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 75),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text(
                            'Reset',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void enterAccountPassword() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          //   icon: const Icon(
          //     Icons.check_circle_outline_sharp,
          //     size: 100,
          //     color: Colors.green,
          //   ),
          //   backgroundColor: Colors.white,
          title: Center(
            child: Column(
              children: [
                Text(
                  'Enter your password to coninue',
                  style:
                      GoogleFonts.lexendDeca(color: Colors.red, fontSize: 15),
                ),
                const SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: TextFormField(
                    style: GoogleFonts.lexendDeca(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(32, 223, 127, 1)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      fillColor: const Color.fromRGBO(34, 73, 87, 1),
                      filled: true,
                      hintText: 'Enter your password',
                      hintStyle: GoogleFonts.lexendDeca(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      // prefixIcon: const Icon(Icons.person),
                    ),
                    // controller: _usernameController,
                    obscureText: false,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.pop(context),
                    resetPassword(),
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 75),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => {
            Navigator.pop(context),
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            size: 30,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Unlock your door",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(34, 73, 87, 1)),
        ),
        actions: [
          // Icon(Icons.settings, color: Colors.black),
          // SizedBox(
          //   width: 15,
          // ),

          PopupMenuButton<_MenuValues>(
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            color: Colors.white,
            position: PopupMenuPosition.under,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: _MenuValues.reset,
                child: Text('Reset password',
                    style: TextStyle(color: Colors.black)),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case _MenuValues.reset:
                  enterAccountPassword();
                  break;
              }
            },
          ),
        ],
        backgroundColor: const Color.fromRGBO(242, 242, 246, 1),
        elevation: 0,
        centerTitle: true,
        // textTheme: Theme.of(context).textTheme,
      ),
      body: Scaffold(
        backgroundColor: const Color.fromRGBO(242, 242, 246, 1),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 60),
                child: CircularPercentIndicator(
                  radius: 90,
                  lineWidth: 3,
                  percent: phoneNumber.length / 6,
                  progressColor: (isUnlock ? Colors.green : Colors.pink),
                  backgroundColor: Colors.grey.shade300,
                  circularStrokeCap: CircularStrokeCap.round,
                  animation: true,
                  animationDuration: 200,
                  animateFromLastPercent: true,
                  center: !isUnlock
                      ? const Icon(Icons.lock, color: Colors.pink, size: 60)
                      : TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: 60),
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.bounceInOut,
                          builder: (BuildContext context, double size,
                              Widget? child) {
                            return IconButton(
                              iconSize: size,
                              color: Colors.blue,
                              icon: child!,
                              onPressed: () {
                                setState(() {
                                  // targetValue = targetValue == 24.0 ? 48.0 : 24.0;
                                });
                              },
                            );
                          },

                          // child: const Icon(Icons.home, color: Colors.pink),
                          child:
                              const Icon(Icons.lock_open, color: Colors.green),
                        ),
                ),
              ),
              NumericPad(
                onNumberSelected: (value) {
                  setState(() {
                    if (value != -1 && phoneNumber.length < 6) {
                      phoneNumber = phoneNumber + value.toString();
                    } else if (value == -1 && phoneNumber.isNotEmpty) {
                      phoneNumber =
                          phoneNumber.substring(0, phoneNumber.length - 1);
                    }
                    if (phoneNumber.length == 6) {
                      String pattern = "";
                      if (HomeController.password.length == 9) {
                        pattern = HomeController.password.substring(3);
                      } else {
                        pattern = HomeController.password.substring(4);
                      }
                      if (phoneNumber == pattern) {
                        setState(() {
                          isUnlock = true;
                          controller.passControl("OPEN-$pattern");
                        });
                      } else {
                        phoneNumber = '';
                        Future.delayed(const Duration(milliseconds: 100), () {
                          final snackBar = SnackBar(
                            /// need to set following properties for best effect of awesome_snackbar_content
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'On Snap!',
                              message: wrongPass,

                              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                              contentType: ContentType.failure,
                            ),
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        });
                        // void showErrorMessage(String message) {
                        // final snackBar = SnackBar(
                        //   /// need to set following properties for best effect of awesome_snackbar_content
                        //   elevation: 0,
                        //   behavior: SnackBarBehavior.floating,
                        //   backgroundColor: Colors.transparent,
                        //   content: AwesomeSnackbarContent(
                        //     title: 'On Snap!',
                        //     message: wrongPass,

                        //     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        //     contentType: ContentType.failure,
                        //   ),
                        // );
                        // ScaffoldMessenger.of(context)
                        //   ..hideCurrentSnackBar()
                        //   ..showSnackBar(snackBar);
                        // }
                      }
                    }
                  });
                },
              ),
            ],
          )),
        ),
      ),
    );
  }
}

String? validatePasswordDoor(String? formPass) {
  if (formPass == null || formPass.isEmpty) {
    return 'Password is required.';
  }
  String pattern = r'^(?=.*?[0-9]).{6,6}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPass)) {
    return '''
Password must be 6 digits.
    ''';
  }
  return null;
}
