import 'package:flutter/material.dart';
import 'package:quiz_app/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
