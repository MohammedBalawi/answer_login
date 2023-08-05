import 'package:answer_login/database/db_controller.dart';
import 'package:answer_login/modle/process_response.dart';
import 'package:answer_login/modle/user.dart';
import 'package:answer_login/shared_pref/shared.dart';
import 'package:sqflite/sqflite.dart';

class UserDbController {
  final Database _database = DbController().database;

  Future<ProcessResponse> login(
      {required String email, required String password}) async {
    List<Map<String, dynamic>> rowMap = await _database.rawQuery(
        'SELECT * FROM users WHERE email = ? AND password = ?',
        [email, password]);

    if (rowMap.isNotEmpty) {
      User user = User.fromMap(rowMap.first);
      await SharedPrefController().sava(user: user);
      return ProcessResponse(message: 'Logged in successfully', success: true);
    }
    return ProcessResponse(
        message: 'Loging failed, check credentials', success: false);
  }

  Future<ProcessResponse> register({required User user}) async {
    if (await _isUnique(email: user.email)) {
      int newRowId = await _database.rawInsert(
        'INSERT INTO users (name, email, password) VALUES (?, ?, ?)',
        [user.name, user.email, user.password],
      );
      return ProcessResponse(
          message: newRowId != 0
              ? 'Registered successfully'
              : 'Registration failed!',
          success: newRowId != 0);
    }
    return ProcessResponse(
      message: 'Email exists, use another!',
      success: false,
    );
  }

  Future<bool> _isUnique({required String email}) async {
    List<Map<String, dynamic>> rowMap = await _database
        .rawQuery('SELECT * FROM users WHERE email = ?', [email]);
    return rowMap.isEmpty;
  }
}
