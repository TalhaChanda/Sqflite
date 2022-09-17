import 'package:dhobiaya/models/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, 'dbobiaya.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE products(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, price INTEGER)');
    }, version: 1);
  }

  Future<ProductModel> insert(ProductModel productModel) async {
    final dbClient = await DBHelper.database();
    await dbClient.insert('products', productModel.toMap());

    return productModel;
  }

  Future<List<ProductModel>> getProducts() async {
    final dbClient = await DBHelper.database();
    final List<Map<String, Object?>> queryResult =
        await dbClient.query('products');

    return queryResult.map((e) => ProductModel.fromMap(e)).toList();
  }
}
