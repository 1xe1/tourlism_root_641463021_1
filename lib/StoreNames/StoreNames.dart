import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tourlism_root_641463021_1/StoreNames/AddStoreNames.dart';
import 'package:tourlism_root_641463021_1/menu.dart';

class StoreNames extends StatefulWidget {
  @override
  _StoreNamesState createState() => _StoreNamesState();
}

class _StoreNamesState extends State<StoreNames> {
  List<Map<String, dynamic>> storeNames = [];

  @override
  void initState() {
    super.initState();
    fetchStoreNames();
  }

  Future<void> fetchStoreNames() async {
    final response = await http.get(Uri.parse("http://localhost:8081/apiTourlist/storenames.php"));

    if (response.statusCode == 200) {
      setState(() {
        storeNames = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      print('Failed to load store names. Error ${response.statusCode}');
    }
  }

  void navigateToAddStoreName() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddStoreNames(),
      ),
    ).then((_) {
      fetchStoreNames();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายชื่อร้านค้า',
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
      body: storeNames.isNotEmpty
          ? ListView.builder(
              itemCount: storeNames.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 8.0,
                  margin: EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: ListTile(
                    title: Text(
                      storeNames[index]['StoreName'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    subtitle: Text(
                      'ประเภทร้านค้า: ${storeNames[index]['TypeName']}',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddStoreName,
        tooltip: 'Add StoreName',
        child: Icon(Icons.add),
      ),
    );
  }
}
