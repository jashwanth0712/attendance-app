import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:attandance_viewer/utils/secure_storage_utils.dart';

class Authentication {
  static Future<bool> login(String username, String password, BuildContext context) async {
    var url = Uri.parse(
        'https://www.iiitdm.ac.in/Profile/automation/focus/attendance_app_endpoints.php'); // Replace with your login API endpoint
    try {
      var response = await http.post(
        url,
        body: {
          'username': username,
          'password': password,
          'required' : 'attendance',
        },
      );
      if (response.statusCode == 200) {
        // Parse the JSON response
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);

        if (jsonResponse['status'] == true) {
          // Login successful
          var data = jsonResponse['attendance'];
          // Process the response data here
          print('Login successful. Response: $data');
          setDataValueInSecureStorage("data", data);
          print(data);
          _showSnackBar(context, 'Login successful',Colors.green);
          return true;
        } else {
          // Login failed (wrong credentials)
          print('Wrong credentials');
          _showSnackBar(context, 'Wrong credentials',Colors.red);
          return false;
        }
      } else {
        // Login failed (server error)
        print('Login failed with status: ${response.statusCode}.');
        _showSnackBar(context, 'Server error',Colors.red);
        return false;
      }
    } catch (e) {
      // Error occurred
      print('Error: $e');
      _showSnackBar(context, 'Error occurred',Colors.red);
      return false;
    }
  }
  static Future<bool> getcourses(String username, String password, BuildContext context) async {
    print("get course ran");
    var url = Uri.parse(
        'https://www.iiitdm.ac.in/Profile/automation/focus/attendance_app_endpoints.php'); // Replace with your login API endpoint
    try {
      var response = await http.post(
        url,
        body: {
          'username': username,
          'password': password,
          'required' : 'course',
        },
      );
      if (response.statusCode == 200) {
        // Parse the JSON response
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);

        if (jsonResponse['status'] == true) {
          // Login successful
          var data = jsonResponse['attendance'];
          // Process the response data here
          print('course response: $data');
          setDataValueInSecureStorage("courses", data);
          print(data);
          _showSnackBar(context, 'Login successful',Colors.green);
          return true;
        } else {
          // Login failed (wrong credentials)
          print('Wrong credentials');
          _showSnackBar(context, 'Wrong credentials',Colors.red);
          return false;
        }
      } else {
        // Login failed (server error)
        print('Login failed with status: ${response.statusCode}.');
        _showSnackBar(context, 'Server error',Colors.red);
        return false;
      }
    } catch (e) {
      // Error occurred
      print('Error: $e');
      _showSnackBar(context, 'Error occurred',Colors.red);
      return false;
    }
  }
  static Future<bool> getleaves(String username, String password, BuildContext context) async {
    var url = Uri.parse(
        'https://www.iiitdm.ac.in/Profile/automation/focus/attendance_app_endpoints.php'); // Replace with your login API endpoint
    try {
      var response = await http.post(
        url,
        body: {
          'username': username,
          'password': password,
          'required' : 'leave',
        },
      );
      if (response.statusCode == 200) {
        // Parse the JSON response
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);

        if (jsonResponse['status'] == true) {
          // Login successful
          var data = jsonResponse['attendance'];
          // Process the response data here
          print('Login successful. Response: $data');
          setDataValueInSecureStorage("leaves", data);
          print(data);
          return true;
        } else {
          // Login failed (wrong credentials)
          print('Wrong credentials');
          return false;
        }
      } else {
        // Login failed (server error)
        print('Login failed with status: ${response.statusCode}.');
        _showSnackBar(context, 'Server error',Colors.red);
        return false;
      }
    } catch (e) {
      // Error occurred
      print('Error: $e');
      _showSnackBar(context, 'Error occurred',Colors.red);
      return false;
    }
  }

  // Helper method to show the snack bar
  static void _showSnackBar(BuildContext context, String message,Color backgroundColor) {
    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      content: Text(message),
      duration: Duration(seconds: 3), // Adjust the duration as needed
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

// ... (your signup method and other code)
}
