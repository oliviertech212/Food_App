import 'package:foodapp/models/users.dart';
import 'package:foodapp/services/database_service.dart';
import "package:sqflite/sqflite.dart";

class UserDB {
  final tableName = 'userstable';

  Future<void> createTable(Database db, int version) async {
    await db.execute(""" CREATE TABLE $tableName(
    id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
    username TEXT,
    email TEXT UNIQUE,
    password TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
  ) """);
  }

  // Future<int> createUser(User user) async {
  //   try {
  //     Database? db;
  //     if (db == null) {
  //       throw Exception('Database not initialized');
  //     }
  //     final data = await db.insert(
  //       tableName,
  //       user.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace,
  //     );
  //     print('Data  on insert $data');
  //     return data;
  //   } catch (error) {
  //     print('Error inserting user: $error');
  //     return -1;
  //   }
  // }

  // Future<List<User>> getUsers() async {
  //   Database? db;
  //   if (db == null) {
  //     throw Exception('Database not initialized');
  //   }
  //   final List<Map<String, dynamic>> maps =  await db.query(tableName);
  //   final users =
  //       await db.rawQuery('''SELECT * FROM $tableName ORDER BY email DESC''');

  //   print('Users $users');

  //   // return users.map((user) => User.fromJson(user)).toList();
  //   return List.generate(maps.length, (i) {
  //     return User(
  //       username: maps[i]['username'],
  //       email: maps[i]['email'],
  //       id: maps[i]['id'],
  //       password: maps[i]['password'],
  //     );
  //   });
  //   // map fetched user s fo our user model
  // }
}
