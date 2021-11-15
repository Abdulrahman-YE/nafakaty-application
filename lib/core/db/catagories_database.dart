import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nafakaty_app/core/models/catagory.dart';

class CatagoriesDatabase {
  CatagoriesDatabase._init();

  static final CatagoriesDatabase instance = CatagoriesDatabase._init();

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
    CREATE TABLE $tableCatagories (
      ${CatagoryFields.id} $idType,
      ${CatagoryFields.title} $textType,
      ${CatagoryFields.createdAt} $textType
    )
    ''');
  }

  //insert a row to the catagories table
  Future<Catagory> insert(Catagory catagory) async {
    //Reference to the database
    final db = await instance.database;

    //After inserting the row the insert function return the id of the row
    final id = await db.insert(tableCatagories, catagory.toJson());
    //Pass the id to the catagory model
    return catagory.copy(id: id);
  }

  //Read a catagory
  Future<Catagory> readCatagory(int id) async {
    //Reference to the databse
    final db = await instance.database;

    //This is a parameterized query
    final map = await db.query(tableCatagories,
        columns: CatagoryFields.values,
        where: '${CatagoryFields.id} = ?',
        whereArgs: [id]);

    //Cheack if the request has successed
    if (map.isNotEmpty) {
      return Catagory.fromJson(map.first);
    } else {
      throw Exception('The catagory with $id does not exists');
    }
  }

  //Read all catagories
  Future<List<Catagory>> readCatagories() async {
    //Reference to the databse
    final db = await instance.database;

    //This is a parameterized query
    final result = await db.query(tableCatagories);

    //Convert the result from a list of Map objects to a list of Catagory objects
    return result.map((e) => Catagory.fromJson(e)).toList();
  }

  //Update 1 catagory by id
  Future<int> updateCatagory(Catagory catagory) async {
    final db = await instance.database;

    return db.update(tableCatagories, catagory.toJson(),
        where: '${CatagoryFields.id} = ?', whereArgs: [catagory.id]);
  }

  //Delete one catagory by id
  Future<int> deleteCatagory(int id) async {
    final db = await instance.database;

    return db.delete(tableCatagories,
        where: '${CatagoryFields.id} = ? ', whereArgs: [id]);
  }

  //Close the database
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
