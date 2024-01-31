import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tourlism_root_641463021_1/StoreNames/AddStoreNames.dart';
import 'package:tourlism_root_641463021_1/menu.dart';

class StoreTypes extends StatefulWidget {
  @override
  _StoreTypesState createState() => _StoreTypesState();
}

class _StoreTypesState extends State<StoreTypes> {
  List<Map<String, dynamic>> storeTypes = [];

  @override
  void initState() {
    super.initState();
    fetchStoreTypes();
  }

  Future<void> fetchStoreTypes() async {
    final response = await http
        .get(Uri.parse("http://localhost:8081/apiTourlist/storetypes.php"));

    if (response.statusCode == 200) {
      setState(() {
        storeTypes =
            List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      print('Failed to load store types. Error ${response.statusCode}');
    }
  }

  void navigateToAddStoreTpye() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddStoreNames(), // สร้างหน้า AddStoreType ไว้แล้ว
      ),
    ).then((_) {
      // เมื่อกลับมาจากหน้า AddStoreType ให้เรียกใหม่เพื่อโหลดข้อมูล
      fetchStoreTypes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ประเภทร้านค้า',
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
                builder: (context) => Menu(),
              ),
            );
          },
        ),
      ),
      body: storeTypes.isNotEmpty
          ? ListView.builder(
              itemCount: storeTypes.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4.0,
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(storeTypes[index]['TypeName']),
                    subtitle: Text('Type ID: ${storeTypes[index]['TypeID']}'),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddStoreTpye,
        tooltip: 'Add StoreTpye',
        child: Icon(Icons.add),
      ),
    );
  }
}
