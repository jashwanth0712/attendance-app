import 'package:flutter/material.dart';

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
            Text(
              'S.No: $serialNumber',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Course ID: $courseId'),
            SizedBox(height: 8),
            Text('Course Name: $courseName'),
            SizedBox(height: 8),
            Text('Faculty Name: $facultyName'),
            SizedBox(height: 8),
            Text('Total: $total'),
            SizedBox(height: 8),
            Text('Present: $present'),
            SizedBox(height: 8),
            Text('Absent: $absent'),
            SizedBox(height: 8),
            Text('No Class: $noClass'),
            SizedBox(height: 8),
            Text('Provisional Approved Leave*: $provisionalApprovedLeave'),
            SizedBox(height: 8),
            Text('Present Percentage: $presentPercentage%'),
            SizedBox(height: 8),
            Text('Absent Percentage: $absentPercentage%'),
            SizedBox(height: 8),
            Text('Approved Leave Percentage*: $approvedLeavePercentage%'),
            SizedBox(height: 8),
            Text('Overall Percentage: $overallPercentage%'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceTablePage(),
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
  @override
  _AttendanceTablePageState createState() => _AttendanceTablePageState();
}

class _AttendanceTablePageState extends State<AttendanceTablePage> {
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
                              firstDate: DateTime(2023),
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
                              firstDate: DateTime(2023),
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
                            showWarningEntries = value ?? false;
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
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Time')),
                    DataColumn(label: Text('Status')),
                  ],
                  rows: getFilteredEntries().map((entry) {
                    return DataRow(
                      cells: [
                        DataCell(Text(entry['Attendance Date'])),
                        DataCell(Text(entry['Attendance Time'])),
                        DataCell(
                          entry['Status'] == '⚠️'
                              ? Icon(Icons.warning, color: Colors.orange)
                              : Text(
                            entry['Status'],
                            style: TextStyle(
                              color: entry['Status'] == '✔️' ? Colors.green : Colors.red,
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
      "Course ID": "CS2012",
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
      "Course ID": "CS5102",
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
      "Course ID": "CS5104",
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
      "Course ID": "DS3001",
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
      "Course ID": "DS5011",
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

void main() {
  runApp(MaterialApp(
    home: CourseListPage(),
  ));
}
