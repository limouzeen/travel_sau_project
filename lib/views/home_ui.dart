import 'package:flutter/material.dart';
import 'package:travel_sau_project/models/user.dart';

class HomeUI extends StatefulWidget {
  User? user;
  HomeUI({super.key, this.user});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
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
        child: Text(
          widget.user!.fullname!,
        ),
      ),
    );
  }
}
