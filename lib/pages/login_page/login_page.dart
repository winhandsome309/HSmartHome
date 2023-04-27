import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hsmarthome/pages/login_page/auth_page.dart';
import 'package:hsmarthome/pages/login_page/register_page.dart';
import 'package:hsmarthome/service/auth_service.dart';
import 'dart:async';
import 'package:hsmarthome/modules/home_controller/home_controller.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, 0);
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool _passwordVisible = true;
  bool enabled = false;

  Future signUserIn() async {
    // Show loading circle.
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      HomeController.emailAccount = emailController.text;
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AuthPage()),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
      setState(() {
        enabled = false;
      });
    }
  }

  void showErrorMessage(String message) {
    if (message == 'user-not-found') message = 'User not found';
    if (message == 'wrong-password') message = 'Wrong password';
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'On Snap!',
        message: message,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.failure,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  HomeController x = HomeController();
  @override
  initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
    x.streamInit();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _key,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 180),
                  Text(
                    'Sign In',
                    style: GoogleFonts.lexendDeca(
                      fontSize: 40,
                      color: const Color.fromRGBO(34, 73, 87, 1),

                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  const SizedBox(height: 50),

                  // Username textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: TextFormField(
                      style: GoogleFonts.lexendDeca(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      validator: validateEmail,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          // borderSide:
                          // BorderSide(color: Color.fromRGBO(34, 73, 87, 1)),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(32, 223, 127, 1)),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        fillColor: const Color.fromRGBO(34, 73, 87, 1),
                        filled: true,
                        hintText: 'Email',
                        hintStyle: GoogleFonts.lexendDeca(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      controller: emailController,
                      obscureText: false,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: TextFormField(
                      style: GoogleFonts.lexendDeca(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      validator: validatePassword,
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
                        hintText: 'Password',
                        hintStyle: GoogleFonts.lexendDeca(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        // prefixIcon: const Icon(Icons.key),
                        suffixIcon: IconButton(
                          color: Colors.white,
                          icon: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(
                              () {
                                _passwordVisible = !_passwordVisible;
                              },
                            );
                          },
                        ),
                      ),
                      controller: passwordController,
                      obscureText: _passwordVisible,
                    ),
                  ),

                  const SizedBox(height: 10.0),

                  // Forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25.0),

                  // Sign in button
                  GestureDetector(
                    onTap: () async {
                      if (_key.currentState!.validate()) {
                        await signUserIn();
                      } else {
                        setState(() {
                          enabled = false;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 35),
                      decoration: BoxDecoration(
                        color: (enabled
                            ? const Color.fromRGBO(32, 223, 127, 1)
                                .withOpacity(0.4)
                            : const Color.fromRGBO(32, 223, 127, 1)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.lexendDeca(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    onTapDown: (TapDownDetails details) {
                      setState(() {
                        enabled = true;
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        enabled = false;
                      });
                    },
                  ),

                  const SizedBox(height: 25),

                  // Or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Color.fromRGBO(9, 53, 69, 1),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Color.fromRGBO(9, 53, 69, 1),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Google + Facebook + Twitter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                        onTap: () => AuthService().signInWithGoogle(),
                        imagePath: 'lib/images/icon_google.png',
                      ),
                      const SizedBox(width: 20),
                      SquareTile(
                        onTap: () => AuthService().signInWithFacebook(),
                        imagePath: 'lib/images/icon_facebook.png',
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Not a member? Register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()),
                          ),
                        },
                        child: Text(
                          'Register now',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: const Color.fromRGBO(0, 129, 249, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Stack(
                    children: [
                      ClipPath(
                        clipper: ProsteBezierCurve(
                          position: ClipPosition.top,
                          list: [
                            BezierCurveSection(
                              start: Offset(screenWidth, 30),
                              top: Offset(screenWidth / 4 * 3, 40),
                              end: Offset(screenWidth / 2, 20),
                            ),
                            BezierCurveSection(
                              start: Offset(screenWidth / 2, 0),
                              top: Offset(screenWidth / 4, 0),
                              end: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Container(
                          height: 80,
                          color: const Color.fromRGBO(32, 223, 127, 0.8),
                        ),
                      ),
                      ClipPath(
                        clipper: ProsteBezierCurve(
                          position: ClipPosition.top,
                          list: [
                            BezierCurveSection(
                              start: Offset(screenWidth, 30),
                              top: Offset(screenWidth / 4 * 3, 0),
                              end: Offset(screenWidth / 2, 30),
                            ),
                            BezierCurveSection(
                              start: Offset(screenWidth / 2, 30),
                              top: Offset(screenWidth / 4, 60),
                              end: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Container(
                          color: const Color.fromRGBO(34, 73, 87, 0.8),
                          height: 80,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SquareTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const SquareTile({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey.shade200,
        ),
        child: Image.asset(
          imagePath,
          height: 45,
        ),
      ),
    );
  }
}

// Validation Email
String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return 'E-mail address is required.';
  }
  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';
  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return 'Password is required.';
  }

  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*[#?!@$%^&*-]).{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword)) {
    return '''
Password must be at least 8 characters,
include an uppercase letter, 
number and symbol [#, ?, !, @, %, ^, &, *, -].
    ''';
  }
  return null;
}
