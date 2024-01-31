import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tourlism_root_641463021_1/Busschedule/Addbusschedule.dart';
import 'package:tourlism_root_641463021_1/menu.dart';

class BusSchedule extends StatefulWidget {
  @override
  _BusScheduleState createState() => _BusScheduleState();
}

class _BusScheduleState extends State<BusSchedule> {
  List<Map<String, dynamic>> busSchedules = [];

  @override
  void initState() {
    super.initState();
    fetchBusSchedules();
  }

  Future<void> fetchBusSchedules() async {
    final response =
        await http.get(Uri.parse("http://localhost:8081/apiTourlist/busschedule.php"));

    if (response.statusCode == 200) {
      setState(() {
        busSchedules = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      print('Failed to load bus schedules. Error ${response.statusCode}');
    }
  }

  void navigateToAddBusSchedule() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBusSchedule(),
      ),
    ).then((_) {
      fetchBusSchedules();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ตารางการเดินรถ',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Menu(),
              ),
            );
          },
        ),
      ),
      body: busSchedules.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Table(
                columnWidths: {
                  0: FlexColumnWidth(0.5), // Adjust the column widths as needed
                  1: FlexColumnWidth(1.0),
                },
                border: TableBorder.all(
                  color: Colors.blue,
                  width: 2.0,
                ),
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    children: [
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'สถานที่',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'เวลา',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...busSchedules.map((schedule) {
                    return TableRow(
                      children: [
                        TableCell(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(schedule['PlaceName']),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(schedule['Time']),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddBusSchedule,
        tooltip: 'Add Bus Schedule',
        child: Icon(Icons.add),
      ),
    );
  }
}
