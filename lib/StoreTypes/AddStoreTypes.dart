import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddStoreType extends StatelessWidget {
  final TextEditingController _typeNameController = TextEditingController();

  Future<void> submitForm(BuildContext context) async {
    final String typeName = _typeNameController.text;

    // เพิ่มโค้ดที่ต้องการส่งข้อมูลไปยังเซิร์ฟเวอร์

    // ตัวอย่างโค้ดที่เพิ่มข้อมูลประเภทร้านค้า
    final String apiUrl = "http://localhost:8081/apiTourlist/storetypes.php";
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'TypeName': typeName,
      }),
      headers: {
        "Access-Control-Request-Method": "POST",
        "Access-Control-Request-Headers": "content-type",
      },
    );

    if (response.statusCode == 200) {
      // ตัวอย่าง: ให้กลับไปหน้ารายการประเภทร้านค้า
      Navigator.pop(context);
    } else {
      print('Failed to add store type. Error ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'เพิ่มประเภทร้านค้า',
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
            TextField(
              controller: _typeNameController,
              decoration: InputDecoration(labelText: 'Type Name'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                submitForm(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
