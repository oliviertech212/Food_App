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
    sellerId: 1);

var product4 = Product(
    id: 4,
    name: "pilau Rice",
    description: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ornare felis ligula, at mollis enim pretium in.
 Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis venenatis, quam iaculis faucibus blandit,
sellus ut odio condimentum, ''',
    price: 4000,
    image: "assets/images/pilaurice.jpeg",
    sellerId: 1);

var product5 = Product(
    id: 5,
    name: "Chicken",
    description: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ornare felis ligula, at mollis enim pretium in.
 Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis venenatis, quam iaculis faucibus blandit,
sellus ut odio condimentum, ''',
    price: 4000,
    image: "assets/images/chicken.jpeg",
    sellerId: 1);

// - before reading the data on database we need to open connection to the database
class DatabaseeServicesss {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      print('Database already exists ${_database}');
      return _database!;
    }

    return await _initialize();
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
      print('creating usertable');
      await UserDB().createTable(database, version);
    }
  }

  Future<Database> _initialize() async {
    print("initializing database...");

    try {
      final path =
          await getApplicationDocumentsDirectory(); // Get the app's documents directory
      final dbPath =
          join(path.path, 'wedeliverfoodapp.db'); // Construct database path

      const dbname = 'wedeliverfoodapp.db';
      final pat = await getDatabasesPath();
      final fullpth = join(pat, dbname);

      return openDatabase(
        join(await getDatabasesPath(), 'wedeliverfoodapp.db'),
        version: 1,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        singleInstance: true,
      );
    } catch (e) {
      print('Error initializing database: $e');

      return Future.error(e);
    }
  }

  Future<int> getDatabaseVersion() async {
    final db = await database;
    final result = await db.rawQuery('PRAGMA user_version;');
    final mydb = await db.rawQuery(
        'SELECT name FROM sqlite_master WHERE type="table" AND name="${UserDB().tableName}"');

    print('Table exists: ${mydb.first.values.first} ');

    if (mydb.isNotEmpty && mydb.first.values.isNotEmpty) {
      final admin = await db.rawQuery(
          '''SELECT * FROM ${mydb.first.values.first} WHERE id = 1  ''');
      if (mydb.isNotEmpty && mydb.first.values.isNotEmpty) {
        final admin = await db.rawQuery(
            '''SELECT * FROM ${mydb.first.values.first} WHERE id = 1''');
        if (admin.isNotEmpty) {
          print('Table exists: ${mydb.first.values.first} admin ${admin[0]}');
          final producttable = await db.rawQuery(
              '''SELECT name FROM sqlite_master WHERE type="table" AND name="${ProductTable().tableName}"''');
          if (producttable.isNotEmpty) {
            print('Product table exists: ${producttable.first.values.first}');
            // try {
            //   await db.execute('DROP TABLE IF EXISTS productstable');
            //   print("Deleting");
            // } catch (e) {
            //   print("Error: $e");
            // }

            // await ProductTable().insertProduct(product1);
            // await ProductTable().insertProduct(product2);
          } else {
            try {
              print("Product table does not exist ");
              // await ProductTable().createTable(db);
            } catch (error) {
              print('Error creating product table: $error');
            }
          }
        } else {
          try {
            await db.execute(
                '''INSERT INTO ${mydb.first.values.first} (id, username, email, password) VALUES(1, 'oliviertech', 'oliviertech@yopmail.com', 'test12345')''');
            print('Admin inserted successfully.');
          } catch (e) {
            print('Error inserting admin: $e');
          }
        }
      }
    } else if (result.isNotEmpty && result.first.values.isNotEmpty) {
      return result.first.values.first as int;
    }
    return 0;
  }
}

class DatabaseService {
  Database? _database;

  Database? get database => _database;

  // Future<Database> get database async {
  //   // if (_database != null) {
  //   print('Database already exists ${_database}');
  //   return _database!;
  //   // }

  //   // return await initialize();
  // }

  Future<void> initState() async {
    // Moved initialize() to initState()
    if (_database == null) {
      await initialize();
    }
  }

  Future<void> initialize() async {
    // Get the database path
    // final path = await getDatabasesPath();
    // final dbPath = join(path, 'wedeliverfoodapp1.db');

    final path =
        await getApplicationDocumentsDirectory(); // Get the app's documents directory
    final dbPath = join(path.path, 'wedeliverfoodapp.db');

    // Open the database connection and handle errors
    try {
      _database = await openDatabase(
        dbPath,
        version: 1, // Adjust version if needed for schema changes
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        singleInstance: true,
      );
    } catch (error) {
      print('Error opening database: $error');
      // Handle other potential errors gracefully
    }

    // Create tables if necessary
    await _createTables();
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create User and Product tables
    await UserDB().createTable(db, version);
    await ProductTable().createTable(db, version);

    // Check for user existence and create if necessary
    final userExists = await _userExists();
    print("userexist${userExists}");
    if (!userExists) {
      await insertAdmin();
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle schema upgrade logic if necessary
  }

  Future<void> _createTables() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    final userTableExists = await _userTableExists();
    if (!userTableExists) {
      await UserDB()
          .createTable(_database!, 1); // Assuming no schema changes yet
    } else {
      final user = await getUsers();
      // if (user.isEmpty) {
      //   await insertAdmin();
      // }
      // await _database!.execute('DROP TABLE IF EXISTS ${UserDB().tableName}');

      print('Table userstable already exists.');
    }

    final productTableExists = await _productTableExists();
    if (!productTableExists) {
      await ProductTable()
          .createTable(_database!, 1); // Assuming no schema changes yet
    } else {
      final product = await getAllproduct();
      // if (product.isEmpty) {
      //   await insertProducts();
      // }
      // await _database!.execute('DROP TABLE IF EXISTS productstable');

      print('Table productstable already exists ffff.${product}');
    }
  }

  Future<bool> _userTableExists() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    final result = await _database!.rawQuery(
      '''SELECT 1 FROM sqlite_master WHERE type="table" AND name="${UserDB().tableName}"''',
    );
    return result.isNotEmpty;
  }

  Future<bool> _productTableExists() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    final result = await _database!.rawQuery(
      '''SELECT 1 FROM sqlite_master WHERE type="table" AND name="${ProductTable().tableName}"''',
    );
    return result.isNotEmpty;
  }

  Future<bool> _userExists() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    final result = await _database!.rawQuery(
      '''SELECT 1 FROM ${UserDB().tableName} WHERE id = 1''',
    );
    print(" user exist ${result.first}");
    return result.isNotEmpty;
  }

  Future<void> insertAdmin() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    try {
      await _database!.execute(
        '''INSERT INTO ${UserDB().tableName} (id, username, email, password) VALUES(1, 'oliviertech', 'oliviertech@yopmail.com', 'test12345')''',
      );
      print('Admin inserted successfully.');
    } catch (error) {
      print('Error inserting admin: $error');
    }
  }

  Future<void> insertProducts() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    try {
      await insertProduct(product1);
      print('Product 1 inserted successfully.');

      await insertProduct(product2);
      await insertProduct(product3);
      await insertProduct(product4);
      await insertProduct(product5);
      print('Product 2 inserted successfully.');

      print('All products inserted successfully.');
    } catch (error) {
      print('Error inserting products: $error');
    }
  }

  Future<int> createUser(User user) async {
    try {
      if (_database == null) {
        throw Exception('Database not initialized');
      }
      final data = await _database!.insert(
        ProductTable().tableName,
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
    if (_database == null) {
      throw Exception('on getuseDatabase not initialized');
    }
    final List<Map<String, dynamic>> maps =
        await _database!.query(UserDB().tableName);
    final users = await _database!.rawQuery(
        '''SELECT * FROM ${UserDB().tableName} ORDER BY email DESC''');

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

  Future<int> insertProduct(Product product) async {
    try {
      if (_database == null) {
        throw Exception('Database not initialized');
      }

      final data = await _database!.insert(
        ProductTable().tableName,
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Data on insert $data');
      return data;
    } catch (error) {
      print('Error inserting product: $error');
      return -1;
    }
  }

  Future<List<Product>> getAllproduct() async {
    try {
      if (_database == null) {
        throw Exception('Database not initialized');
      }

      final List<Map<String, Object?>> productsMaps =
          await _database!.query(ProductTable().tableName);
      print("products date${productsMaps}");

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
              description: description,
              sellerId: sellerId,
              image: image)
      ];
    } catch (e) {
      print("Error while getting product $e");

      return e as dynamic;
    }
  }
}
