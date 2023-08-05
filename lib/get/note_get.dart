import 'package:answer_login/database/controller/note_db_controller.dart';
import 'package:answer_login/modle/note.dart';
import 'package:answer_login/modle/process_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NotesGetController extends GetxController {//1
  RxBool loading = false.obs;
  RxList<Note> notes = <Note>[].obs;
  final NoteDbController _dbController = NoteDbController();
 static NotesGetController get to => Get.find();

  Future<ProcessResponse> create(Note note) async {
    int newRowId = await _dbController.create(note);
    if (newRowId != 0) {
      note.id = newRowId;
      notes.add(note);
      // update(['home_screen']);//2
    }
    return getResponse(newRowId != 0);
  }


  @override
  void onInit() {
    read();
     super.onInit();
  }

  void read() async {
    loading.value=true;
    notes.value = await _dbController.read();
    loading.value=false;
    // update(['home_screen']);
  }

  Future<ProcessResponse> updateNote(Note note) async {
    bool updated = await _dbController.update(note);
    if(updated) {
      int index = notes.indexWhere((element) => element.id == note.id);
      if(index != -1) {
        notes[index] = note;
        // update(['home_screen']);
      }
    }
    return getResponse(updated);
  }

  Future<ProcessResponse> delete(int index) async {
    bool deleted = await _dbController.delete(notes[index].id);
    if(deleted) {
      notes.removeAt(index);
      // update(['home_screen']);
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

