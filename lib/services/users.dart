import 'package:foodapp/models/users.dart';
import 'package:foodapp/services/database_service.dart';
import "package:sqflite/sqflite.dart";

class UserDB {
  final tableName = 'userstable';

// Future<int> insertUser(User user) async {
//   final Database db = await DatabaseeService().database;
//   return await db.insert(
//     tableName,
//     user.toMap(),
//     conflictAlgorithm: ConflictAlgorithm.replace,
//   );
// }

  Future<void> createTable(Database db) async {
    await db.execute(""" CREATE TABLE $tableName(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT,
    email TEXT,
    password TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
  ) """);
  }

  Future<int> createUser(User user) async {
    try {
      final Database db = await DatabaseeService().database;
      final data = await db.insert(
        tableName,
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Data  on insert $data');
      return data;
    } catch (error) {
      print('Error inserting user: $error');
      return -1;
    }
  }

  Future<List<User>> getUsers() async {
    final Database db = await DatabaseeService().database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    final users = await db.rawQuery(
        '''SELECT * FROM $tableName ORDER BY email DESC''' //? this means it will return the last inserted raw
        );

    print('Users $users');

    // return users.map((user) => User.fromJson(user)).toList();
    return List.generate(maps.length, (i) {
      return User(
        username: maps[i]['username'],
        email: maps[i]['email'],
        id: maps[i]['id'],
        password: maps[i]['password'],
      );
    });
    // map fetched user s fo our user model
  }
}
