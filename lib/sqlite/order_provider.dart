import 'package:flutterapptestpush/sqlite/cart.dart';
import 'package:flutterapptestpush/sqlite/order.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class OrderProvider {
  Database _database;
  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(join(await getDatabasesPath(), "orderd.db"),
          version: 2, onCreate: (Database db, int version) async {
            await db.execute(
                "CREATE TABLE orderlist(id INTEGER PRIMARY KEY autoincrement,userId TEXT,menuItemId TEXT,menuName TEXT,menuPrice TEXT,menuDescription TEXT,menuImageSource TEXT,menuQuantity TEXT)");
          });
    }
  }


  Future<List<Order>> getOrder() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('orderlist');
    return List.generate(maps.length, (i) {
      return Order(
        id: maps[i]['id'],
        userId: maps[i]['userId'],
        menuItemId: maps[i]['menuItemId'],
        menuName: maps[i]['menuName'],
        menuPrice: maps[i]['menuPrice'],
        menuDescription: maps[i]['menuDescription'],
        menuImageSource: maps[i]['menuImageSource'],
        menuQuantity: maps[i]['menuQuantity'],
      );
    });
  }

  Future<Order> getOrderSpecificRow(int id) async {
    var results = await _database.rawQuery('SELECT * FROM orderlist WHERE menuItemId = $id');

    if (results.length > 0) {
      return new Order.fromMap(results.first);
    }

    return null;
  }

  Future insertOrder(Order order2) async {
    await openDb();
    return _database.insert('orderlist', order2.toMap());
  }

  Future<int> updateOrder(Order order2) async {
    await openDb();
    return _database.update('orderlist', order2.toMap(),
        where: "id = ?", whereArgs: [order2.id]);
  }
  Future<void> updateMenuQuantity(int menuId,int menuQuantity) async {
    return await _database.rawUpdate(
        'UPDATE orderlist SET menuQuantity = ${menuQuantity} WHERE menuItemId = ${menuId}'
    );
  }

  Future<void> deleteOrder(int id) async {
    await openDb();
    _database.delete('orderlist', where: "id = ?", whereArgs: [id]);
  }

  Future<int> getCount() async {
    await openDb();
    var x =  await _database.rawQuery('SELECT COUNT (*) from orderlist');
    int count = Sqflite.firstIntValue(x);
    print("count ....${count}");
    return count;
  }

  Future<List> getmenuItemId() async {
    await openDb();
    var result = await _database.rawQuery('SELECT menuItemId,menuQuantity FROM orderlist');

    return result.toList();
  }

  Future<int> getMenuPrice() async {
    await openDb();
    var x =  await _database.rawQuery('SELECT SUM (menuPrice * menuQuantity) from orderlist');
    int menuPrice = Sqflite.firstIntValue(x);
    print("menuPrice ....${menuPrice}");
    return menuPrice;
  }


  Future<int> getOrderMenuItemCheck(String id) async {
    await openDb();
    var x =  await _database.rawQuery('SELECT * FROM orderlist WHERE menuItemId = $id');
    int count = Sqflite.firstIntValue(x);
    print("count ....${count}");
    return count;


  }

  Future<Order> getOrderMenuItemCheckQuantity(String id) async {
    await openDb();
    var response =  await _database.rawQuery('SELECT * FROM orderlist WHERE menuItemId = $id');
    return response.isNotEmpty ? Order.fromMap(response.first) : null;
  }

  Future<int> getupdateMenuQuantity(String menuId,String menuQuantity) async {
    return await _database.rawUpdate(
        'UPDATE orderlist SET menuQuantity = ${menuQuantity} WHERE menuItemId = ${menuId}'
    );
  }

  Future<void> updateTitle(int id,String quantity) async {
    print('id :  $id');
    print('kkkk :  $quantity');

    return await _database.rawUpdate(
        'UPDATE orderlist SET menuQuantity = ${quantity} WHERE id = ${id}'
    );
  }

}
