// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'AddNoteScreen.dart';
//
// class Note {
//   String title;
//   String body;
//
//   Note({
//     required this.title,
//     required this.body,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'title': title,
//       'body': body,
//     };
//   }
//
//   factory Note.fromJson(Map<String, dynamic> json) {
//     return Note(
//       title: json['title'],
//       body: json['body'],
//     );
//   }
// }
//
//
// class ShowNoteScreen extends StatelessWidget {
//   final List<Note> notes;
//
//   ShowNoteScreen({required this.notes});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notes'),
//       ),
//       body: ListView.builder(
//         itemCount: notes.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => SingleNoteScreen(note: notes[index]),
//                 ),
//               );
//             },
//             child: ListTile(
//               title: Text(notes[index].title),
//               subtitle: Text(notes[index].body),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class SingleNoteScreen extends StatelessWidget {
//   final Note note;
//
//   SingleNoteScreen({required this.note});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(note.title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               note.title,
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               note.body,
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }