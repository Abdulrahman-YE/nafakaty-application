import 'dart:async';

import 'package:nafakaty_app/core/models/amount.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nafakaty_app/core/models/category.dart';

class AmountDatabase {
  /// Insert a row to the amounts table in the database
  static Future<Amount> insertAmount(Amount amount) async {
    //Reference to the database
    final db = await DatabaseConnection.database;

    //After inserting the row the insert function return the id of the row
    final id = await db.insert(amountTable, amount.toJson());
    //Pass the id to the catagory model
    return amount.copy(id: id);
  }

  /// Get a single row from the amounts table
  ///
  /// Throws an [Exception] if the [id] of the row does not exist.
  /// Otherwise, returns an new instanse of [Amount]
  static Future<Amount> readAmount(int id) async {
    final db = await DatabaseConnection.database;

    final map = await db.query(amountTable,
        columns: AmountFields.values,
        where: '${AmountFields.id} = ?',
        whereArgs: [id]);

    if (map.isNotEmpty) {
      return Amount.fromJson(map.first);
    } else {
      throw Exception(
          'The amount with $id does not exist in the table $amountTable}.');
    }
  }

  /// Get [List]  of [Amount ]from [amountTable] table based on [AmountFields.categoryId] Column
  static Future<List<Amount>> readAmounts(int categoryId) async {
    final db = await DatabaseConnection.database;

    final result = await db.query(amountTable,
        columns: AmountFields.values,
        where: '${AmountFields.categoryId} = ?',
        whereArgs: [categoryId]);

    final amounts = result.map((json) => Amount.fromJson(json)).toList();
    return amounts;
  }

  /// Update an [Amount] row in the database
  static Future<int> updateAmount(Amount amount) async {
    final db = await DatabaseConnection.database;

    return db.update(amountTable, amount.toJson(),
        where: '${AmountFields.id} = ?', whereArgs: [amount.id]);
  }

  /// Delete an [Amount] from the database
  static Future<int> deleteAmount(int id) async {
    final db = await DatabaseConnection.database;
    return db
        .delete(amountTable, where: '${AmountFields.id} = ?', whereArgs: [id]);
  }
}

class DatabaseConnection {
  DatabaseConnection._init();

  static final DatabaseConnection instance = DatabaseConnection._init();

  static Database? _database;

  //Create a database if it does not already exists
  static Future<Database> get database async {
    //_database exist
    if (_database != null) return _database!;

    //create _database
    _database = await _initDB('nafakaty.db');

    return _database!;
  }

  static Future<Database> _initDB(String dbName) async {
    //get our database path
    final dbPath = await getDatabasesPath();
    //Create path Object
    final path = join(dbPath, dbName);

    //Open the database from the file storage
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: _configureDB,
    );
  }

  static Future _configureDB(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  //Create tables in the database. It will only create tables if the database does not exists already
  static Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const doubleType = 'REAL NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';
    const textTypeNullable = 'TEXT';
    const foreignConstaraint =
        'FOREIGN KEY(${AmountFields.categoryId}) REFERENCES $categoriesTable(${CategoryFields.id}) ON DELETE CASCADE ON UPDATE CASCADE';

    await db.execute('''
    CREATE TABLE $categoriesTable (
      ${CategoryFields.id} $idType,
      ${CategoryFields.title} $textType,
      ${CategoryFields.createdAt} $textType
    )
    ''');

    await db.execute('''
    CREATE TABLE $amountTable (
      ${AmountFields.id} $idType,
      ${AmountFields.value} $doubleType,
      ${AmountFields.processType} $intType,
      ${AmountFields.target} $textType,
      ${AmountFields.note} $textTypeNullable,
      ${AmountFields.categoryId} $intType,
      ${AmountFields.createdAt} $textType,
      $foreignConstaraint
    )
    ''');
  }

  //Close the database
  static Future close() async {
    final db = await database;
    db.close();
  }
}

class CategoriesDatabase {
  /// Insert a row to the catagories table in the database
  static Future<Category> insertCategory(Category category) async {
    //Reference to the database
    final db = await DatabaseConnection.database;

    //After inserting the row the insert function return the id of the row
    final id = await db.insert(categoriesTable, category.toJson());
    //Pass the id to the catagory model
    return category.copy(id: id);
  }

  //Read a catagory
  static Future<Category> readCategory(int id) async {
    //Reference to the databse
    final db = await DatabaseConnection.database;

    //This is a parameterized query
    final map = await db.query(categoriesTable,
        columns: CategoryFields.values,
        where: '${CategoryFields.id} = ?',
        whereArgs: [id]);

    //Cheack if the request has successed
    if (map.isNotEmpty) {
      return Category.fromJson(map.first);
    } else {
      throw Exception('The category with $id does not exists');
    }
  }

  //Read all catagories
  static Future<List<Category>> readCatagories() async {
    //Reference to the databse
    final db = await DatabaseConnection.database;
    final orderBy = '${CategoryFields.createdAt} DESC';
    //This is a parameterized query
    final result = await db.query(categoriesTable, orderBy: orderBy);

    //Convert the result from a list of Map objects to a list of Catagory objects
    return result.map((json) => Category.fromJson(json)).toList();
  }

  //Update 1 catagory by id
  static Future<int> updateCatagory(Category category) async {
    final db = await DatabaseConnection.database;

    return db.update(categoriesTable, category.toJson(),
        where: '${CategoryFields.id} = ?', whereArgs: [category.id]);
  }

  //Delete one catagory by id
  static Future<int> deleteCatagory(int id) async {
    final db = await DatabaseConnection.database;

    return db.delete(categoriesTable,
        where: '${CategoryFields.id} = ? ', whereArgs: [id]);
  }
}
