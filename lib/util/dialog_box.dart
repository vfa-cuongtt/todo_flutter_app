import 'package:flutter/material.dart';
import 'package:todo_flutter/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {Key? key,
      required this.controller,
      required this.onSave,
      required this.onCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Add a new task'),
            ),

            // button: Add + Cancel
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              // Cancel button
              MyButton(
                text: 'Cancel',
                color: Colors.white38,
                onPressed: onCancel,
              ),

              // Save button
              MyButton(
                text: 'Save',
                color: Theme.of(context).primaryColor,
                onPressed: onSave,
              ),
            ])
          ],
        ),
      ),
    );
  }
}
