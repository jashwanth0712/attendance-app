import 'package:attandance_viewer/Pages/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'dart:developer';
import '../components/CourseList.dart';
import '../constants/TranslationConstants.dart';
import 'course_list_page.dart';
import "package:attandance_viewer/Pages/DateWiseAttendanceTable.dart";
import 'package:attandance_viewer/utils/secure_storage_utils.dart';
import '../AttendanceTablePage.dart';

class HeatMapCalendarExample extends StatefulWidget {
  const HeatMapCalendarExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HeatMapCalendarExample();
}

class _HeatMapCalendarExample extends State<HeatMapCalendarExample> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController heatLevelController = TextEditingController();
  List<Map<String, dynamic>> attendancedata = [];


  bool isOpacityMode = true;
  String? storedLanguage="english";
  void initState() {
    super.initState();
    _checkAndSetDefaultLanguage();
    fetchAttendanceData();

  }

  Future<void> _checkAndSetDefaultLanguage() async {
    storedLanguage = await getValueFromSecureStorage("language");
    print("recieved $storedLanguage");
    if (storedLanguage == null) {
      setValueInSecureStorage("language", "english");
      print("language is english");
    }
  }
  Future<void> fetchAttendanceData() async {
    List<Map<String, dynamic>>? newData = await getDataValueFromSecureStorage("data");
    if (newData != null) {
      setState(() {
        attendancedata = newData;
        print("got attendancedata");
        print(newData);

        // Call the function to update the heatMapDatasets
        updateHeatMapDatasets(attendancedata);
      });
    }
  }

  Map<DateTime, int> heatMapDatasets = {
  };
  void updateHeatMapDatasets(List<Map<String, dynamic>> attendanceData) {
    // Clear the existing data
    heatMapDatasets.clear();

    // Loop through the attendance data and update the heatMapDatasets
    for (var entry in attendanceData) {
      // Parse the date from the 'AttDate' field in the format "yyyy-MM-dd"
      DateTime date = DateTime.parse(entry['AttDate']);

      // Check if the entry has studstatus equal to 0
      if (entry['StudStatus'] == "0") {
        // If the date already exists in heatMapDatasets, increment the count by 1
        if (heatMapDatasets.containsKey(date)) {
          heatMapDatasets[date] = heatMapDatasets[date]! + 1;
        } else {
          heatMapDatasets[date] = 1;
        }
      }

    }
  }


  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
    heatLevelController.dispose();
  }

  Widget _textField(final String hint, final TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 20, top: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffe7e7e7), width: 1.0)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF20bca4), width: 1.0)),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          isDense: true,
        ),
      ),
    );
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Image.asset(
                'images/college_logo.png'), // Replace 'assets/college_logo.png' with your image path
          ),
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),

                  // HeatMapCalendar
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DateWiseAttendanceTable(
                            email: "example@example.com",
                            selectedDate: DateTime.now(),
                          ),
                        ),
                      );
                    },
                    child: HeatMapCalendar(
                      flexible: true,
                      datasets: heatMapDatasets,
                      colorMode:
                          isOpacityMode ? ColorMode.opacity : ColorMode.color,
                      colorsets: const {
                        1: Colors.red,
                        3: Colors.orange,
                        5: Colors.yellow,
                        7: Colors.green,
                        9: Colors.blue,
                        11: Colors.indigo,
                        13: Colors.purple,
                      },
                      onClick: (value) {
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DateWiseAttendanceTable(
                              email: "example@exaple.com",
                              selectedDate: value,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildLegendItem(Colors.white, 'Complete Present'),
                      _buildLegendItem(Colors.red[100]!, 'Partial Absent'),
                      _buildLegendItem(Colors.redAccent, 'Complete Absent'),
                      SizedBox(height: 8),
                      Wrap( // Wrap widget here
                        alignment: WrapAlignment.center,
                        children: [
                          Icon(Icons.info_outline, size: 16),
                          SizedBox(width: 8),
                          Text(
                            TranslationConstants.translations["click_a_date_to_view_attendance"]![storedLanguage!]!,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseListPage(),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.all(20),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          TranslationConstants.translations["subject_wise_attendance"]![storedLanguage!]!,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
      
      onPressed: () {
        setValueInSecureStorage("username", "");
        setValueInSecureStorage("password", "");
        setValueInSecureStorage("role", "");
        Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => LoginPage(),
        )
        );
      },
      child :  Icon(Icons.logout, color: Color(0xFF285190),),

      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: color,
              border: Border.all(
                color: Colors.black26,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
