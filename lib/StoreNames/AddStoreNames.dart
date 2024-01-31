import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tourlism_root_641463021_1/StoreNames/StoreNames.dart';

class AddStoreNames extends StatefulWidget {
  @override
  _AddStoreNamesState createState() => _AddStoreNamesState();
}

class _AddStoreNamesState extends State<AddStoreNames> {
  final TextEditingController _storeNameController = TextEditingController();
  String _selectedTypeID = ''; // Change the type to String
  List<Map<String, dynamic>> _storeTypes = [];

  @override
  void initState() {
    super.initState();
    fetchStoreTypes();
  }

  Future<void> fetchStoreTypes() async {
    try {
      final response = await http
          .get(Uri.parse("http://localhost:8081/apiTourlist/storetypes.php"));

      if (response.statusCode == 200) {
        setState(() {
          _storeTypes =
              List<Map<String, dynamic>>.from(json.decode(response.body));
        });
      } else {
        print('Failed to load store types. Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching store types: $e');
    }
  }

  void submitForm(BuildContext context) async {
    final String storeName = _storeNameController.text;

    try {
      final String apiUrl = "http://localhost:8081/apiTourlist/storenames.php";
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'StoreName': storeName,
          'TypeID': _selectedTypeID.toString(),
        }),
      );

      if (response.statusCode == 200) {
        // Handle success, e.g., show a success message or navigate back
        Navigator.pop(context);
      } else {
        // Handle error, e.g., show an error message
        print('Failed to add store name. Error ${response.statusCode}');
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
          'เพิ่มร้านค้า',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => StoreNames(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _storeNameController,
              decoration: InputDecoration(labelText: 'Store Name'),
            ),
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

  Widget _buildDropdownButton() {
    return Row(
      children: [
        Text('Select Type:'),
        SizedBox(width: 16.0),
        DropdownButton<String>(
          value: _selectedTypeID.isNotEmpty ? _selectedTypeID : null,
          hint: Text('Select a type'), // Add a hint or initial text
          onChanged: (value) {
            setState(() {
              _selectedTypeID = value ?? '';
            });
          },
          items: _storeTypes.map((storeType) {
            return DropdownMenuItem<String>(
              value: storeType['TypeID'].toString(),
              child: Text(storeType['TypeName'] ?? ''),
            );
          }).toList(),
        ),
      ],
    );
  }
}
