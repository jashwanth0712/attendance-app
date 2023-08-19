import 'package:flutter/material.dart';
import 'package:attandance_viewer/utils/secure_storage_utils.dart';
import 'package:intl/intl.dart';
import '../AttendanceTablePage.dart';
import '../components/CourseCard.dart';
import '../constants/TranslationConstants.dart';

class CourseDetailsPage extends StatefulWidget {
  final int serialNumber;
  final String courseId;
  final String courseName;
  final String facultyName;
  final int total;
  final int present;
  final int absent;
  final int noClass;
  final int provisionalApprovedLeave;
  final double presentPercentage;
  final double absentPercentage;
  final int approvedLeavePercentage;
  final int overallPercentage;

  CourseDetailsPage({
    required this.serialNumber,
    required this.courseId,
    required this.courseName,
    required this.facultyName,
    required this.total,
    required this.present,
    required this.absent,
    required this.noClass,
    required this.provisionalApprovedLeave,
    required this.presentPercentage,
    required this.absentPercentage,
    required this.approvedLeavePercentage,
    required this.overallPercentage,
  });

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
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
    return Scaffold(appBar: AppBar(
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Image.asset('images/college_logo.png'), // Replace 'assets/college_logo.png' with your image path
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
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
              columnWidths: {
                0: FlexColumnWidth(5), // S.No column width
                1: FlexColumnWidth(5), // Data column width
              },
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Text(TranslationConstants.translations["course_id"]![storedLanguage!]!,),
                    ),
                    TableCell(
                      child: Text('${widget.courseId}'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(TranslationConstants.translations["course_name"]![storedLanguage!]!,),
                    ),
                    TableCell(
                      child: Text('${widget.courseName}'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(TranslationConstants.translations["faculty_name"]![storedLanguage!]!,),
                    ),
                    TableCell(
                      child: Text('${widget.facultyName}'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text('Total:'),
                    ),
                    TableCell(
                      child: Text('${widget.total}'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(TranslationConstants.translations["number_of_present"]![storedLanguage!]!,),
                    ),
                    TableCell(
                      child: Text('${widget.present}'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(TranslationConstants.translations["number_of_absents"]![storedLanguage!]!),
                    ),
                    TableCell(
                      child: Text('${widget.absent}'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(TranslationConstants.translations["days_with_no_class"]![storedLanguage!]!),
                    ),
                    TableCell(
                      child: Text('${widget.noClass}'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text('Provisional Approved Leave*:'),
                    ),
                    TableCell(
                      child: Text('${widget.provisionalApprovedLeave}'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(TranslationConstants.translations["present_percentage"]![storedLanguage!]!),
                    ),
                    TableCell(
                      child: Text('${widget.presentPercentage}%'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(TranslationConstants.translations["absent_percentage"]![storedLanguage!]!),
                    ),
                    TableCell(
                      child: Text('${widget.absentPercentage}%'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(TranslationConstants.translations["approved_leave_percentage"]![storedLanguage!]!),
                    ),
                    TableCell(
                      child: Text('${widget.approvedLeavePercentage}%'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(TranslationConstants.translations["overall_percentage"]![storedLanguage!]!),
                    ),
                    TableCell(
                      child: Text('${widget.overallPercentage}%'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceTablePage(courseId: widget.courseId,context: context),
                  ),
                );
              },
              child: Text('Show Attendance Table'),
            ),
          ],
        ),
      ),
    );
  }
}
