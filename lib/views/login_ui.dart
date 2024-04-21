import 'package:flutter/material.dart';
import 'package:travel_sau_project/models/user.dart';
import 'package:travel_sau_project/utils/db_helper.dart';
import 'package:travel_sau_project/views/home_ui.dart';
import 'package:travel_sau_project/views/register_ui.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  bool pwdStatus = true;

  //สร้างควบคุม TextField
  TextEditingController usernameCtrl = TextEditingController(text: '');
  TextEditingController passwordCtrl = TextEditingController(text: '');

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'บันทึกการเดินทาง',
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                left: 50.0,
                right: 50.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Image.asset(
                    'assets/images/logo.png',
                    height: MediaQuery.of(context).size.height * 0.18,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Text(
                    'เข้าใช้งานแอปพลิเคชัน',
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: MediaQuery.of(context).size.height * 0.025),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.001,
                  ),
                  Text(
                    'บันทึกการเดินทาง',
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: MediaQuery.of(context).size.height * 0.025),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    children: [
                      Text(
                        'ชื่อผู้ใช้',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  TextField(
                    controller: usernameCtrl,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    children: [
                      Text(
                        'รหัสผ่าน',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  TextField(
                    controller: passwordCtrl,
                    obscureText: pwdStatus,
                    decoration: InputDecoration(
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      //validate input
                      if (usernameCtrl.text.trim().isEmpty == true) {
                        showWarningMessage(context, 'ป้อนชื่อผู้ใช้ด้วย');
                      } else if (passwordCtrl.text.trim().isEmpty == true) {
                        showWarningMessage(context, 'ป้อนรหัสผ่านด้วย');
                      } else {
                        //เรียกเมธอดตรวจการ Sign in
                        User? user = await DBHelper.checkSignin(
                            usernameCtrl.text, passwordCtrl.text);

                        if (user == null) {
                          showWarningMessage(
                              context, 'ชื่อผู้ใช้ รหัสผ่านไม่ถูกต้อง');
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeUI(
                                user: user,
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: Text(
                      'SIGN IN',
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(
                        MediaQuery.of(context).size.width,
                        50.0,
                      ),
                      backgroundColor: Colors.amber,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  CheckboxListTile(
                    onChanged: (paramValue) {},
                    value: false,
                    title: Text('จำคำการเข้าใช้งานแอปฯ'),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterUI()),
                        );
                      });
                    },
                    child: Text(
                      'ลงทะเบียนเข้าใช้งาน',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
