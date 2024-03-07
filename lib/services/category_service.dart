import 'package:sqflite/sqflite.dart';

class CategoryTable {
  final String tableName = 'category';

  Future<void> createTable(Database db, int version) async {
    await db.execute(""" CREATE TABLE IF NOT EXISTS $tableName(
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,
  name TEXT NOT NULL UNIQUE,
  image TEXT,
  free  TEXT  DEFAULT "No",
  createdAt TEXT DEFAULT CURRENT_TIMESTAMP,
  updatedAt TEXT DEFAULT CURRENT_TIMESTAMP
  ) """);
  }
}
