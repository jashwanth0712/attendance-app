import 'dart:convert';
import 'package:flutter/material.dart';
import 'course_list_page.dart';
import 'parents_view.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  HeatMapCalendarExample()
    );
  }
}
