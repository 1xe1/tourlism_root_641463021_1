import 'package:flutter/material.dart';
import 'package:tourlism_root_641463021_1/Tourist/TouristPlaces.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddTourist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'เพิ่มข้อมูลสถานที่ท่องเที่ยว',
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
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => TouristPlaces(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TouristPlaceForm(),
      ),
    );
  }
}

class TouristPlaceForm extends StatefulWidget {
  @override
  _TouristPlaceFormState createState() => _TouristPlaceFormState();
}

class _TouristPlaceFormState extends State<TouristPlaceForm> {
  final TextEditingController _placeNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  void submitForm() async {
    final String placeName = _placeNameController.text;
    final String description = _descriptionController.text;
    final double latitude = double.parse(_latitudeController.text);
    final double longitude = double.parse(_longitudeController.text);

    // Send data to the server
    final String apiUrl = "http://localhost:8081/apiTourlist/touristplaces.php";
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'PlaceName': placeName,
        'Description': description,
        'Latitude': latitude,
        'Longitude': longitude,
      }),
      headers: {
        "Access-Control-Request-Method": "POST",
        "Access-Control-Request-Headers": "content-type",
      },
    );
    
    if (response.statusCode == 200) {
      // Handle success, e.g., show a success message or navigate back
      Navigator.pop(context);
    } else {
      // Handle error, e.g., show an error message
      print('Failed to add tourist place. Error ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _placeNameController,
          decoration: InputDecoration(labelText: 'Place Name'),
        ),
        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(labelText: 'Description'),
        ),
        TextField(
          controller: _latitudeController,
          decoration: InputDecoration(labelText: 'Latitude'),
        ),
        TextField(
          controller: _longitudeController,
          decoration: InputDecoration(labelText: 'Longitude'),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            // Call the submitForm function when the button is pressed
            submitForm();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}