import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNoteScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  Future<void> _saveList(noteValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('notes', noteValue);
  }

  bool isDarkMode = Get.isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey : Colors.teal,
        title:  Text("Write note"),
        actions: [
          IconButton(
              onPressed: () {
                if (_textEditingController.text.isEmpty) {
                  Get.snackbar(
                    'Alert',
                    'Note is empty',
                    duration: const Duration(microseconds: 1000),
                    isDismissible: true,
                  );
                } else
                {
                  _saveList(_textEditingController.text);
                  Navigator.pop(context, _textEditingController.text);
                }
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.words,
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: "Note...",
                  border: InputBorder.none,

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
