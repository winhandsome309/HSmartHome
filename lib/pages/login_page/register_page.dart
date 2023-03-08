import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hsmarthome/pages/login_page/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool _passwordVisible = true;
  bool enabled = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
  }

  Future signUserUp() async {
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
      if (_passwordController.text == _confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        addUserDetails(_usernameController.text, _emailController.text);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        setState(() {
          enabled = false;
        });
        registerSuccessfull();
      } else {
        Navigator.pop(context);
        showErrorMessage('Password don\'t match!');
        setState(() {
          enabled = false;
        });
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
      setState(() {
        enabled = false;
      });
    }
  }

  Future addUserDetails(String username, String email) async {
    await FirebaseFirestore.instance
        .collection('users')
        .add({
          'username': username,
          'email': email,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(message, style: const TextStyle(color: Colors.white)),
          ),
        );
      },
    );
  }

  void registerSuccessfull() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(
            Icons.check_circle_outline_sharp,
            size: 100,
            color: Colors.green,
          ),
          backgroundColor: Colors.white,
          title: Center(
            child: Column(
              children: [
                const Text(
                  'Success!',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Registered successfully',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                const SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    ),
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
                        'Login',
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
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _key,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Logo

                  const SizedBox(height: 130),

                  // Hello again! Welcome back you've been missed
                  Text(
                    'Sign Up',
                    style: GoogleFonts.lexendDeca(
                      fontSize: 40,
                      color: Color.fromRGBO(34, 73, 87, 1),
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Username textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: const Color.fromRGBO(34, 73, 87, 1),
                        filled: true,
                        hintText: 'Username',
                        hintStyle: GoogleFonts.lexendDeca(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        // prefixIcon: const Icon(Icons.person),
                      ),
                      controller: _usernameController,
                      obscureText: false,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Email textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: const Color.fromRGBO(34, 73, 87, 1),
                        filled: true,
                        hintText: 'Email',
                        hintStyle: GoogleFonts.lexendDeca(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        // prefixIcon: const Icon(Icons.mail),
                      ),
                      controller: _emailController,
                      obscureText: false,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
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
                      controller: _passwordController,
                      obscureText: _passwordVisible,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Confirm password.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: const Color.fromRGBO(34, 73, 87, 1),
                        filled: true,
                        hintText: 'Confirm Password',
                        hintStyle: GoogleFonts.lexendDeca(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        // prefixIcon: const Icon(Icons.verified),
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
                      controller: _confirmPasswordController,
                      obscureText: _passwordVisible,
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Sign in button
                  GestureDetector(
                    onTap: () async {
                      if (_key.currentState!.validate()) {
                        await signUserUp();
                      } else {
                        setState(() {
                          enabled = false;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: (enabled
                            ? Color.fromRGBO(32, 223, 127, 1).withOpacity(0.4)
                            : Color.fromRGBO(32, 223, 127, 1)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Create Account',
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

                  const SizedBox(height: 35),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
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
                                builder: (context) => const LoginPage()),
                          ),
                        },
                        child: Text(
                          'Login now',
                          style: GoogleFonts.montserrat(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
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
                              end: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Container(
                          height: 80,
                          color: Color.fromRGBO(32, 223, 127, 0.8),
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
                              end: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Container(
                          color: Color.fromRGBO(34, 73, 87, 0.8),
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
          height: 50,
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
