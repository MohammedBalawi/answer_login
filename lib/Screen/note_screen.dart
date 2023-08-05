import 'package:answer_login/context-extenssion.dart';
import 'package:answer_login/get/note_get.dart';
import 'package:answer_login/modle/note.dart';
import 'package:answer_login/modle/process_response.dart';
import 'package:answer_login/provieder/note_provieder.dart';
import 'package:answer_login/shared_pref/shared.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class NoteScreen extends StatefulWidget {
//   const NoteScreen({Key? key, this.note}) : super(key: key);
//
//   final Note? note;
//
//   @override
//   State<NoteScreen> createState() => _NoteScreenState();
// }
//
// class _NoteScreenState extends State<NoteScreen> {
//   late TextEditingController _titleTextController;
//   late TextEditingController _infoTextController;
//
//   @override
//   void initState() {
//     super.initState();
//     _titleTextController = TextEditingController(text: widget.note?.title);
//     _infoTextController = TextEditingController(text: widget.note?.info);
//   }
//
//   @override
//   void dispose() {
//     _titleTextController.dispose();
//     _infoTextController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: ListView(
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//         children: [
//           TextField(
//             controller: _titleTextController,
//             keyboardType: TextInputType.text,
//             style: GoogleFonts.cairo(),
//             decoration: InputDecoration(
//                 contentPadding: EdgeInsetsDirectional.only(start: 15.w),
//                 hintText: context.localizations.title,
//                 hintStyle: GoogleFonts.cairo(),
//                 prefixIcon: Icon(Icons.title),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.r),
//                 )),
//           ),
//           SizedBox(height: 10.h),
//           TextField(
//             controller: _infoTextController,
//             keyboardType: TextInputType.text,
//             style: GoogleFonts.cairo(),
//             decoration: InputDecoration(
//               contentPadding: EdgeInsetsDirectional.only(start: 15.w),
//               hintText: context.localizations.info,
//               hintStyle: GoogleFonts.cairo(),
//               prefixIcon: Icon(Icons.info),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.r),
//               ),
//             ),
//           ),
//           SizedBox(height: 20.h),
//           ElevatedButton(
//             onPressed: () => _performSave(),
//             child: Text(context.localizations.save),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _performSave() {
//     if (_checkData()) {
//       _save();
//     }
//   }
//
//   bool _checkData() {
//     if (_titleTextController.text.isNotEmpty &&
//         _infoTextController.text.isNotEmpty) {
//       return true;
//     }
//     context.showMessage(message: context.localizations.error_data, error: true);
//     return false;
//   }
//
//   void _save() async {
//     //Call save/update note function From INTERMEDIATE LAYER (NoteProvider) as a BusinessLayer Between UI & DATA LAYER
//     ProcessResponse processResponse = isNewNote?
//     await Provider.of<NotesProvider>(context,listen: false).create(note):
//         await Provider.of<NotesProvider>(context,listen: false).update(note);
//     if (processResponse.success) {
//       isNewNote ? clear() : Navigator.pop(context);
//     }
//     context.showMessage(
//         message: processResponse.message, error: !processResponse.success);
//   }
//
//   void clear() {
//     _titleTextController.clear();
//     _infoTextController.clear();
//   }
//
//   Note get note {
//     Note note = isNewNote ? Note() : widget.note!;
//     note.title = _titleTextController.text;
//     note.info = _infoTextController.text;
//     note.userId =
//         SharedPrefController().getValueFor<int>(Key: PreKey.id.name)!;
//     return note;
//   }
//
//   bool get isNewNote => widget.note == null;
//
//   String get title =>
//       isNewNote ? context.localizations.create : context.localizations.update;
// }

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key, this.note});

  final Note? note;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late TextEditingController _titleTextController;
  late TextEditingController _infoTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleTextController = TextEditingController(text: widget.note?.title);
    _infoTextController = TextEditingController(text: widget.note?.info);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleTextController.dispose();
    _infoTextController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(title),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          TextField(
            controller: _titleTextController,
            keyboardType: TextInputType.text,
            style: GoogleFonts.aBeeZee(),
            decoration: InputDecoration(
                contentPadding: EdgeInsetsDirectional.only(start: 15),
                hintText: context.localizations.title,
                hintStyle: GoogleFonts.aBeeZee(),
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _infoTextController,
            keyboardType: TextInputType.text,
            style: GoogleFonts.aBeeZee(),
            decoration: InputDecoration(
                contentPadding: EdgeInsetsDirectional.only(start: 15),
                hintText: context.localizations.info,
                hintStyle: GoogleFonts.aBeeZee(),
                prefixIcon: Icon(Icons.info),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _performSave();
            },
            child: Text(context.localizations.save),
          ),
        ],
      ),
    );
  }

  void _performSave() {
    if (_checkData()) {
      _save();
    }
  }

  bool _checkData() {
    if (_titleTextController.text.isNotEmpty &&
        _infoTextController.text.isNotEmpty) {
      return true;
    }
    context.showMessage(message: context.localizations.error_data, error: true);
    return false;
  }

  void _save() async {
    ProcessResponse processResponse = isNewNote
        ? await NotesGetController.to.create(note)
        : await NotesGetController.to.updateNote( note);
    if (processResponse.success) {
      isNewNote ? clear() :Navigator.pop(context);
    }
    context.showMessage(
        message: processResponse.message, error: !processResponse.success);
  }

  void clear() {
    _titleTextController.clear();
    _infoTextController.clear();
  }

  Note get note {
    Note note = isNewNote ? Note() : widget.note!;
    note.title = _titleTextController.text;
    note.info = _infoTextController.text;
    note.userId = SharedPrefController().getValueFor<int>(Key: PreKey.id.name)!;

    return note;
  }

  bool get isNewNote => widget.note == null;

  String get title =>
      isNewNote ? context.localizations.create : context.localizations.update;
}
