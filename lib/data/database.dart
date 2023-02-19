import 'package:hive_flutter/hive_flutter.dart';

// 5. Create ToDoDatabase class

class TodoDatabase {

  // Create an empty list
  List todoList = [];

  // Reference the hive box
  final _myBox = Hive.box('mybox');

  // Run this method if app is opened for the first time
  void createInitialData() {
    todoList = [
      ['Do exercise', true],
      ['Code app', false],
    ];
  }

  // Load the data from database
  void loadData () {
    todoList = _myBox.get("TODOLIST");
  }

  //  Update the database
  void updateData () {
    _myBox.put("TODOLIST", todoList);
  }
}