import 'package:monocle/models/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Products.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Product(id INTEGER PRIMARY KEY, title TEXT NOT NULL);"),
        version: _version);
  }

  static Future<int> addProduct(Product product) async {
    final db = await _getDB();
    return await db.insert("Product", product.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateProduct(Product product) async {
    final db = await _getDB();
    return await db.update("Product", product.toJson(),
        where: 'id = ?',
        whereArgs: [product.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteProduct(Product product) async {
    final db = await _getDB();
    return await db.delete("Product", where: 'id = ?', whereArgs: [product.id]);
  }

  static Future<List<Product>?> getAllProduct() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Product");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Product.fromJson(maps[index]));
  }
}
