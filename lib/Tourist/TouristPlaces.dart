import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tourlism_root_641463021_1/Tourist/AddTourist.dart';
import 'package:tourlism_root_641463021_1/menu.dart';

class TouristPlaces extends StatefulWidget {
  @override
  _TouristPlacesState createState() => _TouristPlacesState();
}

class _TouristPlacesState extends State<TouristPlaces> {
  List<Map<String, dynamic>> touristPlaces = [];

  @override
  void initState() {
    super.initState();
    fetchTouristPlaces();
  }

  Future<void> fetchTouristPlaces() async {
    final response = await http.get(Uri.parse("http://localhost:8081/apiTourlist/touristplaces.php"));

    if (response.statusCode == 200) {
      setState(() {
        touristPlaces = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      print('Failed to load tourist places. Error ${response.statusCode}');
    }
  }

  Future<void> navigateToAddTouristPlace() async {
    // Navigate to the screen where the user can add a new tourist place
    await Navigator.push(context, MaterialPageRoute(builder: (context) => AddTourist()));

    // After returning from AddTourist screen, refresh the list
    await fetchTouristPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สถานที่ท่องเที่ยว',
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
                builder: (context) => Menu(),
              ),
            );
          },
        ),
      ),
      body: touristPlaces.isNotEmpty
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 8.0, // Spacing between columns
                mainAxisSpacing: 8.0, // Spacing between rows
              ),
              itemCount: touristPlaces.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Handle item click if needed
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'สถานที่: ${touristPlaces[index]['PlaceName']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            'รายละเอียด: ${touristPlaces[index]['Description']}',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            'Latitude: ${touristPlaces[index]['Latitude']}',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            'Longitude: ${touristPlaces[index]['Longitude']}',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
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
        onPressed: navigateToAddTouristPlace,
        tooltip: 'Add Tourist Place',
        child: Icon(Icons.add),
      ),
    );
  }
}
