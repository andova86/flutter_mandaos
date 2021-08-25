import 'dart:async';
import 'dart:io';

import 'package:mandaos/models/buy.dart';
import 'package:mandaos/models/cart_product.dart';
import 'package:mandaos/models/config.dart';
import 'package:mandaos/models/product.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migration/sqflite_migration.dart';




 final _databaseName = "MyDatabase16.db";
 final _databaseVersion = 3;

 final table = 'my_table';
 final table_config = 'my_config';

 final columnId = '_id';
 final columnTitle = ProductFields.title;
 final columnPrice = ProductFields.price;
 final columnCuota = ProductFields.cuota;
 final columnUM = ProductFields.um;
 final columnImg = ProductFields.img;
 final columnKid = ProductFields.kid;
 final columnRecomended = ProductFields.recomended;

 final columnSplash = 'splash';
 final columnAdultos = 'adultos';
 final columnBebes = 'bebes';
 final columnNinos37 = 'ninos37';

 final columnDate = CartProductFields.date;

//static final columnIdProducto= CartProductFields.idProducto;
 final columnCant = BuyFields.cant;

List<String> initialScript =
[
  '''
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
  '''
          
           CREATE TABLE $table_config (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnSplash INTEGER NOT NULL,
            $columnAdultos INTEGER NOT NULL,
            $columnBebes INTEGER NOT NULL,
            $columnNinos37 INTEGER NOT NULL
           
            
          )
          ''',
  '''
          
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
  '''
          
           CREATE TABLE $tableBuy (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnDate TEXT NOT NULL,
            $columnCant INTEGER NOT NULL          
          )
          '''
];

List<String>  migrations = [
  '''
  alter table $table_config add column ewew integer default 0;
  '''
];

final config = MigrationConfig(initializationScript: initialScript, migrationScripts: migrations);






class DatabaseHelper {

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _open();
    return _database!;
  }

  Future<Database> _open() async {
    final databasesPath = await (getDatabasesPath() as FutureOr<String>);
    final path = join(databasesPath, _databaseName);


    return await openDatabaseWithMigration(path, config);
  }

  Future<Database> migrate() async {
    print('entro*************');
    final databasesPath = await (getDatabasesPath() as FutureOr<String>);
    final path = join(databasesPath, _databaseName);

    return await openDatabaseWithMigration(path, config);
  }
  // Helper methods

}
