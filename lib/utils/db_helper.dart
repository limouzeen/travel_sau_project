import 'package:sqflite/sqflite.dart';
import 'package:travel_sau_project/models/travel.dart';
import 'package:travel_sau_project/models/user.dart';

//เป็นไฟล์ที่ทำงานกับ DB:insert, update, delete, select
class DBHelper {
  //Method for create DB to use with Relational Database
  static Future<Database> db() async {
    return openDatabase('travelrecord.db', version: 1,
        onCreate: (Database database, int version) async {
      //สร้างตารางต่างๆเพื่อค.สะดวกมีหลายตาราง
      //ให้ไปสร้างเป็นเมธิดต่างหากแล้วเรียกใช้

      await createUserTable(database);
      await createTravelTable(database);
    });
  }

  //create METHOD table User
  static Future<void> createUserTable(Database database) async {
    await database.execute('''
      create table usertb (
        id integer primary key autoincrement not null,
        fullname text,
        email text,
        phone text,
        username text,
        password text,
        picture text
      )
      ''');
  }

  //create METHOD table Travel
  static Future<void> createTravelTable(Database database) async {
    await database.execute('''
      create table traveltb (
        id integer primary key autoincrement not null,
        pictureTravel text,
        placeTravel text,
        costTravel text,
        dateTravel text,
        dayTravel text,
        locationTravel text
      )
      ''');
  }

  //cMETJOD for save data for RegisterUI
  static Future<int> insertUser(User user) async {
    final db = await DBHelper.db();

    final id = await db.insert(
      'usertb',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  //cMETJOD for save data for RegisterUI
  static Future<int> insertTravel(Travel travel) async {
    final db = await DBHelper.db();

    final id = await db.insert(
      'traveltb', //ชื่อตารางที่สร้างไว้
      travel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  //METHOD SIGN IN
  static Future<User?> checkSignin(String username, String password) async {
    final db = await DBHelper.db();

    List<Map<String, dynamic>> result = await db.query(
      'usertb',
      where: 'username = ? and password = ?',
      whereArgs: [username, password],
    );

    //ตรวจสอบQuery
    if (result.length > 0) {
      return User.fromMap(result[0]);
    } else {
      return null;
    }
  }
}
