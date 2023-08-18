import 'package:flutter/material.dart';

import '../utils/secure_storage_utils.dart';

class DateWiseAttendanceTable extends StatefulWidget {
  final String email;
  final DateTime selectedDate;

  const DateWiseAttendanceTable({Key? key, required this.email, required this.selectedDate}) : super(key: key);

  @override
  State<DateWiseAttendanceTable> createState() => _DateWiseAttendanceTableState();
}

class _DateWiseAttendanceTableState extends State<DateWiseAttendanceTable> {
  List<Map<String, dynamic>> attendancedata = [];
  void initState() {
    super.initState();
    fetchAttendanceData();
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
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredData = attendancedata.where((entry) {
      return entry['AttDate'] == widget.selectedDate.toString().substring(0, 10);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance Table"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    'Selected Date: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // You can also apply other styles like color, font size, etc. here
                    ),
                  ),
                  Text(
                    widget.selectedDate.toString().substring(0, 10),
                    style: TextStyle(
                      // Apply any styles you want for the date here
                    ),
                  ),
                ],
              ),
            ),

            DataTable(
              columns: [
                DataColumn(label: Text('Course ID')),
                DataColumn(label: Text('Time')),
                DataColumn(label: Text('Status')),
              ],
              rows: filteredData.map((entry) {
                return DataRow(
                  cells: [
                    DataCell(Text(entry['CourseID'])),
                    DataCell(Text(entry['AttTime'])),
                    DataCell(Text(entry['StudStatus'])),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}