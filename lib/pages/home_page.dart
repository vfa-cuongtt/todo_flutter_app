import 'package:flutter/material.dart';
import 'package:todo_flutter/data/database.dart';
import 'package:todo_flutter/util/dialog_box.dart';
import 'package:todo_flutter/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();
  // text controller
  final _textController = TextEditingController();

  @override
  void initState() {
    // if this is 1st time ever opening the app, the create default data
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      // else load data to existing
      db.loadData();
    }

    super.initState();
  }

  // // List of toDo task
  // List toDoList = [
  //   ['Make file', false],
  //   ['Do exercise', false],
  // ];

  // Checkbox was tapped
  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_textController.text, false]);
      _textController.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  // Create new task
  void createNewTask() {
    print("Creating new task");
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _textController,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  // Delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('TO DO'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkboxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
