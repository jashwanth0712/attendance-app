import 'dart:convert';
import 'package:flutter/material.dart';
import 'course_list_page.dart';
import 'parents_view.dart';
import 'Pages/Login.dart';
import 'course_list_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve the values from shared preferences
    final String? username = ''; // Replace with your code to get the value from shared preferences
    final String? role = ''; // Replace with your code to get the value from shared preferences

    Widget initialPage;

    if (username != null && username.isNotEmpty) {
      if (role == 'parent') {
        initialPage = const HeatMapCalendarExample();
      } else if (role == 'student') {
        initialPage = CourseListPage();
      } else {
        initialPage = LoginPage();
      }
    } else {
      initialPage = LoginPage();
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF285190), // Set primary color to #285190
        primarySwatch: MaterialColor(0xFF285190, {
          50: Color(0xFF285190),
          100: Color(0xFF285190),
          200: Color(0xFF285190),
          300: Color(0xFF285190),
          400: Color(0xFF285190),
          500: Color(0xFF285190),
          600: Color(0xFF285190),
          700: Color(0xFF285190),
          800: Color(0xFF285190),
          900: Color(0xFF285190),
        }), // Set primary color to #285190
      ),
      home: initialPage, // Use the initialPage widget based on the condition
    );
  }
}
