import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_book/NoteListScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal
      ),
      darkTheme: ThemeData.dark(),
      home: NoteListScreen(),
    );
  }
}


class Note {
  final String title;
  final String description;

  Note({required this.title, required this.description});
  @override
  String toString() {
    return 'Title: $title, Description: $description';
  }
}
