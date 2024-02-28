import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:foodapp/models/users.dart';
import 'package:foodapp/services/users.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:foodapp/services/product_table.services.dart';
import 'package:foodapp/models/products.model.dart';

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

var product1 = Product(
    id: 1,
    name: "Chicken Wrap",
    description: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ornare felis ligula, at mollis enim pretium in.
 Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis venenatis, quam iaculis faucibus blandit,
sellus ut odio condimentum, elementum sem mollis, porta sapien. Aliquam at ante sed purus blandit volutpat. Vivamus ''',
    price: 2000,
    image:
        "https://res.cloudinary.com/dt6rzq9tw/image/upload/v1694003963/ATLP_Champs/gqkblr12kdtq7qubz18r.jpg",
    sellerId: 1);

var product2 = Product(
    id: 2,
    name: "Pizza",
    description: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ornare felis ligula, at mollis enim pretium in.
 Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis venenatis, quam iaculis faucibus blandit,
sellus ut odio condimentum, ''',
    price: 1500,
    image:
        " https://res.cloudinary.com/dt6rzq9tw/image/upload/v1693993842/ATLP_Champs/yqfuvs5dwwbqropebbxh.jpg",
    sellerId: 1);

// - before reading the data on database we need to open connection to the database
class DatabaseeService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      print('Database already exists ${_database}');
      return _database!;
    }

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
    final mydb = await db.rawQuery(
        'SELECT name FROM sqlite_master WHERE type="table" AND name="${UserDB().tableName}"');

    if (mydb.isNotEmpty && mydb.first.values.isNotEmpty) {
      final admin = await db.rawQuery(
          '''SELECT * FROM ${mydb.first.values.first} WHERE id = 1  ''');

      if (admin.isNotEmpty) {
        print('Table exists: ${mydb.first.values.first} admin ${admin}');
        final producttable = await db.rawQuery(
            '''SELECT name FROM sqlite_master WHERE type="table" AND name="${ProductTable().tableName}"''');
        if (producttable.isNotEmpty) {
          print('Product table exists: ${producttable.first.values.first}');

          // await ProductTable().insertProduct(product1);
          await ProductTable().insertProduct(product2);
        } else {
          try {
            await ProductTable().createTable(db);
          } catch (error) {
            print('Error creating product table: $error');
          } finally {
            print('Product table created ${producttable.first.values.first}');
          }
        }
      } else {
        ('''INSERT INTO ${mydb.first.values.first} (id,username, email, password) VALUES(1,'oliviertech','oliviertech@yopmail.com','test12345' ''');
        print('No admin found with the specified conditions.');
      }
    }

    if (result.isNotEmpty && result.first.values.isNotEmpty) {
      // print('result ssss $result');
      return result.first.values.first as int;
    }
    return 0;
  }
}
