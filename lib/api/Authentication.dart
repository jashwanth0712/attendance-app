import 'package:http/http.dart' as http;

class Authentication {
  static Future<bool> login(String username, String password) async {
    return true;
    var url = Uri.parse(
        'https://api.example.com/login'); // Replace with your login API endpoint
    try {
      var response = await http.post(
        url,
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Login successful
        var data = response.body;
        // Process the response data here
        print('Login successful. Response: $data');
        return true;
      } else {
        // Login failed
        print('Login failed with status: ${response.statusCode}.');
        return false;
      }
    } catch (e) {
      // Error occurred
      print('Error: $e');
      return false;
    }
  }

  // --------------------------signup--------------------------
  static Future<bool> signup(String username, String password) async {
    return true;
    var url = Uri.parse(
        'https://api.example.com/signup'); // Replace with your signup API endpoint

    try {
      var response = await http.post(
        url,
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Signup successful
        var data = response.body;
        // Process the response data here
        print('Signup successful. Response: $data');
        return true;
      } else {
        // Signup failed
        print('Signup failed with status: ${response.statusCode}.');
        return false;
      }
    } catch (e) {
      // Error occurred
      print('Error: $e');
      return false;
    }
  }
}
