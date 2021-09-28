// @dart=2.9
// I use a map for more readability, the key represents the version of the db
import 'package:mandaos/generated/assets.dart';
import 'package:mandaos/modules/cart/models/cart_product.dart';
import 'package:mandaos/modules/home/models/config.dart';
import 'package:mandaos/modules/cart/models/buy.dart';
import 'package:mandaos/modules/products/models/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

Map<int, String> migrationScripts = {
  1: '''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTitle TEXT NOT NULL,
            $columnPrice REAL NOT NULL,
            $columnCuota REAL NOT NULL,
            $columnUM TEXT NOT NULL,
            $columnImg TEXT NOT NULL,
            $columnKid BOOLEAN NOT NULL,
            $columnRecomended BOOLEAN NOT NULL
            
          )
          ''',
  2: '''
          
           CREATE TABLE $tableCartProducts (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnDate TEXT NOT NULL,
             $columnTitle TEXT NOT NULL,
            $columnPrice REAL NOT NULL,
            $columnCuota REAL NOT NULL,
            $columnUM TEXT NOT NULL,
            $columnImg TEXT NOT NULL,
            $columnCant INTEGER NOT NULL           
          )
          ''',
  3: '''
          
           CREATE TABLE $table_config (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnSplash INTEGER NOT NULL,
            $columnAdultos INTEGER NOT NULL,
            $columnBebes INTEGER NOT NULL,
            $columnNinos37 INTEGER NOT NULL
           
            
          )
          ''',
};

class Script {
  int number;
  String execute;

  Script(this.number, this.execute);
}

List<Script> list = [
  Script(1, '''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTitle TEXT NOT NULL,
            $columnPrice REAL NOT NULL,
            $columnCuota REAL NOT NULL,
            $columnUM TEXT NOT NULL,
            $columnImg TEXT NOT NULL,
            $columnKid BOOLEAN NOT NULL,
            $columnRecomended BOOLEAN NOT NULL
            
          )
          '''),
  Script(2, '''
          
           CREATE TABLE $tableCartProducts (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnDate TEXT NOT NULL,
             $columnTitle TEXT NOT NULL,
            $columnPrice REAL NOT NULL,
            $columnCuota REAL NOT NULL,
            $columnUM TEXT NOT NULL,
            $columnImg TEXT NOT NULL,
            $columnCant INTEGER NOT NULL           
          )
          '''),
  Script(3, '''
          
           CREATE TABLE $table_config (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnSplash INTEGER NOT NULL,
            $columnAdultos INTEGER NOT NULL,
            $columnBebes INTEGER NOT NULL,
            $columnNinos37 INTEGER NOT NULL
           
            
          )
          '''),
  //Script(4, 'ALTER TABLE $table_config ADD pb TEXT '),
  //Script(5, 'ALTER TABLE $table ADD pb TEXT ')
];

Future initDatabase() async {
  // cantidad de migraciones para definir la version de la base de datos
  int cantMigraciones = list.length;
  var db = await openDatabase(
    join(await getDatabasesPath(), "database.db"),
    version: cantMigraciones,
    // Si la base de dato no existe, ejecuta el metodo OnCreate con las migraciones en migrationScripts
    onCreate: (db, version) async {
      print(' Primera version es la $version');
      print(' La cantidad es  ${list.length}');
      for (int i = 0; i < list.length; i++) {
        await db.execute(list[i].execute);
      }
    },

    /// Si la base de dato existe pero la version es diferente a la actual
    /// Ejecuta la funcion onUpgrade con aquellos script mayores a la version vieja
    onUpgrade: (db, oldVersion, newVersion) async {
      print(' Vieja version $oldVersion');
      print(' Nueva version $newVersion');
      for (int i = oldVersion; i < newVersion; i++) {
        await db.execute(list[i].execute);
      }
    },
  );
  return db;
}

var db_helper = initDatabase();
// Inserts a row in the database where each key in the Map is a column name
// and the value is the column value. The return value is the id of the
// inserted row.
Future<int> insert(Map<String, dynamic> row, String pTable) async {
  Database db = await db_helper;
  return await db.insert(
    pTable,
    row,
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// All of the rows are returned as a list of maps, where each map is
// a key-value list of columns.
Future<List<Map<String, dynamic>>> queryAllRows(String pTable) async {
  Database db = await db_helper;

  //print(db.);
  return await db.query(pTable);
}

// All of the methods (insert, query, update, delete) can also be done using
// raw SQL commands. This method uses a raw query to give the row count.
Future<int> queryRowCount() async {
  Database db = await db_helper;
  return Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM $table'));
}

Future<int> queryRowCountConfig() async {
  Database db = await db_helper;
  return Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM $table_config'));
}

// We are assuming here that the id column in the map is set. The other
// column values will be used to update the row.
Future<int> update(Map<String, dynamic> row, String pTable) async {
  Database db = await db_helper;
  int id = row[columnId];
  return await db.update(pTable, row, where: '$columnId = ?', whereArgs: [id]);
}

Future<Product> get(int id, String pTable) async {
  Database db = await db_helper;

  var result = await db.query(pTable, where: '$columnId = ?', whereArgs: [id]);
  return result.isNotEmpty ? Product.fromJson(result.first) : null;
}

Future<Product> getS(String name, String pTable) async {
  Database db = await db_helper;

  var result = await db.query(pTable, where: '$columnTitle = ?', whereArgs: [name]);
  return result.isNotEmpty ? Product.fromJson(result.first) : null;
}

Future<Buy> getBuybyDate(String date, String pTable) async {
  Database db = await db_helper;

  var result =
      await db.query(pTable, where: '$columnDate = ', whereArgs: [date]);
  return result.isNotEmpty ? Buy.fromJson(result.first) : null;
}

Future<List<Map<String, dynamic>>> getBuybyMonth(
    String dateFirst, String dateLast, String pTable) async {
  Database db = await db_helper;

  var result = await db.query(pTable,
      where: '$columnDate >= $dateFirst and  $columnDate >= $dateLast ',
      whereArgs: [dateFirst, dateLast]);
  return result;
}

Future<List<Map<String, dynamic>>> getBuybyDates(
    String dateFirst, String dateLast, String pTable) async {
  Database db = await db_helper;

  var result = await db.query(pTable,
      where: '$columnDate <= ? AND  $columnDate >= ?',
      whereArgs: [dateLast, dateFirst]);
  print(result);
  return result;
}

// Deletes the row specified by the id. The number of affected rows is
// returned. This should be 1 as long as the row exists.
Future<int> delete(int id, String pTable) async {
  Database db = await db_helper;
  return await db.delete(pTable, where: '$columnId = ?', whereArgs: [id]);
}

Future<List<Product>> listP() async {
  //Database db = await db_helper;
  final allRows = await queryAllRows(table);

  //print('query all rowsssssssss:');

  List<Product> list = [];

  for (int i = 0; i < allRows.length; i++) {
    print(allRows[i]);
    Product p = Product.fromJson(allRows[i]);
    p.id = allRows[i][ProductFields.id] as int;
    // print(p.toJson());
    list.add(p);
    //print(p.id);
  }

  return list;
}

Future<List<Product>> listRecomended() async {
  //Database db = await db_helper;
  final allRows = await queryAllRows(table);

  // print('query all rowsssssssss:');
  //print(allRows);

  List<Product> list = [];

  for (int i = 0; i < allRows.length; i++) {
    // print("Recomendado " + allRows[i][columnRecomended].toString());
    if (allRows[i][columnRecomended] == 1) {
      // print('Entro');
      Product p = Product.fromJson(allRows[i]);
      p.id = allRows[i]['_id'] as int;
      list.add(p);
    }

    //print(p.id);
  }

  return list;
}

Future<List<Config>> listConfig() async {
  //Database db = await db_helper;
  final allRows = await queryAllRows(table_config);

  print('query all rowsssssssss:');
  // print(allRows.);

  List<Config> list = [];

  for (int i = 0; i < allRows.length; i++) {
    print(allRows[i]);
    Config conf = Config.fromJson(allRows[i]);

    conf.id = allRows[i]['_id'] as int;

    list.add(conf);
    print(list[i].id);
  }

  return allRows.map((json) => Config.fromJson(json)).toList();
}

Future<List<Buy>> listBuy() async {
  //Database db = await db_helper;
  final allRows = await queryAllRows(tableBuy);

  print('query all rowsssssssss:');
  //insert(row, pTable)

  List<Buy> list = [];

  for (int i = 0; i < allRows.length; i++) {
    print(allRows[i]);
    Buy b = Buy.fromJson(allRows[i]);
    print(b.toJson());
    b.id = allRows[i]['_id'] as int;

    list.add(b);
    print(b.toJson());
  }

  return allRows.map((json) => Buy.fromJson(json)).toList();
}

Future<List<CartProduct>> listCartProductBuy(String date) async {
  //Database db = await db_helper;
  final allRows = await queryAllRows(tableCartProducts);

  //print('query all rowsssssssss:');
  // print(allRows);
  //print(allRows.length);
  List<CartProduct> list = [];

  for (int i = 0; i < allRows.length; i++) {
    CartProduct cart = CartProduct.fromJson(allRows[i]);
    if (cart.date == date) {
      cart.id = allRows[i]['_id'] as int;
      print(cart.toJson());
      list.add(cart);
    }

    // print(allRows[i]['_id']);

    //print(b.toJson());
  }

  return list;
}

Future<int> cantBuysInYear(int year) async {
  //Database db = await db_helper;
  String first = '01/01/' + DateTime.now().year.toString();
  String last = '31/12/' + DateTime.now().year.toString();

  final allRows = await getBuybyDates(first, last, tableCartProducts);

  double result = 0;

  allRows.forEach((element) {
    var item = CartProduct.fromJson(element);

    double value = item.price * item.cant * item.cuota;
    result = result + value;
  });

  return result.toInt();
}

Future<int> cantDatesBuysInYear(int year) async {
  //Database db = await db_helper;
  String first = '01/01/' + DateTime.now().year.toString();
  String last = '31/12/' + DateTime.now().year.toString();
  List<String> dates = [];

  final allRows = await getBuybyDates(first, last, tableCartProducts);
  // print('******** $allRows');
  allRows.forEach((element) {
    var item = CartProduct.fromJson(element);

    if (dates.contains(item.date) == false) {
      dates.add(item.date);
    }
  });

  return dates.length;
}

Future<int> cantProds() async {
  return listP().then((value) => value.length);
}

Future<int> cantConsumers() async {
  double cant = 0;
  final allRows = await listConfig();

  cant = cant +
      allRows.first.adultos.toDouble() +
      allRows.first.ninos37.toDouble() +
      allRows.first.bebes.toDouble();

  print('**CANT** $cant');

  return cant.toInt();
}

void UpdateF(int id) {
  Product prod_fi;
  if (get(id, table).then((value) {
        // var data = get(idfi, tableProducts);
        prod_fi = value;
        prod_fi.id = id;
        if (prod_fi.cuota == 16) {
          prod_fi.cuota = 10;
          update(prod_fi.toJson(), table);
          print('actualizo');
          print(prod_fi.toJson());
        }
      }) !=
      null) {}

  // var prod_fc = get(idfc, tableProducts);
}

void UpdateL(int id) {
  Product prod_fi;
  if (get(id, table).then((value) {
        // var data = get(idfi, tableProducts);
        prod_fi = value;
        prod_fi.id = id;
        if (prod_fi.price == 2.5) {
          prod_fi.price = 2.0;
          update(prod_fi.toJson(), table);
          print('actualizo');
          print(prod_fi.toJson());
        }
      }) !=
      null) {}

  // var prod_fc = get(idfc, tableProducts);
}

void UpdateP(int id) {
  Product prod_fi;
  if (get(id, table).then((value) {
        // var data = get(idfi, tableProducts);
        prod_fi = value;
        prod_fi.id = id;
        if (prod_fi.price == 0.7) {
          prod_fi.price = 1.25;
          prod_fi.cuota = 11;
          prod_fi.um = 'oz';
          update(prod_fi.toJson(), table);
          print('actualizo');
          print(prod_fi.toJson());
        }
      }) !=
      null) {}

  // var prod_fc = get(idfc, tableProducts);
}

void UpdatePi(int id) {
  Product prod_fi;
  if (get(id, table).then((value) {
        // var data = get(idfi, tableProducts);
        prod_fi = value;
        prod_fi.id = id;
        if (prod_fi.price == 0.7) {
          prod_fi.price = 15;
          prod_fi.cuota = 0.5;
          update(prod_fi.toJson(), table);
          print('actualizo');
          print(prod_fi.toJson());
        }
      }) !=
      null) {}

  // var prod_fc = get(idfc, tableProducts);
}


void AddCig() {
  Product prod_fi = Product(title: 'Cigarros', price: 10, cuota: 8, um: 'caja', img: Assets.imgCriolloPopular, recomended: 0, kid: 0);

  getS(prod_fi.title, table).then((value) {
    if(value == null)
      {

        insert(prod_fi.toJson(), table);
      }
  });

  // var prod_fc = get(idfc, tableProducts);
}
