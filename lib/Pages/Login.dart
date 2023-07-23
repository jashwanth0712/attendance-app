import 'package:flutter/material.dart';
import 'package:attandance_viewer/api/Authentication.dart';
import 'package:attandance_viewer/Pages/parents_view.dart';
import 'package:attandance_viewer/constants/ThemeData.dart';
import 'package:attandance_viewer/utils/secure_storage_utils.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isParentSelected = true;
  bool isStudentSelected = false;

  void selectParent() {
    setState(() {
      isParentSelected = true;
      isStudentSelected = false;
    });
  }

  void selectStudent() {
    setState(() {
      isParentSelected = false;
      isStudentSelected = true;
    });
  }

  Future<void> login() async {
    String username = usernameController.text;
    String password = passwordController.text;
    // Obtain shared preferences.
    setState(() {
      isLoading = true;
    });

    bool success = await Authentication.login(username, password);

    setState(() {
      isLoading = false;
    });

    if (success) {
      // Function to retrieve values from shared preferences
      setValueInSecureStorage("username", username);
      setValueInSecureStorage("password", password);
      setValueInSecureStorage("role", "parent");
      print("Password is : "+password);
      // Navigate to home page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HeatMapCalendarExample()),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'images/college_colored_logo.png',
                height: 150,
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: selectParent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isParentSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 16.0,
                      ),
                      child: Text(
                        'Parent',
                        style: TextStyle(
                          color: isParentSelected ? Colors.white : primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  GestureDetector(
                    onTap: selectStudent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isStudentSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 16.0,
                      ),
                      child: Text(
                        'Student',
                        style: TextStyle(
                          color: isStudentSelected ? Colors.white : primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              if (isParentSelected) ...[
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: isLoading ? null : login,
                  child: Text('Log In'),
                ),
              ] else ...[
                Text(
                  'Coming soon',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              SizedBox(height: 16.0),
              if (isLoading) CircularProgressIndicator(),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: (){},
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                'Mail academics@iiitdm.ac.in',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
