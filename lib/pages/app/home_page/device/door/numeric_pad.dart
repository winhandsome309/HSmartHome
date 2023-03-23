import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:hsmarthome/pages/app/home_page/device/door/door.dart';

class NumericPad extends StatefulWidget {
  final Function(int) onNumberSelected;

  NumericPad({required this.onNumberSelected});

  @override
  State<NumericPad> createState() => _NumericPadState();
}

class _NumericPadState extends State<NumericPad> {
  bool isPressed0 = false;
  bool isPressed1 = false;
  bool isPressed2 = false;
  bool isPressed3 = false;
  bool isPressed4 = false;
  bool isPressed5 = false;
  bool isPressed6 = false;
  bool isPressed7 = false;
  bool isPressed8 = false;
  bool isPressed9 = false;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(242, 242, 246, 1),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),

        // child: GridView.builder(
        //   itemCount: 12,
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 3,
        //     childAspectRatio: 1 / 0.8,
        //   ),
        //   itemBuilder: (context, index) {
        //     return buttonNumber(
        //       number: index + 1,
        // onTap: () {
        //   widget.onNumberSelected(index + 1);
        //   setState(() {
        //     isPressed = true;
        //   });
        //   Future.delayed(const Duration(milliseconds: 100), () {
        //     setState(() {
        //       isPressed = false;
        //     });
        //   });
        // },
        //       isPressed: isPressed,
        //       onNumberSelected: widget.onNumberSelected,
        //     );
        //   },
        // ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildNumber1(1),
                  buildNumber2(2),
                  buildNumber3(3),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildNumber4(4),
                  buildNumber5(5),
                  buildNumber6(6),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildNumber7(7),
                  buildNumber8(8),
                  buildNumber9(9),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildEmptySpace(),
                  buildNumber0(0),
                  buildBackspace(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNumber1(int number) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onNumberSelected(number);
          setState(() {
            isPressed1 = true;
          });
          Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              isPressed1 = false;
            });
          });
        },
        child: Padding(
          // padding: const EdgeInsets.all(10),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: (isPressed1 ? Colors.grey : Colors.white),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: GoogleFonts.lexendDeca(
                  fontSize: 28,
                  // fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(34, 73, 87, 1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNumber2(int number) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onNumberSelected(number);
          setState(() {
            isPressed2 = true;
          });
          Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              isPressed2 = false;
            });
          });
        },
        child: Padding(
          // padding: const EdgeInsets.all(10),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: (isPressed2 ? Colors.grey : Colors.white),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: GoogleFonts.lexendDeca(
                  fontSize: 28,
                  // fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(34, 73, 87, 1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNumber3(int number) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onNumberSelected(number);
          setState(() {
            isPressed3 = true;
          });
          Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              isPressed3 = false;
            });
          });
        },
        child: Padding(
          // padding: const EdgeInsets.all(10),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: (isPressed3 ? Colors.grey : Colors.white),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: GoogleFonts.lexendDeca(
                  fontSize: 28,
                  // fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(34, 73, 87, 1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNumber4(int number) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onNumberSelected(number);
          setState(() {
            isPressed4 = true;
          });
          Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              isPressed4 = false;
            });
          });
        },
        child: Padding(
          // padding: const EdgeInsets.all(10),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: (isPressed4 ? Colors.grey : Colors.white),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: GoogleFonts.lexendDeca(
                  fontSize: 28,
                  // fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(34, 73, 87, 1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNumber5(int number) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onNumberSelected(number);
          setState(() {
            isPressed5 = true;
          });
          Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              isPressed5 = false;
            });
          });
        },
        child: Padding(
          // padding: const EdgeInsets.all(10),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: (isPressed5 ? Colors.grey : Colors.white),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: GoogleFonts.lexendDeca(
                  fontSize: 28,
                  // fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(34, 73, 87, 1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNumber6(int number) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onNumberSelected(number);
          setState(() {
            isPressed6 = true;
          });
          Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              isPressed6 = false;
            });
          });
        },
        child: Padding(
          // padding: const EdgeInsets.all(10),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: (isPressed6 ? Colors.grey : Colors.white),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: GoogleFonts.lexendDeca(
                  fontSize: 28,
                  // fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(34, 73, 87, 1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNumber7(int number) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onNumberSelected(number);
          setState(() {
            isPressed7 = true;
          });
          Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              isPressed7 = false;
            });
          });
        },
        child: Padding(
          // padding: const EdgeInsets.all(10),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: (isPressed7 ? Colors.grey : Colors.white),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: GoogleFonts.lexendDeca(
                  fontSize: 28,
                  // fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(34, 73, 87, 1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNumber8(int number) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onNumberSelected(number);
          setState(() {
            isPressed8 = true;
          });
          Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              isPressed8 = false;
            });
          });
        },
        child: Padding(
          // padding: const EdgeInsets.all(10),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: (isPressed8 ? Colors.grey : Colors.white),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: GoogleFonts.lexendDeca(
                  fontSize: 28,
                  // fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(34, 73, 87, 1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNumber9(int number) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onNumberSelected(number);
          setState(() {
            isPressed9 = true;
          });
          Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              isPressed9 = false;
            });
          });
        },
        child: Padding(
          // padding: const EdgeInsets.all(10),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: (isPressed9 ? Colors.grey : Colors.white),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: GoogleFonts.lexendDeca(
                  fontSize: 28,
                  // fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(34, 73, 87, 1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNumber0(int number) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onNumberSelected(number);
          setState(() {
            isPressed0 = true;
          });
          Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              isPressed0 = false;
            });
          });
        },
        child: Padding(
          // padding: const EdgeInsets.all(10),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: (isPressed0 ? Colors.grey : Colors.white),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: GoogleFonts.lexendDeca(
                  fontSize: 28,
                  // fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(34, 73, 87, 1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBackspace() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onNumberSelected(-1);
          setState(() {
            isPressed = true;
          });
          Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              isPressed = false;
            });
          });
        },
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: (isPressed
                  ? Colors.redAccent.withOpacity(0.5)
                  : Colors.redAccent),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.backspace,
                size: 28,
                color: Color.fromRGBO(34, 73, 87, 1),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmptySpace() {
    return Expanded(
      child: Container(),
    );
  }
}

class buttonNumber extends StatefulWidget {
  int number;
  // VoidCallback onTap;
  bool isPressed;
  Function(int) onNumberSelected;

  buttonNumber({
    super.key,
    required this.number,
    // required this.onTap,
    required this.isPressed,
    required this.onNumberSelected,
  });

  @override
  State<buttonNumber> createState() => _buttonNumberState();
}

class _buttonNumberState extends State<buttonNumber> {
  @override
  final controller = Get.put(NumericPad);

  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        // onTap: () {
        //   controller.onNumberSelected(int.parse(widget.number));
        //   setState(() {
        //     isPressed = true;
        //   });
        //   Future.delayed(const Duration(milliseconds: 100), () {
        //     setState(() {
        //       isPressed = false;
        //     });
        //   });
        // },
        onTap: () {
          widget.onNumberSelected(widget.number + 1);

          // setState(() {
          //   widget.isPressed = true;
          // });
          // Future.delayed(const Duration(milliseconds: 50), () {
          //   setState(() {
          //     widget.isPressed = false;
          // widget.onNumberSelected(widget.number + 1);
          // });

          // NumericPad.onNumberSelected;
          // widget.onNumberSelected(widget.number + 1);
          // });

          // NumericPad.onNumberSelected;
          // widget.onNumberSelected(widget.number + 1);
        },
        child: Padding(
          // padding: const EdgeInsets.all(10),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: (widget.isPressed ? Colors.grey : Colors.white),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Center(
              child: Text(
                widget.number.toString(),
                style: GoogleFonts.lexendDeca(
                  fontSize: 28,
                  // fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(34, 73, 87, 1),
                ),
              ),
            ),
          ),
        ),
      ),
      // );
    );
  }
}
