import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/database.dart';
import '../utilities/input_box_edit.dart';
import '../utilities/input_box_save.dart';
import '../utilities/todo_tile.dart';
import 'dummy_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 3. Reference the box
  final _myBox = Hive.box('mybox');

  // 6. Reference class from database.dart
  TodoDatabase db = TodoDatabase();

  // 7. When the app first runs, do a couple checks
  @override
  void initState() {
    // Create the default data if the app runs for the first time
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  // Text controller
  final _textEditingController = TextEditingController();

  // Function to check & uncheck the checkbox
  void onChecked(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateData();
  }

  // Function to delete task
  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }

  // Function to save a new task
  void saveTask() {
    setState(() {
      db.todoList.add([_textEditingController.text, false]);
      Navigator.of(context).pop();
      _textEditingController.clear();
    });
    db.updateData();
  }

  // Function to edit task
  void editTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
      db.todoList.insert(index, [_textEditingController.text, false]);
      Navigator.of(context).pop();
    });
    db.updateData();
  }

  // Builder
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      drawer: Drawer(
        backgroundColor: Colors.deepPurple[50],
      ),
      appBar: AppBar(
        title: const Text('Todo App'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.account_circle,
              size: 39,
            ),
            tooltip: 'Pakcheek333',
            onPressed: () {
              // handle the press
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DummyPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            text: db.todoList[index][0],
            checkStatus: db.todoList[index][1],
            onChanged: (value) => onChecked(value, index),
            deleteFunction: (value) => deleteTask(index),
            editFunction: (value) {
              showDialog(
                context: context,
                builder: (context) {
                  return InputBoxEdit(
                    textController: _textEditingController,
                    onSave:() => editTask(index),
                    onCancel: () => Navigator.of(context).pop(),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return InputBoxSave(
                textController: _textEditingController,
                onSave: saveTask,
                onCancel: () => Navigator.of(context).pop(),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
