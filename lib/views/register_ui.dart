import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:travel_sau_project/models/user.dart';
import 'package:travel_sau_project/utils/db_helper.dart';
import 'package:uuid/uuid.dart';

class RegisterUI extends StatefulWidget {
  const RegisterUI({super.key});

  @override
  State<RegisterUI> createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  bool pwdStatus = true;

  //TextField COntroller
  TextEditingController fullnameCtrl = TextEditingController(text: '');
  TextEditingController emailCtrl = TextEditingController(text: '');
  TextEditingController phoneCtrl = TextEditingController(text: '');
  TextEditingController usernameCtrl = TextEditingController(text: '');
  TextEditingController passwordCtrl = TextEditingController(text: '');

  //variable for showing and variable in DB
  File? showImage;
  String? saveImage;

  //OpenCam
  takePhoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    //checkcam
    if (image == null) return;

    //save pic in device
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String newDirectory = appDirectory.path + Uuid().v4();
    File newImageFile = File(newDirectory);

    //save pic in variable to save in db
    saveImage = newDirectory;

    //file position settting
    await newImageFile.writeAsBytes(File(image.path).readAsBytesSync());

    //set pic to show on screen
    setState(() {
      showImage = newImageFile;
    });
  }

  //show warning message
  showWarningMessage(context, msg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('คำเตือน'),
          content: Text(msg),
          actions: <Widget>[
            ElevatedButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'ลงทะเบียนเข้าใช้งาน',
          style: GoogleFonts.kanit(),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    showImage == null
                        ? CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.2,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/logo.png',
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(
                              100,
                            ),
                            child: Image.file(
                              showImage!,
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.width * 0.4,
                              fit: BoxFit.cover,
                            ),
                          ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          takePhoto();
                        });
                      },
                      icon: Icon(
                        FontAwesomeIcons.cameraRetro,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15,
                    right: MediaQuery.of(context).size.width * 0.15,
                    bottom: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: TextField(
                    controller: fullnameCtrl,
                    decoration: InputDecoration(
                      labelText: 'ชื่อ-สกุล',
                      labelStyle: GoogleFonts.kanit(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15,
                    right: MediaQuery.of(context).size.width * 0.15,
                    bottom: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: TextField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'อีเมล์',
                      labelStyle: GoogleFonts.kanit(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15,
                    right: MediaQuery.of(context).size.width * 0.15,
                    bottom: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: TextField(
                    controller: phoneCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'เบอร์โทรศัพท์',
                      labelStyle: GoogleFonts.kanit(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15,
                    right: MediaQuery.of(context).size.width * 0.15,
                    bottom: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: TextField(
                    controller: usernameCtrl,
                    decoration: InputDecoration(
                      labelText: 'ชื่อผู้ใช้',
                      labelStyle: GoogleFonts.kanit(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15,
                    right: MediaQuery.of(context).size.width * 0.15,
                    bottom: MediaQuery.of(context).size.width * 0.1,
                  ),
                  child: TextField(
                    controller: passwordCtrl,
                    obscureText: pwdStatus,
                    decoration: InputDecoration(
                      labelText: 'รหัสผ่าน',
                      labelStyle: GoogleFonts.kanit(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            pwdStatus = pwdStatus == true ? false : true;
                          });
                        },
                        icon: Icon(
                          pwdStatus == true
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (fullnameCtrl.text.trim().isEmpty == true) {
                      showWarningMessage(context, 'ป้อนชื่อ-สกุลด้วย');
                    } else if (emailCtrl.text.trim().isEmpty == true) {
                      showWarningMessage(context, 'ป้อนอีเมลด้วย');
                    } else if (phoneCtrl.text.trim().isEmpty == true) {
                      showWarningMessage(context, 'ป้อนเบอร์โทรศัพท์ด้วย');
                    } else if (usernameCtrl.text.trim().isEmpty == true) {
                      showWarningMessage(context, 'ป้อนไอดีผู้ใช้ด้วย');
                    } else if (passwordCtrl.text.trim().isEmpty == true) {
                      showWarningMessage(context, 'ป้อนรหัสผ่านด้วย');
                    } else if (saveImage == null) {
                      showWarningMessage(context, 'กรุณาถ่ายรูปด้วย');
                    } else {
                      //พร้อมบันทึกลงฐานข้อมูล
                      int result = await DBHelper.insertUser(
                        User(
                          fullname: fullnameCtrl.text,
                          email: emailCtrl.text,
                          phone: phoneCtrl.text,
                          username: usernameCtrl.text,
                          password: passwordCtrl.text,
                          picture: saveImage,
                        ),
                      );

                      if (result != 0) {
                        Navigator.pop(context);
                      } else {
                        showWarningMessage(context,
                            'พบปัญหาในการบันทึกข้อมูล กรุณาลองใหม่อีกครั้ง');
                      }
                    }
                  },
                  child: Text(
                    'ลงทะเบียน',
                    style: GoogleFonts.kanit(),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.7,
                      MediaQuery.of(context).size.width * 0.125,
                    ),
                    backgroundColor: Colors.amber,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
