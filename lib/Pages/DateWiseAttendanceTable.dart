import 'package:flutter/material.dart';

class DateWiseAttendanceTable extends StatefulWidget {
  final String email;
  final DateTime selectedDate;

  const DateWiseAttendanceTable({Key? key, required this.email, required this.selectedDate}) : super(key: key);

  @override
  State<DateWiseAttendanceTable> createState() => _DateWiseAttendanceTableState();
}

class _DateWiseAttendanceTableState extends State<DateWiseAttendanceTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance Table"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Email: ${widget.email}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              "Selected Date: ${widget.selectedDate.toString()}",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
