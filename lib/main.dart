import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_todoapp/pages/home_page.dart';

void main() async {

  // 1. Initialize hive database
  await Hive.initFlutter();

  // 2. Open the box
  var box = await Hive.openBox('mybox');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}
