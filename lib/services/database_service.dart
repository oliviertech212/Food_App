import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:foodapp/models/category.model.dart';
import 'package:foodapp/models/users.dart';
import 'package:foodapp/services/category_service.dart';
import 'package:foodapp/services/users.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:foodapp/services/product_table.services.dart';
import 'package:foodapp/models/products.model.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

Future databaseconnection() async {
  final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'wedeliverfoodapp.db'),
      // When the database is first created, create a table
      onCreate: (db, version) {
    // Run the CREATE TABLE statement on the database.
    return db.execute(
      'CREATE TABLE registered_users(id INTEGER PRIMARY KEY, username TEXT, email TEXT, password TEXT)',
    );
  },

      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.

      version: 1);

  print('Database Created $database');

  return database;
}
//  Image.asset(
//                 "assets/images/diamond.jpeg",
//                 height: 50,
//               ),

var product1 = Product(
    id: 1,
    name: "Chicken Wrap",
    description: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ornare felis ligula, at mollis enim pretium in.
 Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis venenatis, quam iaculis faucibus blandit,
sellus ut odio condimentum, elementum sem mollis, porta sapien. Aliquam at ante sed purus blandit volutpat. Vivamus ''',
    price: 3000,
    category: category1.id,
    image:
        // "https://res.cloudinary.com/dt6rzq9tw/image/upload/v1694003963/ATLP_Champs/gqkblr12kdtq7qubz18r.jpg",

        "assets/images/chickenwrap.jpeg",
    sellerId: 1);

var product2 = Product(
    id: 2,
    name: "Pizza",
    description: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ornare felis ligula, at mollis enim pretium in.
 Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis venenatis, quam iaculis faucibus blandit,
sellus ut odio condimentum, ''',
    price: 1500,
    image: "assets/images/pizza.jpeg",
    category: category1.id,
    sellerId: 1);

var product3 = Product(
    id: 3,
    name: "spanish Rice",
    description: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ornare felis ligula, at mollis enim pretium in.
 Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis venenatis, quam iaculis faucibus blandit,
sellus ut odio condimentum, ''',
    price: 10000,
    image: "assets/images/spanishrice.jpeg",
    category: category1.id,
    sellerId: 1);

var product4 = Product(
    id: 4,
    name: "pilau Rice",
    description: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ornare felis ligula, at mollis enim pretium in.
 Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis venenatis, quam iaculis faucibus blandit,
sellus ut odio condimentum, ''',
    price: 4000,
    category: category4.id,
    image: "assets/images/pilaurice.jpeg",
    sellerId: 1);

var product5 = Product(
    id: 5,
    name: "Chicken",
    description: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ornare felis ligula, at mollis enim pretium in.
 Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis venenatis, quam iaculis faucibus blandit,
sellus ut odio condimentum, ''',
    price: 10000,
    category: category1.id,
    image: "assets/images/chicken.jpeg",
    sellerId: 1);

var product6 = Product(
    id: 6,
    name: "Cabbage salad",
    description: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ornare felis ligula, at mollis enim pretium in.
 Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis venenatis, quam iaculis faucibus blandit,
sellus ut odio condimentum, ''',
    price: 5000,
    category: category3.id,
    image: "assets/images/cabbagesalad.jpeg",
    sellerId: 1);

var product7 = Product(
    id: 7,
    name: "Dessert1",
    description: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ornare felis ligula, at mollis enim pretium in.
 Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis venenatis, quam iaculis faucibus blandit,
sellus ut odio condimentum, ''',
    price: 2000,
    image: "assets/images/Dessert1.jpeg",
    category: category2.id,
    sellerId: 1);

var product8 = Product(
    id: 8,
    name: "French Fries",
    description: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ornare felis ligula, at mollis enim pretium in.
 Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis venenatis, quam iaculis faucibus blandit,
sellus ut odio condimentum, ''',
    price: 3000,
    image: "assets/images/fries.jpeg",
    category: category1.id,
    sellerId: 1);

var category1 = Categorys(
    id: 1,
    name: "Main Menu",
    image: "assets/images/mainmenu.jpeg",
    free: "Yes");

var category2 = Categorys(
    id: 2,
    name: "Dessert Menu",
    image: "assets/images/Dessert.jpeg",
    free: "No");

var category3 = Categorys(
    id: 3, name: "Salad", image: "assets/images/sarad.jpeg", free: "No");

var category4 = Categorys(
    id: 4,
    name: "Best Sales",
    image: "assets/images/bestsales.jpeg",
    free: "Yes");

// - before reading the data on database we need to open connection to the database

class DatabaseService {
  Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      print('Database already exists ${_database}');

      return _database!;
    }

    return await initialize();
  }

  Future<void> initState() async {
    // Moved initialize() to initState()
    if (_database == null) {
      await initialize();
    }
  }

  Future initialize() async {
    // Get the database path
    // final path = await getDatabasesPath();
    // final dbPath = join(path, 'wedeliverfoodapp1.db');

    final path =
        await getApplicationDocumentsDirectory(); // Get the app's documents directory
    final dbPath = join(path.path, 'wedeliverfoodapp.db');
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dir = documentsDirectory.path + "/ApplicationFolder";
    String p = join(dir, 'wedeliverfoodapp.db');

    // Open the database connection and handle errors
    try {
      _database = await openDatabase(
        // join(await getDatabasesPath(), 'wedeliverfoodapp.db'),
        // dbPath,
        p,
        version: 2,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        singleInstance: true,
      );
    } catch (error) {
      print('Error opening database on initializer : $error');
      // Handle other potential errors gracefully
    }
    // Create tables if necessary
    // await _createTables();
  }

  // Future initialize() async {
  //   try {
  //     // final path = await getDatabasesPath();
  //     // final dbPath = join(path, 'wedeliverfoodapp1.db');

  //     final path =
  //         await getApplicationDocumentsDirectory(); // Get the app's documents directory
  //     final dbPath = join(path.path, 'wedeliverfoodapp.db');

  //     // Open the database connection and handle errors
  //     _database = await openDatabase(
  //       dbPath,
  //       version: 1, // Adjust version if needed for schema changes
  //       onCreate: _onCreate,
  //       onUpgrade: _onUpgrade,
  //     );

  //     print('Database opened successfully.');
  //   } catch (error) {
  //     print('Error initializing database: $error');
  //     // Handle other potential errors gracefully
  //     throw error; // Add this line to throw the error if initialization fails
  //   }
  // }

  FutureOr<void> _onUpgrade(
      Database database, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      var tableColumns =
          await database.rawQuery('PRAGMA table_info(${UserDB().tableName});');

      bool createdAtExists =
          tableColumns.indexWhere((row) => row['name'] == 'created_at') != -1;
      // if (!createdAtExists) {
      //   await database.execute(
      //     'ALTER TABLE ${UserDB().tableName} ADD COLUMN created_at TEXT DEFAULT CURRENT_TIMESTAMP',
      //   );
      // }
      // bool updatedAtExists =
      //     tableColumns.indexWhere((row) => row['name'] == 'updated_at') != -1;
      // if (!updatedAtExists) {
      //   await database.execute(
      //     'ALTER TABLE ${UserDB().tableName} ADD COLUMN updated_at TEXT DEFAULT CURRENT_TIMESTAMP',
      //   );
      // }
    }
  }

  FutureOr<void> _onCreate(Database database, int version) async {
    // Check if the table exists
    bool hasTable = false;
    bool hasproducttable = false;
    bool hasadmin = false;
    bool hasCategory = false;
    bool hascategorydata = false;

    try {
      final result = await database.rawQuery(
          'SELECT name FROM sqlite_master WHERE type="table" AND name="${UserDB().tableName}"');

      hasTable = result.isNotEmpty;
      if (hasTable) {
        final result = await database.rawQuery(
          '''SELECT 1 FROM ${UserDB().tableName} WHERE id = 1''',
        );
        //  - _database!.execute('DROP TABLE IF EXISTS ${UserDB().tableName}');

        print(" user exist ${result.first}");
        if (result.isNotEmpty) {
          hasadmin = true;
        } else {
          await database.execute(
            '''INSERT INTO ${UserDB().tableName} (id, username, email, password) VALUES(1, 'oliviertech', 'oliviertech@yopmail.com', 'test12345')''',
          );
        }
      }

      final resultcategory = await database.rawQuery(
        '''SELECT 1 FROM sqlite_master WHERE type="table" AND name="${CategoryTable().tableName}"''',
      );

      hasCategory = resultcategory.isNotEmpty;

      if (hasCategory) {
        final List<Map<String, Object?>> categorydata =
            await database.query(CategoryTable().tableName);

        if (categorydata.isEmpty) {
          await database.insert(
            CategoryTable().tableName,
            category1.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          await database.insert(
            CategoryTable().tableName,
            category2.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          await database.insert(
            CategoryTable().tableName,
            category3.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          await database.insert(
            CategoryTable().tableName,
            category4.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        } else {
          hascategorydata = true;
        }
      } else {
        print("creating category table");
        await CategoryTable().createTable(database, version);
      }

      final resultproduct = await database.rawQuery(
        '''SELECT 1 FROM sqlite_master WHERE type="table" AND name="${ProductTable().tableName}"''',
      );
      //- _database!.execute('DROP TABLE IF EXISTS ${CategoryTable().tableName}');
      hasproducttable = resultproduct.isNotEmpty;
      if (hasadmin && hasCategory && !hasproducttable) {
        await ProductTable().createTable(database, version);
      } else if (hasadmin && hasCategory && hasproducttable) {
        print("insertinf product");
        await database.insert(
          ProductTable().tableName,
          product1.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        await database.insert(
          ProductTable().tableName,
          product2.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        await database.insert(
          ProductTable().tableName,
          product5.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        await database.insert(
          ProductTable().tableName,
          product4.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        await database.insert(
          ProductTable().tableName,
          product3.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      } else {
        print("things are ok");
      }
    } catch (error) {
      print('Error checking table existence: $error');
    }
    if (!hasTable) {
      print('creating usertable');
      await UserDB().createTable(database, version);
    }

    if (!hasCategory) {
      print('creating categorytable');
      await CategoryTable().createTable(database, version);
    }

    if (!hasproducttable) {
      print('creating producttable');
      await ProductTable().createTable(database, version);
    }
  }

  Future<int> getDatabaseVersion() async {
    final db = await database;
    final result = await db.rawQuery('PRAGMA user_version;');
    if (result.isNotEmpty && result.first.values.isNotEmpty) {
      print("Database version: ${result.first.values.first}");
      return result.first.values.first as int;
    }
    return 0;
  }

  Future<List<User>> getUsers() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(UserDB().tableName);
    final users = await _database!.rawQuery(
        '''SELECT * FROM ${UserDB().tableName} ORDER BY email DESC''');

    print('Users $users');
    if (maps.isEmpty) {
      await db.execute(
        '''INSERT INTO ${UserDB().tableName} (id, username, email, password) VALUES(1, 'oliviertech', 'oliviertech@yopmail.com', 'test12345')''',
      );

      // await db.insert(
      //   UserDB().tableName,
      //   User().toMap(),
      //   conflictAlgorithm: ConflictAlgorithm.replace,
      // );
    }

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

  Future<List<Product>> getAllproduct() async {
    final db = await database;
    try {
      if (_database == null) {
        throw Exception('Database not initialized on get all products');
      }
      final List<Map<String, Object?>> productsMaps =
          await db.query(ProductTable().tableName);
      print("products date${productsMaps.toString()}");

      if (productsMaps.isEmpty) {
        await db.insert(
          ProductTable().tableName,
          product1.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        await db.insert(
          ProductTable().tableName,
          product2.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        await db.insert(
          ProductTable().tableName,
          product3.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        await db.insert(
          ProductTable().tableName,
          product4.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        await db.insert(
          ProductTable().tableName,
          product5.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      // Convert the list of each dog's fields into a list of `Dog` objects.
      return [
        for (final {
              'id': id as int,
              'name': name as String,
              'price': price as dynamic,
              'description': description as String,
              'category': category as dynamic,
              'countInStock': countInStock as dynamic,
              'sellerId': sellerId as dynamic,
              'createdAt': createdAt as dynamic,
              'updatedAt': updatedAt as dynamic,
              'image': image as String
            } in productsMaps)
          Product(
              id: id,
              name: name,
              price: price,
              category: int.parse(category),
              description: description,
              sellerId: sellerId,
              image: image)
      ];
    } catch (e) {
      print("Error while getting product $e");
      return e as dynamic;
    }
  }

  Future<List<Categorys>> getCategories() async {
    final db = await database;

    try {
      final List<Map<String, dynamic>> categories =
          await db.query(CategoryTable().tableName);

      if (categories.isEmpty) {
        await db.insert(
          CategoryTable().tableName,
          category1.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        await db.insert(
          CategoryTable().tableName,
          category2.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        await db.insert(
          CategoryTable().tableName,
          category3.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        await db.insert(
          CategoryTable().tableName,
          category4.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      print("categories${categories}");

      return [
        for (final {
              'id': id as dynamic,
              'name': name as String,
              'image': image as String,
              'free': free as String,
            } in categories)
          Categorys(id: id, name: name, image: image, free: free)
      ];
    } catch (e) {
      print("Error while getting categories $e");
      return e as dynamic;
    }
  }
}
