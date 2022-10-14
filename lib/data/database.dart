import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  // reference our box
  final _myBox = Hive.box('mybox');

  // run this method if this is 1st time ever opening  this app
  void createInitialData() {
    toDoList = [
      ['Todo 1', false],
      ['Todo 2', false],
    ];
  }

  // Load the data form database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // Update the data form database
  void updateData() {
    _myBox.put("TODOLIST", toDoList);
  }
}
