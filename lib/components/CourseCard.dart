import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../course_list_page.dart';

class CourseCard extends StatefulWidget {
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

  CourseCard({
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
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    Color attendanceColor =
    widget.overallPercentage < 85 ? Colors.red : Colors.green;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailsPage(
              serialNumber: widget.serialNumber,
              courseId: widget.courseId,
              courseName: widget.courseName,
              facultyName: widget.facultyName,
              total: widget.total,
              present: widget.present,
              absent: widget.absent,
              noClass: widget.noClass,
              provisionalApprovedLeave: widget.provisionalApprovedLeave,
              presentPercentage: widget.presentPercentage,
              absentPercentage: widget.absentPercentage,
              approvedLeavePercentage: widget.approvedLeavePercentage,
              overallPercentage: widget.overallPercentage,
            ),
          ),
        );
      },
      child:Card(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.courseName.length > 40 ? '${widget.courseName.substring(0, 40)}...' : widget.courseName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),


              SizedBox(height: 8),
              Text(
                'by: ${widget.facultyName.length > 23 ? '${widget.facultyName.substring(0, 3)}..${widget.facultyName.substring(widget.facultyName.length - 3)}' : widget.facultyName}',
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${widget.overallPercentage}%',
                    style: TextStyle(
                      color: attendanceColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),


                ],
              ),
              SizedBox(height: 8),
              Text(
                'Course ID: ${widget.courseId.length > 9 ? '${widget.courseId.substring(0, 3)}..${widget.courseId.substring(widget.courseId.length - 3)}' : widget.courseId}',
                style: TextStyle(
                  fontWeight: FontWeight.w300, // Reduced font weight
                  color: Colors.black.withOpacity(0.6), // Reduced opacity
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}