import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'course_list_page.dart';
import 'Pages/parents_view.dart';
import 'Pages/Login.dart';
import 'course_list_page.dart';
import 'utils/secure_storage_utils.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String? username="";
  late String? role="";

  @override
  void initState() {
    super.initState();
    getStoredValues();
  }

  // Function to retrieve values from shared preferences
  Future<void> getStoredValues() async {
    String? stored_username = await getValueFromSecureStorage('username');
    String? stored_role = await getValueFromSecureStorage('role');
    print("username : "+stored_username!+" role "+stored_role!);
    setState(() {
      username = stored_username;
      role=stored_role;
    });
  }
  @override
  Widget build(BuildContext context) {

    Widget initialPage;

    if (username != null ) {
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
