import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AddNoteScreen.dart';
import 'EditNote.dart';

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  List<String> notes = [];

  bool isDarkMode = Get.isDarkMode;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notes = prefs.getStringList('notes') ?? [];
    });
  }

  Future<void> _saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('notes', notes);
  }

  void _addNewNote() async {
    final newNote = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNoteScreen()),
    );
    if (newNote != null) {
      setState(() {
        notes.add(newNote);
        _saveNotes();
      });
    }
  }

  void _editTitle(int index) async {
    final editedTitle = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditTitleScreen(initialTitle: notes[index])),
    );
    if (editedTitle != null && editedTitle != notes[index]) {
      setState(() {
        notes[index] = editedTitle;
        _saveNotes();
      });
    }
  }




void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: _dialogContent(context, index),
          ),
        );
      },
    );
  }
  Widget _dialogContent(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Delete Note ?',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
          ),
          const SizedBox(height: 10,),
          const Divider(height: 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 14.0,

                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    notes.removeAt(index);
                  });
                  _saveNotes();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey : Colors.teal,
        title: const Text('Notes'),
        actions: [
          Switch(
            activeColor: Colors.white,
            value: isDarkMode,
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
              });
              Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDarkMode ? Colors.grey :Colors.teal,
        onPressed: () {
          _addNewNote();
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _editTitle(index);
            },
            onLongPress: (){
              _showDeleteDialog(index);
            },
            child: Container(
                margin: const EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isDarkMode ? Colors.grey : Colors.teal.shade200
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Text(
                        '${index + 1}.',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: Text(
                          notes[index],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),),
          );
        },
      ),
    );
  }
}
