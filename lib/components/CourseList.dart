
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/AttendanceRecord.dart';
import '../constants/TranslationConstants.dart';
import '../utils/secure_storage_utils.dart';
import 'CourseCard.dart';

class CourseListPage extends StatefulWidget {
  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  List<Map<String, dynamic>> courses = [];
  List<Map<String, dynamic>> attendancedata = [];
  String? storedLanguage="english";

  Future<void> _checkAndSetDefaultLanguage() async {
    storedLanguage = await getValueFromSecureStorage("language");
    print("recieved $storedLanguage");
    if (storedLanguage == null) {
      setValueInSecureStorage("language", "english");
      print("language is english");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAttendanceData();
    _checkAndSetDefaultLanguage();
    fetchData();
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
  int getNumberOfDaysWithStudStatus1(List<Map<String, dynamic>> attendanceData, String courseId,String status) {
    final List<AttendanceRecord> attendanceRecords =
    attendanceData.map((item) => AttendanceRecord.fromJson(item)).toList();

    int numberOfDays = 0;
    for (var record in attendanceRecords) {
      if (record.courseId == courseId && record.studStatus == status) {
        numberOfDays++;
      }
    }
    return numberOfDays;
  }
  int getTotalNumberOfDays(List<Map<String, dynamic>> attendanceData, String courseId) {
    final List<AttendanceRecord> attendanceRecords =
    attendanceData.map((item) => AttendanceRecord.fromJson(item)).toList();

    int numberOfDays = 0;
    for (var record in attendanceRecords) {
      if (record.courseId == courseId) {
        numberOfDays++;
      }
    }
    return numberOfDays;
  }
  Future<void> fetchData() async {
    List<Map<String, dynamic>>? newData =
    await getDataValueFromSecureStorage("courses");
    if (newData != null) {
      setState(() {
        courses = newData;
        print("got it");
        print(newData);
      });
    }
  }
  Future<void> fetchAttendanceData() async {
    List<Map<String, dynamic>>? newData =
    await getDataValueFromSecureStorage("data");
    if (newData != null) {
      setState(() {
        attendancedata = newData;
        print("got attendancedata");
        print(newData);
      });
    }
  }
  int countCoursesBelowThreshold(List<Map<String, dynamic>> courses, double threshold) {
    int belowThresholdCount = 0;
    print("in coutn per $courses");
    for (var course in courses) {
      course['total']= getTotalNumberOfDays(attendancedata, course['course_code']);
      course['present']=getNumberOfDaysWithStudStatus1(attendancedata, course['course_code'],"1");
      course['absent']=getNumberOfDaysWithStudStatus1(attendancedata, course['course_code'],"0");
      double overallPercentage = course['total'] != 0 ? (course['present']/ course['total'] * 100) : 0;
      if (!course['course_code'].startsWith('noc') && overallPercentage < threshold) {
        belowThresholdCount++;
      }
    }

    return belowThresholdCount;
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
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
      body: Column(
        children: [
          (countCoursesBelowThreshold(courses, 88.0) == 0) ? Container() : Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child:Text(
              ' ${TranslationConstants.translations["subjects_with_attendance_below_88"]![storedLanguage!]!} => ${countCoursesBelowThreshold(courses, 88.0)}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),

          ),

          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
              ),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                courses[index]['total']= getTotalNumberOfDays(attendancedata, courses[index]['course_code']);
                courses[index]['present']=getNumberOfDaysWithStudStatus1(attendancedata, courses[index]['course_code'],"1");
                courses[index]['absent']=getNumberOfDaysWithStudStatus1(attendancedata, courses[index]['course_code'],"0");
                courses[index]['overallPercentage']=courses[index]['total'] != 0 ? (courses[index]['present']/ courses[index]['total'] * 100).toInt() : 0;
                final course = courses[index];
                final serialNumber = 0;
                final courseId = course['course_code'];
                final courseName = course['course_name'];
                final facultyName = course['faculty'];
                final total = course['total'];
                final present = course['present'];
                final absent = course['absent'];
                final noClass = 0;
                final provisionalApprovedLeave = 0;
                final presentPercentage = total != 0.0 ? (present / total * 100) : 0.0;
                final absentPercentage = total != 0.0 ? (absent / total * 100) : 0.0;
                final approvedLeavePercentage = 0;
                final overallPercentage = course['overallPercentage'];



                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CourseCard(
                    serialNumber: serialNumber,
                    courseId: courseId,
                    courseName: courseName,
                    facultyName: facultyName,
                    total: total,
                    present: present,
                    absent: absent,
                    noClass: noClass,
                    provisionalApprovedLeave: provisionalApprovedLeave,
                    presentPercentage: presentPercentage,
                    absentPercentage: absentPercentage,
                    approvedLeavePercentage: approvedLeavePercentage,
                    overallPercentage: overallPercentage,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
