import 'package:foodapp/models/products.model.dart';
import 'package:foodapp/services/database_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:foodapp/services/users.dart';

class ProductTable {
  final tableName = 'productstable';

  Future<void> createTable(Database db, int version) async {
    await db.execute(""" CREATE TABLE $tableName(
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,
  name TEXT,
  price TEXT,
  description TEXT  ,
  image TEXT,
  countInStock INTEGER DEFAULT 100,
  category TEXT DEFAULT "Food",
  rating TEXT,
  sellerId INTEGER NOT NULL,
  createdAt TEXT DEFAULT CURRENT_TIMESTAMP,
  updatedAt TEXT DEFAULT CURRENT_TIMESTAMP,
  Foreign Key (sellerId) References userstable(id)
  ) """);
  }

  // Future<int> insertProduct(Product product) async {
  //   try {
  //     // Use the existing database service instance
  //     Database? db;

  //     if (db == null) {
  //       throw Exception('Database not initialized');
  //     }

  //     final data = await db.insert(
  //       tableName,
  //       product.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace,
  //     );
  //     print('Data on insert $data');
  //     return data;
  //   } catch (error) {
  //     print('Error inserting product: $error');
  //     return -1;
  //   }
  // }

  // Future<List<Product>> getAllproduct() async {
  //   try {
  //     Database? db;
  //     if (db == null) {
  //       throw Exception('Database not initialized');
  //     }

  //     final List<Map<String, Object?>> productsMaps = await db.query(tableName);
  //     print("products date${productsMaps}");

  //     // Convert the list of each dog's fields into a list of `Dog` objects.
  //     return [
  //       for (final {
  //             'id': id as int,
  //             'name': name as String,
  //             'price': price as dynamic,
  //             'description': description as String,
  //             'category': category as String,
  //             'countInStock': countInStock as int,
  //             'sellerId': sellerId as dynamic,
  //             'createdAt': createdAt as dynamic,
  //             'updatedAt': updatedAt as dynamic,
  //             'image': image as String
  //           } in productsMaps)
  //         Product(
  //             id: id,
  //             name: name,
  //             price: price,
  //             description: description,
  //             sellerId: sellerId,
  //             image: image)
  //     ];
  //   } catch (e) {
  //     print("Error while getting product $e");

  //     return e as dynamic;
  //   }
  // }
}
