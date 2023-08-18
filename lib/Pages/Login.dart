import 'package:flutter/material.dart';
import 'package:attandance_viewer/api/Authentication.dart';
import 'package:attandance_viewer/Pages/parents_view.dart';
import 'package:attandance_viewer/constants/ThemeData.dart';
import 'package:attandance_viewer/utils/secure_storage_utils.dart';
import '../constants/TranslationConstants.dart';
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
  String? storedLanguage="english";
  void initState() {
    super.initState();
    _checkAndSetDefaultLanguage();
  }

  Future<void> _checkAndSetDefaultLanguage() async {
     storedLanguage = await getValueFromSecureStorage("language");
     print("recieved $storedLanguage");
    if (storedLanguage == null) {
      setValueInSecureStorage("language", "english");
      print("language is english");
    }
  }

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

    setState(() {
      isLoading = true;
    });

    // Start all the asynchronous tasks concurrently
    List<Future<bool>> futures = [
      Authentication.login(username, password, context),
      Authentication.getcourses(username, password, context),
      Authentication.getleaves(username, password, context),
    ];

    // Wait for all tasks to complete
    List<bool> results = await Future.wait(futures);

    // You now have the results of all three tasks in the 'results' list
    bool success = results[0];
    bool courses = results[1];
    bool leaves = results[2];

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

  void _showLanguageSnackbar(String language) {
    setValueInSecureStorage("language", language);
    print("the stored data is $storedLanguage");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected language: $language'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _selectLanguage(String language) {
    // Set logic here to handle language selection.
    _showLanguageSnackbar(language);
    setState(() {
      storedLanguage=language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: [
          PopupMenuButton(
            onSelected: _selectLanguage,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: 'english', child: Text('English')),
                PopupMenuItem(value: 'hindi', child: Text('हिन्दी')),
                PopupMenuItem(value: 'tamil', child: Text('தமிழ்')),
                PopupMenuItem(value: 'telugu', child: Text('తెలుగు')),
                PopupMenuItem(value: 'malayalam', child: Text('മലയാളം')),
                PopupMenuItem(value: 'kannada', child: Text('ಕನ್ನಡ')),
                PopupMenuItem(value: 'marathi', child: Text('मराठी')),
              ];
            },
          ),
        ],
      ),
      body: storedLanguage != null
          ?  SingleChildScrollView(
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
                        TranslationConstants.translations["parent"]![storedLanguage!]!,
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
                        TranslationConstants.translations["student"]![storedLanguage!]!,
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
                    labelText: TranslationConstants.translations["username"]![storedLanguage!]!,
                  ),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: TranslationConstants.translations["password"]![storedLanguage!]!,
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: isLoading ? null : login,
                  child: Text(TranslationConstants.translations["login"]![storedLanguage!]!),
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
                  TranslationConstants.translations["forgot_password"]![storedLanguage!]!+"?",
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
      )
          : Center(child: Column(
            children: [
              CircularProgressIndicator(),
              Container(child: Text(storedLanguage!),)
            ],
          )),
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
