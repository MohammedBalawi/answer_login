import 'dart:ui';

import 'package:answer_login/database/db_operations.dart';
import 'package:answer_login/modle/note.dart';
import 'package:answer_login/shared_pref/shared.dart';
import 'package:sqflite/sqlite_api.dart';
// import 'package:untitled7/database/db_operations.dart';
// import 'package:untitled7/models/note.dart';
// import 'package:untitled7/pref/shared_pref_controller.dart';


class NoteDbController extends DbOperations<Note> {
  int userId = SharedPrefController().getValueFor<int>(Key: PreKey.id.name)!;

  @override
  Future<int> create(Note model) async {
    // int newRowId = await database.rawInsert(
    //     'INSERT INTO notes (title, info, user_id) VALUES (?, ?, ?)',
    //     [model.title, model.info, model.userId]);

    return await database.insert(Note.tableName, model.toMap());
  }

  @override
  Future<bool> delete(int id) async {
    // int countOfDeletedRows = await database.rawDelete('DELETE FROM notes WHERE id = ? AND user_id = ?', [id, userId]);
    int countOfDeletedRows = await database.delete(Note.tableName,
        where: 'id = ? AND user_id = ?', whereArgs: [id, userId]);
    return countOfDeletedRows == 1;
  }

  @override
  Future<List<Note>> read() async {
    // List<Map<String, dynamic>> rowsMap = await database.rawQuery('SELECT * FROM notes WHERE user_id = ?',[userId]);
    List<Map<String, dynamic>> rowsMap = await database
        .query(Note.tableName, where: 'user_id = ?', whereArgs: [userId]);
    return rowsMap.map((rowMap) => Note.fromMap(rowMap)).toList();
  }

  @override
  Future<Note?> show(int id) async {
    // List<Map<String, dynamic>> rowsMap = await database.rawQuery('SELECT * FROM notes WHERE id = ? AND user_id = ?',[id, userId]);
    List<Map<String, dynamic>> rowsMap = await database.query(Note.tableName,
        where: 'id = ? AND user_id = ?', whereArgs: [id, userId]);
    return rowsMap.isNotEmpty ? Note.fromMap(rowsMap.first) : null;
  }

  @override
  Future<bool> update(Note model) async {
    // int countOfUpdatedRows = await database.rawUpdate('UPDATE notes SET title = ?, info = ? WHERE id = ? AND user_id = ?',[model.title, model.info, model.id, userId]);
    int countOfUpdatedRows = await database.update(
        Note.tableName, model.toMap(),
        where: 'id = ? AND user_id = ?', whereArgs: [model.id, userId]);
    return countOfUpdatedRows == 1;
  }
}
