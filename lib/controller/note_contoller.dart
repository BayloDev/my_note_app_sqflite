import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../model/note_model.dart';
import '../view/data_base_helper.dart';

class NoteController extends GetxController {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<Note> notes = <Note>[];
  List<Note> sugessionList = <Note>[];
  String keyword = '';
  late List<Note> listDisplay;
  bool isSearch = false;
  DateTime dateTimeNow = DateTime.now();
  final GlobalKey<FormState> formKey = GlobalKey();
  ThemeData myTheme = ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(
      TextTheme(
        bodyText1: TextStyle(
          fontSize: 20,
          color: Colors.black.withOpacity(0.7),
          fontStyle: FontStyle.normal,
        ),
        bodyText2: TextStyle(
          fontSize: 14,
          color: Colors.black.withOpacity(0.7),
          fontStyle: FontStyle.italic,
        ),
        headline1: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.black.withOpacity(0.7),
        ),
        headline2: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 28,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
        ),
        headline3: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 18,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
        ),
        headline4: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 16,
          fontStyle: FontStyle.normal,
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 20,
      color: Colors.black12,
      titleTextStyle: TextStyle(
        color: Colors.orange,
        fontSize: 25,
        fontWeight: FontWeight.bold,
        letterSpacing: 5,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: Colors.orange,
      brightness: Brightness.dark,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        backgroundColor: Colors.black.withOpacity(0.4),
        elevation: 2,
        side: const BorderSide(
          width: 1.5,
          color: Colors.orange,
          style: BorderStyle.solid,
        ),
        shadowColor: Colors.orange.shade300,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 0,
      backgroundColor: Colors.orange,
    ),
  );

  Size sizePhone(context) {
    return MediaQuery.of(context).size;
  }

  @override
  void onInit() {
    getAllNotes();
    super.onInit();
  }

  bool isEmpty() {
    if (notes.isEmpty) {
      return true;
    }
    return false;
  }

  void addNoteToDataBase() async {
    Note note = Note(
      title: titleController.text,
      content: contentController.text,
      dateTimeCreated: DateFormat('MMM dd, yyyy / hh:mm').format(
        DateTime.now(),
      ),
      dateTimeEdited: DateFormat('MMM dd, yyyy / hh:mm').format(
        DateTime.now(),
      ),
      isExpand: 0,
    );
    await DataBaseHelper.instance.addNote(note);
    titleController.text = '';
    contentController.text = '';
    getAllNotes();
    Get.back();
  }

  void updateNotes(int id, dtCreated) async {
    Note note = Note(
      id: id,
      title: titleController.text,
      content: contentController.text,
      dateTimeCreated: dtCreated,
      dateTimeEdited: DateFormat('MMM dd, yyyy / HH:mm').format(
        DateTime.now(),
      ),
      isExpand: 0,
    );
    await DataBaseHelper.instance.updateData(note);
    titleController.text = '';
    contentController.text = '';

    getAllNotes();
    Get.back();
  }

  Future<int> deleteNoteFromDb(int id) async {
    int response = await DataBaseHelper.instance.deleteNote(id).then((value) {
      update();
      return value;
    });
    return response;
  }

  void shareNote(String title, String content) {
    Share.share('$title \n $content \n Created by bilal arbaoui');
  }

  getAllNotes() async {
    notes = await DataBaseHelper.instance.getNoteList();
    update();
  }
}
