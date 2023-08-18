import 'dart:convert';

class AttendanceRecord {
  final int aeid;
  final String classCode;
  final String rollNo;
  final int facId;
  final String courseId;
  final String attDate;
  final String attTime;
  final String totHours;
  final String studStatus;
  final String dos;
  final String del;

  AttendanceRecord({
    required this.aeid,
    required this.classCode,
    required this.rollNo,
    required this.facId,
    required this.courseId,
    required this.attDate,
    required this.attTime,
    required this.totHours,
    required this.studStatus,
    required this.dos,
    required this.del,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      aeid: json['AEID'],
      classCode: json['Class'],
      rollNo: json['RollNo'],
      facId: json['FacID'],
      courseId: json['CourseID'],
      attDate: json['AttDate'],
      attTime: json['AttTime'],
      totHours: json['TotHours'],
      studStatus: json['StudStatus'],
      dos: json['DOS'],
      del: json['Del'],
    );
  }
}