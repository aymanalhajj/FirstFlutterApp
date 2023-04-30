import 'package:first_flutter_app/data/models/reservation_item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../models/reservation.dart';
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
                "create table Reservation(reservationId integer primary key autoincrement , reserveDate int , rentoutDate int , returnDate int,clientName text)",
              );
              await db.execute(
                "create table ReservationItem(itemId integer primary key autoincrement ,reservationId integer, productId integer , productName text , productQuantity text , productPrice text)",
              );
              await db.execute(
                "create table Rentout(rentoutId integer primary key autoincrement ,reservationId integer, reserveDate int , rentoutDate int , returnDate int,clientName text)",
              );
              await db.execute(
                "create table RentoutItem(itemId integer primary key autoincrement ,rentoutId integer, productId integer , productName text , productQuantity text , productPrice text)",
              );
            }));
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

  Future<List<Reservation>> getAllReservations() async {
    final db = await initDatabase();
    final List<Map<String, Object?>> reservationResult =
        await db.query("Reservation");

    //return reservationResult.map((e) => Reservation.fromMap(e)).toList();
    return reservationResult.map((e){
      Reservation res = Reservation.fromMap(e);
      Future<List<Map<String, Object?>>> result = db.query("ReservationItem",where: " reservationId = ?", whereArgs: [res.reservationId]);
      result.then((value) => res.items = value.map((item) => ReservationItem.fromMap(item)).toList());

      return res;
    }).toList();
  }

  Future<List<Reservation>> getReservation(int reservationId) async {
    final db = await initDatabase();
    final List<Map<String, Object?>> reservationResult = await db.query(
        "Reservation",
        where: " reservationId = ?",
        whereArgsg: [reservationId]);

    final List<Map<String, Object?>> result = await db.query("ReservationItem",
        where: " reservationId = ?", whereArgsg: [reservationId]);
    return reservationResult.map((e) {
      Reservation res = Reservation.fromMap(e);
      res.items = result.map((item) => ReservationItem.fromMap(item)).toList();
      return res;
    }).toList();
  }

  Future<int> addReservation(Reservation reservation) async {
    final db = await initDatabase();
    final result = await db.insert('Reservation', reservation.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print(result.toString());
    if (reservation.items != null) {
      for (var element in reservation.items!) {
        element.reservationId = int.parse(result.toString());
        db.insert('ReservationItem', element.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
    return result;
  }

  Future<List<ShoppingCart>> getItems() async {
    final db = await initDatabase();
    final List<Map<String, Object?>> result = await db.query("ShoppingCart");
    return result.map((e) => ShoppingCart.fromMap(e)).toList();
  }

  Future<int> addItem(ShoppingCart cart) async {
    final Database db = await initDatabase();
    final result = db.insert('ShoppingCart', cart.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<int> updateQuantity(ShoppingCart cart) async {
    final Database db = await initDatabase();
    final result = db.update('ShoppingCart', cart.toMap(),
        where: "productId = ?",
        whereArgs: [cart.productId],
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<void> deleteItem(int productId) async {
    final db = await initDatabase();
    await db
        .delete("ShoppingCart", where: "productId = ?", whereArgs: [productId]);
  }
}
