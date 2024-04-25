import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_sau_project/models/travel.dart';
import 'package:travel_sau_project/models/user.dart';
import 'package:travel_sau_project/utils/db_helper.dart';
import 'package:travel_sau_project/views/add_travel_ui.dart';
import 'package:travel_sau_project/views/show_travel_ui.dart';

class HomeUI extends StatefulWidget {
  User? user;
  HomeUI({super.key, this.user});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  //ตัวแปรเก็บข้อมูลที่ดึงมาจาก traveltb
  List<Travel>? travelInfo;

  //Method ดึงข้อมูลจาก traveltb
  getAllTravelData() {
    DBHelper.getAllTravel().then((value) => {
          setState(() {
            travelInfo = value;
          })
        });
  }

  @override
  void initState() {
    getAllTravelData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.file(
                      File(widget.user!.picture!),
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    widget.user!.fullname!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.user!.email!,
                  ),
                  Text(
                    widget.user!.phone!,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              'ข้อมูลการเดินทาง',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            travelInfo == null
                ? Container()
                : Expanded(
                    child: ListView.builder(
                    itemCount: travelInfo!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowTravelUI(
                                travelinfo: travelInfo![index],
                              ),
                            ),
                          );
                        },
                        leading: Image.file(
                          File(travelInfo![index].pictureTravel!),
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          travelInfo![index].placeTravel!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
                        subtitle: Text(
                          travelInfo![index].dateTravel!,
                        ),
                        trailing: Icon(Icons.info),
                        tileColor: index % 2 == 0
                            ? Colors.amber[100]
                            : Colors.transparent,
                      );
                    },
                  )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTravelUI(),
            ),
          ).then((value) => {
                setState(() {
                  getAllTravelData();
                })
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.red,
        ),
        backgroundColor: const Color.fromARGB(255, 195, 174, 110),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
    );
  }
}
