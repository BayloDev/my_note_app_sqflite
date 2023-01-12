// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note_model.dart';

class DataBaseHelper {
  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();
  static const _dbName = 'notes.db';
  static const _dbVersion = 1;
  static const _tableName = 'notes';
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDatabase();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> initialDatabase() async {
    print('databae initialize');
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, _dbName);
    return await openDatabase(
      path,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      version: _dbVersion,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "$_tableName"(
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        dateTimeCreated TEXT NOT NULL,
        dateTimeEdited TEXT NOT NULL,
        isExpand BIT NOT NULL
      )
''');
  }

  Future<int> addNote(Note note) async {
    Database? mydb = await db;
    print('try to insert');

    return await mydb!.insert(_tableName, note.toMap()).then((value) {
      print('added succ');

      return value;
    });
  }

  Future<int> deleteNote(id) async {
    print(id);
    Database? mydb = await db;
    return await mydb!.rawDelete('DELETE FROM $_tableName WHERE id = "$id"');
  }

  Future<int> deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('ALTER TABLE notes ADD COLUMN columnTitle TEXT');
    print('OnUpgrade Successfully');
  }

  getNoteList() async {
    Database? mydb = await db;
    final List<Map<String, dynamic>> maps = await mydb!.query(_tableName);
    return List.generate(
      maps.length,
      (index) {
        return Note(
          id: maps[index]['id'],
          title: maps[index]['title'],
          content: maps[index]['content'],
          dateTimeEdited: maps[index]['dateTimeEdited'],
          dateTimeCreated: maps[index]['dateTimeCreated'],
          isExpand: 0,
        );
      },
    );
  }

  Future<int> updateData(Note note) async {
    Database? mydb = await instance.db;
    print(note.toMap());
    return mydb!.update(
      _tableName,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }
}
