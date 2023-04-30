import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../models/shopping_cart.dart';

class SQLiteService {
  Future<Database> initializeDB() async {
    String dbPath = await getDatabasesPath();

    return openDatabase(join(dbPath, 'market.db'),
        onCreate: (database, version) async {
      await database.execute(
        "create table ShoppingCart(productId integer primary key , productName text , productQuantity text , productPrice float,productPath text)",
      );
    }, version: 1);
  }
  initDatabase() async {
    ////Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //String path = join(documentsDirectory.path,  'market.db');

    sqfliteFfiInit();

    var databaseFactory = databaseFactoryFfi;
    var db = await databaseFactory.openDatabase(inMemoryDatabasePath,
        options: OpenDatabaseOptions(
            version: 1,
            onCreate: (Database db, int version) async {
              await db.execute(
                "create table ShoppingCart(productId integer primary key , productName text , productQuantity text , productPrice float,productPath text)",
              );
              await db.execute(
                "create table Reservation(reservationId integer primary key autoincrement , reserveDate datetime , rentoutDate datetime , returnDate datetime,clientName text)",
              );
              await db.execute(
                "create table ReservationDetails(detailId integer primary key autoincrement ,reservationId integer, productId integer , productName text , productQuantity text , productPrice float)",
              );
            }
    ));
    //await db.execute("create table ShoppingCart(productId integer primary key , productName text , productQuantity text , productPrice float,productPath text)",);
    return db;
    /*Database db = await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute("create table ShoppingCart(productId integer primary key , productName text , productQuantity text , productPrice float,productPath text)",
          );
          print('TABLE CREATED');
        },
      ),
    );
    print('DATABASE CREATED');

    return db;*/
  }
  Future<int> addItem(ShoppingCart cart) async {
    int result = 0;
    final Database db = await initDatabase();
    final id = db.insert('ShoppingCart', cart.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<int> updateQuantity(ShoppingCart cart) async {
    int result = 0;
    final Database db = await initDatabase();
    final id = db.update('ShoppingCart', cart.toMap(),where: "productId = ?",whereArgs: [cart.productId],
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<ShoppingCart>> getItems() async {
    final db = await initDatabase();
    final List<Map<String, Object?>> queryResult =
        await db.query("ShoppingCart");
    return queryResult.map((e) => ShoppingCart.fromMap(e)).toList();
  }
  Future<void> deleteItem(int productId) async{
    final db = await initDatabase();
    final id = await db.delete("ShoppingCart",where: "productId = ?",whereArgs: [productId]);
  }
}
