import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:foodapp/models/users.dart';
import 'package:foodapp/services/users.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// Future databaseconnection() async {
//   final database = openDatabase(
//       // Set the path to the database. Note: Using the `join` function from the
//       // `path` package is best practice to ensure the path is correctly
//       // constructed for each platform.
//       join(await getDatabasesPath(), 'wedeliverfoodapp.db'),
//       // When the database is first created, create a table
//       onCreate: (db, version) {
//     // Run the CREATE TABLE statement on the database.
//     return db.execute(
//       'CREATE TABLE registered_users(id INTEGER PRIMARY KEY, username TEXT, email TEXT, password TEXT)',
//     );
//   },

//       // Set the version. This executes the onCreate function and provides a
//       // path to perform database upgrades and downgrades.

//       version: 1);

//   print('Database Created $database');

//   return database;
// }

// - before reading the data on database we need to open connection to the database
class DatabaseeService {
  Database? _database;

  Future<Database> get database async {
    // if (_database != null) return _database!;
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullpath async {
    const dbname = 'wedeliverfoodapp.db';
    final path = await getDatabasesPath();
    return join(path, dbname);
  }

  FutureOr<void> _onUpgrade(
      Database database, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      var tableColumns =
          await database.rawQuery('PRAGMA table_info(${UserDB().tableName});');

      bool createdAtExists =
          tableColumns.indexWhere((row) => row['name'] == 'created_at') != -1;
      if (!createdAtExists) {
        await database.execute(
          'ALTER TABLE ${UserDB().tableName} ADD COLUMN created_at TEXT DEFAULT CURRENT_TIMESTAMP',
        );
      }
      bool updatedAtExists =
          tableColumns.indexWhere((row) => row['name'] == 'updated_at') != -1;
      if (!updatedAtExists) {
        await database.execute(
          'ALTER TABLE ${UserDB().tableName} ADD COLUMN updated_at TEXT DEFAULT CURRENT_TIMESTAMP',
        );
      }
    }
  }

  FutureOr<void> _onCreate(Database database, int version) async {
    // Check if the table exists
    bool hasTable = false;
    try {
      final result = await database.rawQuery(
          'SELECT name FROM sqlite_master WHERE type="table" AND name="${UserDB().tableName}"');
      hasTable = result.isNotEmpty;
    } catch (error) {
      print('Error checking table existence: $error');
    }

    if (!hasTable) {
      print('Creating table');
      await UserDB().createTable(database);
    }
  }

  Future<Database> _initialize() async {
    print("initializing database...");
    final path =
        await getApplicationDocumentsDirectory(); // Get the app's documents directory
    final dbPath =
        join(path.path, 'wedeliverfoodapp.db'); // Construct database path

    final fullpth = await fullpath;
    return openDatabase(
      fullpth,
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE userstable ("
            "id INTEGER PRIMARY KEY,"
            "username TEXT,"
            "email TEXT,"
            "password TEXT,"
            "created_at TEXT DEFAULT CURRENT_TIMESTAMP,"
            "updated_at TEXT DEFAULT CURRENT_TIMESTAMP"
            ")");
      },
      onUpgrade: _onUpgrade,
      singleInstance: true,
    );
  }

  Future<int> getDatabaseVersion() async {
    final db = await database;
    final result = await db.rawQuery('PRAGMA user_version;');

    if (result.isNotEmpty && result.first.values.isNotEmpty) {
      print('result $result');
      return result.first.values.first as int;
    }
    return 0;
  }
}



  // Future<Database> _initialize() async {
  //   final path = await fullpath;
  //   databaseFactory = databaseFactoryFfi; // Initialize databaseFactoryFfi
  //   return openDatabase(path,
  //       version: 1, onCreate: _onCreate, singleInstance: true);
  // }

  // FutureOr<void> _onCreate(Database database, int version) async {
  //   await database.execute(
  //     'CREATE TABLE registered_users(id INTEGER PRIMARY KEY, username TEXT, email TEXT, password TEXT, created_at TEXT, updated_at TEXT)',
  //   );
  // }