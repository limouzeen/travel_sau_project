import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_sau_project/models/travel.dart';

class ShowTravelUI extends StatefulWidget {
  Travel? travelinfo;
  ShowTravelUI({super.key, this.travelinfo});

  @override
  State<ShowTravelUI> createState() => _ShowTravelUIState();
}

class _ShowTravelUIState extends State<ShowTravelUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  100,
                ),
                child: Image.file(
                  File(widget.travelinfo!.pictureTravel!),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              Text(
                'สถานที่ที่เดินทางไป',
              ),
              Text(
                widget.travelinfo!.placeTravel!,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              Text(
                'ค่าใช้จ่ายในการเดินทาง (บาท)',
              ),
              Text(
                widget.travelinfo!.costTravel!,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              Text(
                'วันที่เดินทางไป',
              ),
              Text(
                widget.travelinfo!.dateTravel!,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              Text(
                'จำนวนวันที่เดินทางไป (วัน)',
              ),
              Text(
                widget.travelinfo!.dayTravel!,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
