import 'package:flutterapptestpush/sqlite/cart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CartProvider {

  Database _database;
  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(join(await getDatabasesPath(), "ca.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE cart(id INTEGER PRIMARY KEY autoincrement,userId TEXT,menuItemId TEXT,menuName TEXT,menuPrice TEXT,menuDescription TEXT,menuImageSource TEXT)");
      });
    }
  }

  Future<List<Cart>> getCart() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('cart');
    return List.generate(maps.length, (i) {
      return Cart(
          id: maps[i]['id'],
          userId: maps[i]['userId'],
          menuItemId: maps[i]['menuItemId'],
          menuName: maps[i]['menuName'],
          menuPrice: maps[i]['menuPrice'],
          menuDescription: maps[i]['menuDescription'],
          menuImageSource: maps[i]['menuImageSource'],
      );
    });
  }

  Future insertCart(Cart cart) async {
    await openDb();
    return _database.insert('cart', cart.toMap());
  }

  Future<int> updateCart(Cart cart) async {
    await openDb();
    return _database.update('cart', cart.toMap(),
        where: "id = ?", whereArgs: [cart.id]);
  }

  Future<void> deleteCart(int id) async {
    await openDb();
    _database.delete('cart', where: "id = ?", whereArgs: [id]);
  }

 Future<int> getCount() async {
    await openDb();
    var x =  await _database.rawQuery('SELECT COUNT (*) from cart');
    int count = Sqflite.firstIntValue(x);
    return count;
  }

}
