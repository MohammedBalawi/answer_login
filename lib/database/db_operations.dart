import 'package:answer_login/database/db_controller.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class DbOperations<Model> {

  final Database database = DbController().database;

  Future<int> create(Model model);

  Future<List<Model>> read();

  Future<Model?> show(int id);

  Future<bool> update(Model model);

  Future<bool> delete(int id);
}
