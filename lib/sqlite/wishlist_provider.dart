import 'package:flutterapptestpush/sqlite/wishlist.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class WishlistProvider {
  Database _database;
  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(join(await getDatabasesPath(), "wish.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE wishlist(id INTEGER PRIMARY KEY autoincrement,userId TEXT,menuItemId TEXT,menuName TEXT,menuPrice TEXT,menuDescription TEXT,menuImageSource TEXT)");
      });
    }
  }

  Future<List<Wishlist>> getWishlistList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('wishlist');
    return List.generate(maps.length, (i) {
      return Wishlist(
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

  Future insertWishlist(Wishlist wishlist) async {
    await openDb();
    return _database.insert('wishlist', wishlist.toMap());
  }

  Future<int> updateWishlist(Wishlist wishlist) async {
    await openDb();
    return _database.update('wishlist', wishlist.toMap(),
        where: "id = ?", whereArgs: [wishlist.id]);
  }

  Future<void> deleteWishlist(int id) async {
    await openDb();
    _database.delete('wishlist', where: "id = ?", whereArgs: [id]);
  }

  Future<int> getCount() async {
    await openDb();
    var x =  await _database.rawQuery('SELECT COUNT (*) from wishlist');
    int count = Sqflite.firstIntValue(x);
    return count;
  }
}
