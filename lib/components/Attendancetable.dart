import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/secure_storage_utils.dart';

class AttendanceTablePage extends StatefulWidget {
  final String courseId; // Add the courseId parameter to the constructor
  final BuildContext context; // Add the BuildContext parameter

  AttendanceTablePage({
    required this.courseId,
    required this.context, // Pass the BuildContext as a required parameter
  });
  @override
  _AttendanceTablePageState createState() => _AttendanceTablePageState();
}
class _AttendanceTablePageState extends State<AttendanceTablePage> {

  String getSymbolForStudStatus(String studStatus) {
    if (studStatus == '1') {
      return '✔️';
    } else if (studStatus == '0') {
      return '✖️';
    } else {
      return '⚠️';
    }
  }
  List<Map<String, dynamic>> attendanceEntries = [
    {'Attendance Date': '2023-06-10', 'Attendance Time': '09:00 AM', 'Status': '✔️'},
    {'Attendance Date': '2023-06-11', 'Attendance Time': '10:30 AM', 'Status': '❌'},
    {'Attendance Date': '2023-06-12', 'Attendance Time': '08:45 AM', 'Status': '✔️'},
    {'Attendance Date': '2023-06-13', 'Attendance Time': '09:15 AM', 'Status': '✔️'},
    {'Attendance Date': '2023-06-14', 'Attendance Time': '10:00 AM', 'Status': '⚠️'},
    // Add more attendance entries as needed
  ];

  bool showCrossEntries = false;
  bool showWarningEntries = false;
  DateTime? startDate;
  DateTime? endDate;
  bool showFilterOptions = false;
  bool isFilterApplied = false;

  DateTime parseDate(String dateStr) {
    // Split the date string into day, month, and year components
    List<String> dateComponents = dateStr.split('-');
    int day = int.parse(dateComponents[0]);
    int month = int.parse(dateComponents[1]);
    int year = int.parse(dateComponents[2]);

    // Create and return a DateTime object
    return DateTime(year, month, day);
  }
  List<Map<String, dynamic>> filterDataByCourseID(
      List<Map<String, dynamic>> data, String desiredCourseID) {
    List<Map<String, dynamic>> filteredData = [];
    print("running courseid "+desiredCourseID);
    for (var entry in data) {
      if (entry["CourseID"] == desiredCourseID) {
        print(entry["CourseID"]);
        Map<String, dynamic> filteredEntry = {
          "Attendance Date": entry["AttDate"],
          "Attendance Date":  DateFormat('yyyy-MM-dd').format(parseDate(entry['AttDate'])),
          "Attendance Time": entry["AttTime"],
          "Status":getSymbolForStudStatus(entry["StudStatus"]),
        };
        print(filteredEntry );
        filteredData.add(filteredEntry);
        print(filteredData);
      }
    }

    return filteredData;
  }
  Future<List<Map<String, dynamic>>?> getDataFromSecureStorage() async {
    // Assuming the function to get data from secure storage is implemented as "getValueFromSecureStorage"
    List<Map<String, dynamic>>? newData = await getDataValueFromSecureStorage("data");

    // Specify the desired CourseID
    String desiredCourseID = widget.courseId;
    if (newData != null) {
      List<Map<String, dynamic>> filteredData = filterDataByCourseID(newData, desiredCourseID);
      return filteredData;
    }

  }
  List<Map<String, dynamic>> getFilteredEntries() {
    if (!showCrossEntries && !showWarningEntries && startDate == null && endDate == null) {
      return attendanceEntries;
    } else if (showCrossEntries && showWarningEntries) {
      return attendanceEntries.where((entry) =>
      (startDate == null || DateTime.parse(entry['Attendance Date']).isAfter(startDate!)) &&
          (endDate == null || DateTime.parse(entry['Attendance Date']).isBefore(endDate!.add(Duration(days: 1)))) &&
          (entry['Status'] == '❌' || entry['Status'] == '⚠️')
      ).toList();
    } else if (showCrossEntries) {
      return attendanceEntries.where((entry) =>
      (startDate == null || DateTime.parse(entry['Attendance Date']).isAfter(startDate!)) &&
          (endDate == null || DateTime.parse(entry['Attendance Date']).isBefore(endDate!.add(Duration(days: 1)))) &&
          entry['Status'] == '❌'
      ).toList();
    } else if (showWarningEntries) {
      return attendanceEntries.where((entry) =>
      (startDate == null || DateTime.parse(entry['Attendance Date']).isAfter(startDate!)) &&
          (endDate == null || DateTime.parse(entry['Attendance Date']).isBefore(endDate!.add(Duration(days: 1)))) &&
          entry['Status'] == '⚠️'
      ).toList();
    } else {
      return attendanceEntries.where((entry) =>
      (startDate == null || DateTime.parse(entry['Attendance Date']).isAfter(startDate!)) &&
          (endDate == null || DateTime.parse(entry['Attendance Date']).isBefore(endDate!.add(Duration(days: 1))))
      ).toList();
    }
  }
  Future<void> _fetchData() async {
    List<Map<String, dynamic>>? data = await getDataFromSecureStorage();
    attendanceEntries = data!;
    print("attendance entruies $attendanceEntries");
    setState(() {
      attendanceEntries;
    });
    print("Data from secure storage: $data");
  }
  @override
  void initState() {
    super.initState();
    _fetchData();
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: Icon(Icons.calendar_month),
                          label: Text(
                            startDate != null ? startDate!.toString().substring(0, 10) : 'Start Date',
                          ),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2015),
                              lastDate: DateTime(2023, 12, 31),
                            ).then((value) {
                              setState(() {
                                startDate = value;
                              });
                            });
                          },
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: Icon(Icons.calendar_month),
                          label: Text(
                            endDate != null ? endDate!.toString().substring(0, 10) : 'End Date',
                          ),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2015),
                              lastDate: DateTime(2023, 12, 31),
                            ).then((value) {
                              setState(() {
                                endDate = value;
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isFilterApplied ? Icons.filter_alt_off_sharp : Icons.filter_alt_outlined,
                      ),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      isFilterApplied = !isFilterApplied;
                      showFilterOptions = !showFilterOptions;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Visibility(
              visible: showFilterOptions,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('Only Absents'),
                      Switch(
                        value: showCrossEntries,
                        onChanged: (value) {
                          setState(() {
                            showCrossEntries = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Only Leaves'),
                      Switch(
                        value: showWarningEntries,
                        onChanged: (value) {
                          setState(() {
                            showWarningEntries = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child:

                DataTable(
                  columns: [
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Time')),
                    DataColumn(label: Text('Status')),
                  ],
                  rows: getFilteredEntries().map((entry) {
                    return DataRow(
                      cells: [
                        DataCell(Text(entry?['Attendance Date'] ?? '')),
                        DataCell(Text(entry?['Attendance Time'] ?? '')),
                        DataCell(
                          entry?['Status'] == '⚠️'
                              ? Icon(Icons.warning, color: Colors.orange)
                              : Text(
                            entry?['Status'] ?? '',
                            style: TextStyle(
                              color: entry?['Status'] == '✔️' ? Colors.green : Colors.red,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
