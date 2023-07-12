import 'package:flutter/material.dart';

class SelectedDatePage extends StatelessWidget {
  final DateTime selectedDate;

  SelectedDatePage({required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Date'),
      ),
      body: Center(
        child: Text(
          'Selected Date: ${selectedDate.toString()}',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
