
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/AttendanceRecord.dart';
import '../utils/secure_storage_utils.dart';
import 'CourseCard.dart';

class CourseListPage extends StatefulWidget {
  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  List<Map<String, dynamic>> courses = [];
  List<Map<String, dynamic>> attendancedata = [];
  @override
  void initState() {
    super.initState();
    fetchData();
    fetchAttendanceData();
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

  int threshold=88;

  @override
  Widget build(BuildContext context) {
    // int belowThresholdCount = courses
    //     .where((course) => course['Percentage'] < threshold)
    //     .toList()
    //     .length;
    int belowThresholdCount = 5;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Image.asset('images/college_logo.png'), // Replace 'assets/college_logo.png' with your image path
          ),
        ],
      ),
      body: Column(
        children: [
          (belowThresholdCount == 0) ? Container() : Container(
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
              '${belowThresholdCount} ${belowThresholdCount == 1 ? 'subject has' : 'subjects have'} ${threshold}% below attendance',
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
                final course = courses[index];
                final serialNumber = 0;
                final courseId = course['course_code'];
                final courseName = course['course_name'];
                final facultyName = course['faculty'];
                final total = getTotalNumberOfDays(attendancedata, course['course_code']);
                final present = getNumberOfDaysWithStudStatus1(attendancedata, course['course_code'],"1");
                final absent = getNumberOfDaysWithStudStatus1(attendancedata, course['course_code'],"0");
                final noClass = 0;
                final provisionalApprovedLeave = 0;
                final presentPercentage = total != 0.0 ? (present / total * 100) : 0.0;
                final absentPercentage = total != 0.0 ? (absent / total * 100) : 0.0;
                final approvedLeavePercentage = 0;
                final overallPercentage = total != 0 ? (present / total * 100).toInt() : 0;



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
