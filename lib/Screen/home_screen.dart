import 'package:answer_login/Screen/note_screen.dart';
import 'package:answer_login/context-extenssion.dart';
import 'package:answer_login/get/note_get.dart';
import 'package:answer_login/modle/note.dart';
import 'package:answer_login/provieder/note_provieder.dart';
import 'package:answer_login/shared_pref/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../modle/process_response.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

 final  NotesGetController controller = Get.put(NotesGetController());

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text(
          'Home',
          style: GoogleFonts.aBeeZee(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.note_add_outlined,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () async {
                _showM(context);
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.black,
              )),
        ],
      ),

    body: Obx((){
      if (controller.loading.isTrue) {
        return Center(child: CircularProgressIndicator(),);
      } else if(controller.notes.isNotEmpty) {
        return ListView.builder(
          itemCount: controller.notes.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NoteScreen(note: controller.notes[index]),
                    ));
              },
              leading: Icon(Icons.note),
              title: Text(controller.notes[index].title),
              subtitle: Text(controller.notes[index].info),
              trailing: IconButton(
                onPressed: () {
                  _deleteNote(context ,index);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            );
          },
        );
      }
      else {
        return Center(
          child: Text(
            'No Data',
            style: GoogleFonts.aBeeZee(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        );}
    }),

    //   body: GetX<NotesGetController>(//3
    //     // id: 'home_screen',
    //     init: NotesGetController(),
    //       global: true,
    //       builder: (NotesGetController controller) {
    //         if (controller.loading.isTrue) {
    // return Center(child: CircularProgressIndicator(),);
    // } else if(controller.notes.isNotEmpty) {
    //   return ListView.builder(
    //             itemCount: controller.notes.length,
    //             itemBuilder: (context, index) {
    //               return ListTile(
    //                 onTap: () {
    //                   Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) =>
    //                             NoteScreen(note: controller.notes[index]),
    //                       ));
    //                 },
    //                 leading: Icon(Icons.note),
    //                 title: Text(controller.notes[index].title),
    //                 subtitle: Text(controller.notes[index].info),
    //                 trailing: IconButton(
    //                   onPressed: () {
    //                     _deleteNote(context ,index);
    //                   },
    //                   icon: Icon(
    //                     Icons.delete,
    //                     color: Colors.red,
    //                   ),
    //                 ),
    //               );
    //             },
    //           );
    // }
    //          else {
    //           return Center(
    //             child: Text(
    //               'No Data',
    //               style: GoogleFonts.aBeeZee(
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 25,
    //               ),
    //             ),
    //           );}
    //
    //       }),
    );
  }

  void _deleteNote(BuildContext context ,int index) async {
    NotesGetController controller=Get.find();
    ProcessResponse processResponse =
    await controller.delete(index);
    context.showMessage(
        message: processResponse.message, error: !processResponse.success);
  }

  void  _showM(BuildContext context) async {
    bool result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:  Text(context.localizations.logout_dialog_title),
            content: Text(context.localizations.logout_dialog_content),

            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child:  Text(
                  context.localizations.yes,
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child:  Text(
                  context.localizations.no,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        });
    if (result ?? false) {
      _claer(context);
    }
  }

  Future<void> _claer(BuildContext context) async {
    bool clear = await SharedPrefController().clear();

    if (clear) {
      Get.delete<NotesGetController>();
      Navigator.pushReplacementNamed(context, '/login_screen');
    }
  }
}

