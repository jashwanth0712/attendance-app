import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'course_list_page.dart';
import 'parents_view.dart';
import 'Pages/Login.dart';
import 'course_list_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Initialize the FlutterLocalNotificationsPlugin
    initializeNotifications();
    // Start the periodic timer to show notification every 5 seconds
    startTimer();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications() async {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> onSelectNotification(String? payload) async {
    // Handle notification tap here
    // When the notification is tapped, navigate to the desired screen in your app
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  void startTimer() {
    // Create a periodic timer that triggers every 5 seconds
    Timer.periodic(Duration(seconds: 5), (timer) {
      // Show the notification
      showNotification();
    });
  }

  void showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your_channel_id', 'your_channel_name',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, 'Student Absent today', 'your ward was absent for 2 subjects today', platformChannelSpecifics,
        payload: 'Custom Payload');
  }

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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}
