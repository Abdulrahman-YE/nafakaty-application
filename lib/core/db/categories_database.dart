import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nafakaty_app/core/models/category.dart';

class CategoriesDatabase {
  CategoriesDatabase._init();

  static final CategoriesDatabase instance = CategoriesDatabase._init();

  static Database? _database;

  //Create a database if it does not already exists
  Future<Database> get database async {
    //_database exist
    if (_database != null) return _database!;

    //create _database
    _database = await _initDB('nafakaty.db');

    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    //get our database path
    final dbPath = await getDatabasesPath();
    //Create path Object
    final path = join(dbPath, dbName);

    //Open the database from the file storage
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  //Create tables in the database. It will only create tables if the database does not exists already
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    await db.execute('''
    CREATE TABLE $tableCategories (
      ${CategoryFields.id} $idType,
      ${CategoryFields.title} $textType,
      ${CategoryFields.createdAt} $textType
    )
    ''');
  }

  //insert a row to the catagories table
  Future<Category> insert(Category category) async {
    //Reference to the database
    final db = await instance.database;

    //After inserting the row the insert function return the id of the row
    final id = await db.insert(tableCategories, category.toJson());
    //Pass the id to the catagory model
    return category.copy(id: id);
  }

  //Read a catagory
  Future<Category> readCategory(int id) async {
    //Reference to the databse
    final db = await instance.database;

    //This is a parameterized query
    final map = await db.query(tableCategories,
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
  Future<List<Category>> readCatagories() async {
    //Reference to the databse
    final db = await instance.database;

    //This is a parameterized query
    final result = await db.query(tableCategories);

    //Convert the result from a list of Map objects to a list of Catagory objects
    return result.map((json) => Category.fromJson(json)).toList();
  }

  //Update 1 catagory by id
  Future<int> updateCatagory(Category category) async {
    final db = await instance.database;

    return db.update(tableCategories, category.toJson(),
        where: '${CategoryFields.id} = ?', whereArgs: [category.id]);
  }

  //Delete one catagory by id
  Future<int> deleteCatagory(int id) async {
    final db = await instance.database;

    return db.delete(tableCategories,
        where: '${CategoryFields.id} = ? ', whereArgs: [id]);
  }

  //Close the database
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
