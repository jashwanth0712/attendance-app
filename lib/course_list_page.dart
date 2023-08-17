import 'package:flutter/material.dart';
import 'package:attandance_viewer/utils/secure_storage_utils.dart';
import 'package:intl/intl.dart';
import 'AttendanceTablePage.dart';
import 'components/CourseCard.dart';

class CourseDetailsPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Image.asset('images/college_logo.png'), // Replace 'assets/college_logo.png' with your image path
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
                      child: Text('Course ID:'),
                    ),
                    TableCell(
                      child: Text('$courseId'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text('Course Name:'),
                    ),
                    TableCell(
                      child: Text('$courseName'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text('Faculty Name:'),
                    ),
                    TableCell(
                      child: Text('$facultyName'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text('Total:'),
                    ),
                    TableCell(
                      child: Text('$total'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text('Present:'),
                    ),
                    TableCell(
                      child: Text('$present'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text('Absent:'),
                    ),
                    TableCell(
                      child: Text('$absent'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text('No Class:'),
                    ),
                    TableCell(
                      child: Text('$noClass'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text('Provisional Approved Leave*:'),
                    ),
                    TableCell(
                      child: Text('$provisionalApprovedLeave'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text('Present Percentage:'),
                    ),
                    TableCell(
                      child: Text('$presentPercentage%'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text('Absent Percentage:'),
                    ),
                    TableCell(
                      child: Text('$absentPercentage%'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text('Approved Leave Percentage*:'),
                    ),
                    TableCell(
                      child: Text('$approvedLeavePercentage%'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text('Overall Percentage:'),
                    ),
                    TableCell(
                      child: Text('$overallPercentage%'),
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
                    builder: (context) => AttendanceTablePage(courseId: courseId,context: context),
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
