import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'dart:developer';
import "course_list_page.dart";
import "package:attandance_viewer/Pages/DateWiseAttendanceTable.dart";

class HeatMapCalendarExample extends StatefulWidget {
  const HeatMapCalendarExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HeatMapCalendarExample();
}

class _HeatMapCalendarExample extends State<HeatMapCalendarExample> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController heatLevelController = TextEditingController();

  bool isOpacityMode = true;

  Map<DateTime, int> heatMapDatasets = {
    DateTime(2023, 07, 11): 8,
    DateTime(2023, 07, 10): 0,
    DateTime(2023, 07, 9): 0,
    DateTime(2023, 07, 8): 1,
    DateTime(2023, 07, 7): 3,
    DateTime(2023, 07, 6): 1,
    DateTime(2023, 07, 5): 10,
    DateTime(2023, 07, 4): 0,
    DateTime(2023, 6, 30): 2,
    DateTime(2023, 6, 29): 5,
    DateTime(2023, 6, 28): 3,
    DateTime(2023, 6, 27): 0,
    DateTime(2023, 6, 26): 7,
    DateTime(2023, 6, 25): 1,
    DateTime(2023, 6, 24): 4,
    DateTime(2023, 6, 23): 6,
    DateTime(2023, 6, 22): 0,
    DateTime(2023, 6, 21): 9,
    DateTime(2023, 6, 20): 0,
    DateTime(2023, 6, 19): 2,
    DateTime(2023, 6, 18): 8,
    DateTime(2023, 6, 17): 3,
    DateTime(2023, 6, 16): 0,
    DateTime(2023, 6, 15): 1,
    DateTime(2023, 6, 14): 7,
    DateTime(2023, 6, 13): 5,
    DateTime(2023, 6, 12): 0,
    DateTime(2023, 6, 11): 4,
    DateTime(2023, 6, 10): 6,
  };

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
    heatLevelController.dispose();
  }

  Widget _textField(final String hint, final TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 20, top: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffe7e7e7), width: 1.0)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF20bca4), width: 1.0)),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          isDense: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('parent view'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Image.asset(
                'images/college_logo.png'), // Replace 'assets/college_logo.png' with your image path
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              elevation: 20,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),

                // HeatMapCalendar
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DateWiseAttendanceTable(
                          email: "example@example.com",
                          selectedDate: DateTime.now(),
                        ),
                      ),
                    );
                  },
                  child: HeatMapCalendar(
                    flexible: true,
                    datasets: heatMapDatasets,
                    colorMode:
                        isOpacityMode ? ColorMode.opacity : ColorMode.color,
                    colorsets: const {
                      1: Colors.red,
                      3: Colors.orange,
                      5: Colors.yellow,
                      7: Colors.green,
                      9: Colors.blue,
                      11: Colors.indigo,
                      13: Colors.purple,
                    },
                    onClick: (value) {
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DateWiseAttendanceTable(
                            email: "example@exaple.com",
                            selectedDate: value,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Card(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildLegendItem(Colors.white, 'Complete Present'),
                      _buildLegendItem(Colors.red[100]!, 'Partial Absent'),
                      _buildLegendItem(Colors.redAccent, 'Complete Absent'),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.info_outline, size: 16),
                          SizedBox(width: 8),
                          Text(
                            'Click a date to view its attendance details.',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseListPage(),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.all(20),
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        "Subject wise attendance",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: color,
              border: Border.all(
                color: Colors.black26,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
