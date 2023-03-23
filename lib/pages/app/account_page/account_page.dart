import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';

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

  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
    uploadFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 238, 240, 1),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 25,
                  left: verticalPadding,
                  right: verticalPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Account",
                            style: GoogleFonts.lexendDeca(
                              fontSize: 23,
                              color: const Color.fromRGBO(72, 72, 74, 1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                // height: 380,
                height: 550,
                child: Scrollbar(
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, right: 10, left: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              const CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    AssetImage('lib/images/icon_google.png'),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Welcome,',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(122, 115, 115, 1),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Win Handsome',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'xuanthangnguyen@gmail.com',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 36),
                              const Icon(Icons.arrow_forward_ios_outlined),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Options(
                        iconRow: Icons.settings,
                        s: 'App settings',
                        k: 187,
                        varicolor: const Color.fromRGBO(122, 115, 115, 1),
                        onTap: () {},
                      ),
                      const SizedBox(height: 20),
                      Options(
                        iconRow: Icons.logout,
                        s: 'User guide',
                        k: 202,
                        varicolor: const Color.fromRGBO(122, 115, 115, 1),
                        onTap: () {},
                      ),
                      const SizedBox(height: 20),
                      Options(
                        iconRow: Icons.logout,
                        s: 'Frequently asked questions',
                        k: 76,
                        varicolor: const Color.fromRGBO(122, 115, 115, 1),
                        onTap: () {},
                      ),
                      // const SizedBox(height: 20),
                      // Options(
                      //   iconRow: Icons.logout,
                      //   s: 'Update',
                      //   k: 229,
                      //   varicolor: const Color.fromRGBO(122, 115, 115, 1),
                      //   onTap: () => {singUserOut()},
                      // ),
                      // const SizedBox(height: 20),
                      // Options(
                      //   iconRow: Icons.help_center,
                      //   s: 'Help',
                      //   k: 248,
                      //   varicolor: const Color.fromRGBO(122, 115, 115, 1),
                      //   onTap: () {},
                      // ),
                      const SizedBox(height: 20),
                      Options(
                        iconRow: Icons.logout,
                        s: 'Log out',
                        k: 225,
                        varicolor: const Color.fromRGBO(215, 51, 51, 1),
                        onTap: () => {singUserOut()},
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: Color.fromRGBO(122, 115, 115, 1),
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 11,
                    color: Color.fromRGBO(122, 115, 115, 1),
                  ),
                  SizedBox(width: 55),
                  Text(
                    'Imprint',
                    style: TextStyle(
                      color: Color.fromRGBO(122, 115, 115, 1),
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color.fromRGBO(122, 115, 115, 1),
                    size: 11,
                  ),
                  SizedBox(width: 55),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Color.fromRGBO(122, 115, 115, 1),
                    size: 16,
                  ),
                  Text(
                    'English',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color.fromRGBO(122, 115, 115, 1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                  color: Color.fromARGB(255, 204, 204, 204),
                ),
              ),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.copyright,
                    color: Color.fromRGBO(122, 115, 115, 1),
                    size: 15,
                  ),
                  Text(
                    ' Handsome Production 2023',
                    style: GoogleFonts.josefinSans(
                      fontSize: 10,
                      color: const Color.fromRGBO(122, 115, 115, 1),
                    ),
                  ),
                ],
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
  final Color varicolor;
  final Function()? onTap;
  const Options({
    super.key,
    required this.iconRow,
    required this.s,
    required this.k,
    required this.varicolor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.only(top: 17, bottom: 17, left: 10, right: 10),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            const SizedBox(width: 15),
            Text(s,
                style: GoogleFonts.lexendDeca(
                  color: varicolor,
                  fontSize: 15,
                )),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: varicolor,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
