import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Authentication {
  static Future<bool> login(String username, String password, BuildContext context) async {
    print("Login pressed");
    var url = Uri.parse(
        'https://www.iiitdm.ac.in/Profile/automation/focus/attendance_app_endpoints.php'); // Replace with your login API endpoint
    try {
      var response = await http.post(
        url,
        body: {
          'username': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        // Parse the JSON response
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == true) {
          // Login successful
          var data = jsonResponse['attendance'];
          // Process the response data here
          print('Login successful. Response: $data');
          _showSnackBar(context, 'Login successful');
          return true;
        } else {
          // Login failed (wrong credentials)
          print('Wrong credentials');
          _showSnackBar(context, 'Wrong credentials');
          return false;
        }
      } else {
        // Login failed (server error)
        print('Login failed with status: ${response.statusCode}.');
        _showSnackBar(context, 'Server error');
        return false;
      }
    } catch (e) {
      // Error occurred
      print('Error: $e');
      _showSnackBar(context, 'Error occurred');
      return false;
    }
  }

  // Helper method to show the snack bar
  static void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3), // Adjust the duration as needed
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

// ... (your signup method and other code)
}
