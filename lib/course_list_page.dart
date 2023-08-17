import 'package:flutter/material.dart';
import 'package:attandance_viewer/utils/secure_storage_utils.dart';
import 'package:intl/intl.dart';
import 'AttendanceTablePage.dart';
class CourseCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    Color attendanceColor =
    overallPercentage < 85 ? Colors.red : Colors.green;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailsPage(
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
                courseName.length > 40 ? '${courseName.substring(0, 40)}...' : courseName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(height: 8),
              Text(
                'Course ID: ${courseId.length > 9 ? '${courseId.substring(0, 3)}..${courseId.substring(courseId.length - 3)}' : courseId}',
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '$overallPercentage%',
                    style: TextStyle(
                      color: attendanceColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),


                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '$present',
                      ),
                      Text(
                        'present',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '$absent',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'absent',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}
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
                // TableRow(
                //   children: [
                //     TableCell(
                //       child: Text(
                //         'S.No:',
                //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //     TableCell(
                //       child: Text(
                //         '$serialNumber',
                //         style: TextStyle(fontSize: 18),
                //       ),
                //     ),
                //   ],
                // ),
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
    print("it ran");
    // Assuming the function to get data from secure storage is implemented as "getValueFromSecureStorage"
    List<Map<String, dynamic>>? newData = await getDataValueFromSecureStorage("data");

    // Specify the desired CourseID
    String desiredCourseID = "CS3003";
    print("came till if ");
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
                child: DataTable(
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

class CourseListPage extends StatelessWidget {
  final List<Map<String, dynamic>> courses = [
    {
      "S.No": 1,
      "Course ID": "BT5101",
      "Course Name": "Biostatistics",
      "Faculty Name": "Dr. Gowri. A",
      "Total": 42,
      "Present": 38,
      "Absent": 4,
      "No Class": 0,
      "Provisional Approved Leave*": 0,
      "Present %": 90.48,
      "Absent %": 9.52,
      "Approved Leave %*": 0,
      "Percentage": 91,
      "View": ""
    },
    {
      "S.No": 2,
      "Course ID": "CS3006",
      "Course Name": "Artificial Intelligence",
      "Faculty Name": "Dr. Ram Prasad Padhy",
      "Total": 58,
      "Present": 50,
      "Absent": 8,
      "No Class": 0,
      "Provisional Approved Leave*": 0,
      "Present %": 86.21,
      "Absent %": 13.79,
      "Approved Leave %*": 0,
      "Percentage": 87,
      "View": ""
    },
    {
      "S.No": 3,
      "Course ID": "CS3006",
      "Course Name": "Digital Image Processing",
      "Faculty Name": "Dr Masilamani V",
      "Total": 44,
      "Present": 40,
      "Absent": 4,
      "No Class": 0,
      "Provisional Approved Leave*": 0,
      "Present %": 90.91,
      "Absent %": 9.09,
      "Approved Leave %*": 0,
      "Percentage": 91,
      "View": ""
    },
    {
      "S.No": 4,
      "Course ID": "HS3000",
      "Course Name": "Introduction to Biometrics",
      "Faculty Name": "Dr. Rahul Raman",
      "Total": 40,
      "Present": 36,
      "Absent": 4,
      "No Class": 0,
      "Provisional Approved Leave*": 0,
      "Present %": 90,
      "Absent %": 10,
      "Approved Leave %*": 0,
      "Percentage": 90,
      "View": ""
    },
    {
      "S.No": 5,
      "Course ID": "HS3000",
      "Course Name": "Prototyping and Testing",
      "Faculty Name": "Dr. Karthik.C",
      "Total": 16,
      "Present": 16,
      "Absent": 0,
      "No Class": 13,
      "Provisional Approved Leave*": 0,
      "Present %": 100,
      "Absent %": 0,
      "Approved Leave %*": 0,
      "Percentage": 100,
      "View": ""
    },
    {
      "S.No": 6,
      "Course ID": "HS3000",
      "Course Name": "Interaction Design (UX/UI)",
      "Faculty Name": "Mr. VSS Iyer",
      "Total": 14,
      "Present": 14,
      "Absent": 0,
      "No Class": 0,
      "Provisional Approved Leave*": 0,
      "Present %": 100,
      "Absent %": 0,
      "Approved Leave %*": 0,
      "Percentage": 100,
      "View": ""
    },
    {
      "S.No": 7,
      "Course ID": "HS3001",
      "Course Name": "Professional Communication",
      "Faculty Name": "Dr. Parvathy Das",
      "Total": 20,
      "Present": 19,
      "Absent": 1,
      "No Class": 20,
      "Provisional Approved Leave*": 0,
      "Present %": 95,
      "Absent %": 5,
      "Approved Leave %*": 0,
      "Percentage": 95,
      "View": ""
    },
    {
      "S.No": 8,
      "Course ID": "HS3002",
      "Course Name": "Intellectual Property Rights",
      "Faculty Name": "Dr. Jayachandra Bingi",
      "Total": 0,
      "Present": 0,
      "Absent": 0,
      "No Class": 0,
      "Provisional Approved Leave*": 0,
      "Present %": 0,
      "Absent %": 0,
      "Approved Leave %*": 0,
      "Percentage": 0,
      "View": ""
    },
    {
      "S.No": 9,
      "Course ID": "noc23-cs44",
      "Course Name": "Ethical Hacking",
      "Faculty Name": "Prof. Indranil Sengupta",
      "Total": 0,
      "Present": 0,
      "Absent": 0,
      "No Class": 0,
      "Provisional Approved Leave*": 0,
      "Present %": 0,
      "Absent %": 0,
      "Approved Leave %*": 0,
      "Percentage": 0,
      "View": ""
    }
  ]
;
  int threshold=88;
  @override
  Widget build(BuildContext context) {
    int belowThresholdCount = courses
        .where((course) => course['Percentage'] < threshold)
        .toList()
        .length;

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
                final serialNumber = course['S.No'];
                final courseId = course['Course ID'];
                final courseName = course['Course Name'];
                final facultyName = course['Faculty Name'];
                final total = course['Total'];
                final present = course['Present'];
                final absent = course['Absent'];
                final noClass = course['No Class'];
                final provisionalApprovedLeave = course['Provisional Approved Leave*'];
                final presentPercentage = course['Present %'].toDouble();
                final absentPercentage = course['Absent %'].toDouble();
                final approvedLeavePercentage = course['Approved Leave %*'];
                final overallPercentage = course['Percentage'];

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
