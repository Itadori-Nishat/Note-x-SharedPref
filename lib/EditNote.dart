import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditTitleScreen extends StatelessWidget {
  final TextEditingController _titleController;

  EditTitleScreen({required String initialTitle})
      : _titleController = TextEditingController(text: initialTitle);
  bool isDarkMode = Get.isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey : Colors.teal,
        title: Text('Edit note'),
        actions: [
          IconButton(
            onPressed: () {

              Navigator.pop(context, _titleController.text);
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          maxLines: null,
          controller: _titleController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            hintText: "Enter new note...",
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
