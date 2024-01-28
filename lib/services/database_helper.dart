import 'package:monocle/models/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Products2.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Products(id INTEGER, email TEXT, title TEXT NOT NULL, cost DOUBLE NOT NULL, price DOUBLE NOT NULL, stock INTEGER NOT NULL, PRIMARY KEY(id, email));"),
        version: _version);
  }

  static Future<int> addProduct(Product product) async {
    final db = await _getDB();
    return await db.insert("Products", product.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateProduct(Product product) async {
    final db = await _getDB();
    return await db.update("Products", product.toJson(),
        where: 'id = ?',
        whereArgs: [product.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteProduct(Product product) async {
    final db = await _getDB();
    return await db.delete("Products", where: 'id = ?', whereArgs: [product.id]);
  }

  static Future<List<Product>?> getAllProduct(String? email) async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Products", where: 'email = $email');

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Product.fromJson(maps[index]));
  }

  static Future deleteTable(String tableName) async{

    final db = await _getDB();
    return db.rawQuery('DELETE FROM ${tableName}');

  }

}
