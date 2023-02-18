import 'package:flutter/material.dart';

import '../utilities/input_box.dart';
import '../utilities/todo_tile.dart';
import 'dummy_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textEditingController = TextEditingController();

  // List to store data
  List todoList = [
    ['People', false],
    ['know me as', false],
    ['Pakcheek333', true],
  ];

  // Function to check & uncheck the checkbox
  void onChecked(bool? value, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  // Function to delete task
  void deleteTask(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }


  // Function to save a new task
  void saveTask() {
    setState(() {
      todoList.add([_textEditingController.text, false]);
      Navigator.of(context).pop();
    });
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
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            text: todoList[index][0],
            checkStatus: todoList[index][1],
            onChanged: (value) => onChecked(value, index),
            deleteFunction: (value) => deleteTask(index),
            editFunction: (value) {},
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return InputBox(
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
