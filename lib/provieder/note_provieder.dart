import 'package:answer_login/database/controller/note_db_controller.dart';
import 'package:answer_login/modle/note.dart';
import 'package:answer_login/modle/process_response.dart';
import 'package:flutter/cupertino.dart';

// class NotesProvider extends ChangeNotifier {
//   List<Note> notes = <Note>[];
//   final NoteDbController _dbController = NoteDbController();
//
//   Future<ProcessResponse> create(Note note) async {
//     int newRowId = await _dbController.create(note);
//     if (newRowId != 0) {
//       note.id = newRowId;
//       notes.add(note);
//       notifyListeners();
//     }
//     return getResponse (newRowId != 0);
//   }
//   Future<ProcessResponse> update (Note note) async {
//     bool updated = await _dbController.update(note);
//     if (updated) {
//       int index = notes.indexWhere((element) => element.id == note.id);
//       if (index != -1) {
//         notes [index] = note;
//         notifyListeners();
//       }
//     }
//     return getResponse (updated);
//     // notifyListeners();
//
//   }
//   Future<ProcessResponse> delete (int index) async {
//     bool deleted = await
//     _dbController.delete (notes [index].id);
//     if(deleted) {
//       notes.removeAt (index);
//       notifyListeners();
//
//     }
//     return getResponse (deleted);}
//
//   void read() async {
//     notes = await _dbController.read();
//     notifyListeners();
//   }
//
//   ProcessResponse getResponse(bool success) {
//     return ProcessResponse(
//         message:
//             success ? 'Operation completed successfully' : 'Operatinn failed',
//         success: success);
//   }
// }
// import 'package:flutter/foundation.dart';
// import 'package:vp17_database_app/database/controllers/note_db_controller.dart';
// import 'package:vp17_database_app/models/note.dart';
// import 'package:vp17_database_app/models/process_response.dart';
//
class NotesProvider extends ChangeNotifier {
  List<Note> notes = <Note>[];
  final NoteDbController _dbController = NoteDbController();

  Future<ProcessResponse> create(Note note) async {
    int newRowId = await _dbController.create(note);
    if (newRowId != 0) {
      note.id = newRowId;
      notes.add(note);
      notifyListeners();
    }
    return getResponse(newRowId != 0);
  }

  void read() async {
    notes = await _dbController.read();
    notifyListeners();
  }

  Future<ProcessResponse> update(Note note) async {
    bool updated = await _dbController.update(note);
    if(updated) {
      int index = notes.indexWhere((element) => element.id == note.id);
      if(index != -1) {
        notes[index] = note;
        notifyListeners();
      }
    }
    return getResponse(updated);
  }

  Future<ProcessResponse> delete(int index) async {
    bool deleted = await _dbController.delete(notes[index].id);
    if(deleted) {
      notes.removeAt(index);
      notifyListeners();
    }
    return getResponse(deleted);
  }

  ProcessResponse getResponse(bool success) {
    return ProcessResponse(
        message:
            success ? 'Operation completed successfully' : 'Operation failed',
        success: success);
  }
}

