import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbController{
  late Database _database;
  static DbController? _instance ;

  DbController._();
  factory DbController(){
    return _instance ??= DbController._();
  }

  Database get database => _database;
  Future<void> initDatabase()async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path =join(directory.path,'app_db_sql');
    _database = await openDatabase(
      path,
      version: 1,
      onOpen: (Database database){},
      onCreate: (Database database , int version)async{
        //TODO: Create database tables using SQL statement (users, notes)
        await database.execute('CREATE TABLE users ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'name TEXT NOT NULL,'
            'email TEXT NOT NULL,'
            'password TEXT NOT NULL'
            ')');
        await database.execute('CREATE TABLE notes ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'title TEXT NOT NULL,'
            'info TEXT NOT NULL,'
            'user_id INTEGER,'
            'FOREIGN KEY (user_id) references user(id)'
            ')');
        },
      onUpgrade: (Database database, int oldVersion, int newVersion){},
      onDowngrade: (Database database, int oldVersion, int newVersion){},


    );
  }

}