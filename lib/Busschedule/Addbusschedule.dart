import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddBusSchedule extends StatefulWidget {
  @override
  _AddBusScheduleState createState() => _AddBusScheduleState();
}

class _AddBusScheduleState extends State<AddBusSchedule> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedPlaceID = '';
  List<Map<String, dynamic>> _touristPlaces = [];

  @override
  void initState() {
    super.initState();
    fetchTouristPlaces();
  }

  Future<void> fetchTouristPlaces() async {
    try {
      final response = await http.get(
          Uri.parse("http://localhost:8081/apiTourlist/touristplaces.php"));

      if (response.statusCode == 200) {
        setState(() {
          _touristPlaces =
              List<Map<String, dynamic>>.from(json.decode(response.body));
        });
      } else {
        print('Failed to load tourist places. Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching tourist places: $e');
    }
  }

  void submitForm(BuildContext context) async {
    final String time = _selectedTime.format(context);

    try {
      final String apiUrl = "http://localhost:8081/apiTourlist/busschedule.php";
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'Time': time,
          'PlaceID': _selectedPlaceID.toString(),
        }),
      );

      if (response.statusCode == 200) {
        // Handle success, e.g., show a success message or navigate back
        Navigator.pop(context);
      } else {
        // Handle error, e.g., show an error message
        print('Failed to add bus schedule. Error ${response.statusCode}');
      }
    } catch (e) {
      // Handle other exceptions
      print('Error submitting form: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Bus Schedule',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTimePicker(),
            SizedBox(height: 16.0),
            _buildDropdownButton(),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Call the submitForm function when the button is pressed
                submitForm(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return Row(
      children: [
        Text('Select Time:'),
        SizedBox(width: 16.0),
        ElevatedButton(
          onPressed: () {
            _showTimePicker(context);
          },
          child: Text(_selectedTime.format(context)),
        ),
      ],
    );
  }

  void _showTimePicker(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Widget _buildDropdownButton() {
    return Row(
      children: [
        Text('Select Place:'),
        SizedBox(width: 16.0),
        DropdownButton<String>(
          value: _selectedPlaceID.isNotEmpty ? _selectedPlaceID : null,
          hint: Text('Select a place'), // Add a hint or initial text
          onChanged: (value) {
            setState(() {
              _selectedPlaceID = value ?? '';
            });
          },
          items: _touristPlaces.map((touristPlace) {
            return DropdownMenuItem<String>(
              value: touristPlace['PlaceID'].toString(),
              child: Text(touristPlace['PlaceName'] ?? ''),
            );
          }).toList(),
        ),
      ],
    );
  }
}
