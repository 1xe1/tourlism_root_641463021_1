import 'package:flutter/material.dart';
import 'package:tourlism_root_641463021_1/Busschedule/Busschedule.dart';
import 'package:tourlism_root_641463021_1/Gettemp/Gettemp.dart';
import 'package:tourlism_root_641463021_1/GoogleMap/gpstracking.dart';
import 'package:tourlism_root_641463021_1/StoreNames/StoreNames.dart';
import 'package:tourlism_root_641463021_1/StoreTypes/StoreTypes.dart';
import 'package:tourlism_root_641463021_1/Tourist/TouristPlaces.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tourlism',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ResponsiveMenuGrid(),
    );
  }
}

class ResponsiveMenuGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
          // Use a larger grid for wider screens
          return GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              MenuItem(
                title: 'สถานที่ท่องเที่ยว',
                icon: Icons.location_on,
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => TouristPlaces(),
                    ),
                  );
                },
              ),
              MenuItem(
                  title: 'ประเภทร้านค้า',
                  icon: Icons.store,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => StoreTypes(),
                      ),
                    );
                  }),
              MenuItem(
                  title: 'ร้านค้า',
                  icon: Icons.shopping_cart,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => StoreNames(),
                      ),
                    );
                  }),
              MenuItem(
                  title: 'ตารางการเดินรถ',
                  icon: Icons.directions_bus,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => BusSchedule(),
                      ),
                    );
                  }),
              MenuItem(
                title: 'GPs',
                icon: Icons.location_on,
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => GPSTracking(),
                    ),
                  );
                },
              ),
              MenuItem(
                  title: 'Gettemp',
                  icon: Icons.thermostat,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HealthTemp(),
                      ),
                    );
                  }),
            ],
          );
        } else {
          // Use a smaller grid for narrower screens
          return GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              MenuItem(
                title: 'สถานที่ท่องเที่ยว',
                icon: Icons.location_on,
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => TouristPlaces(),
                    ),
                  );
                },
              ),
              MenuItem(
                  title: 'ประเภทร้านค้า',
                  icon: Icons.store,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => StoreTypes(),
                      ),
                    );
                  }),
              MenuItem(
                  title: 'ร้านค้า',
                  icon: Icons.shopping_cart,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => StoreNames(),
                      ),
                    );
                  }),
              MenuItem(
                  title: 'ตารางการเดินรถ',
                  icon: Icons.directions_bus,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => BusSchedule(),
                      ),
                    );
                  }),
              MenuItem(
                title: 'GPs',
                icon: Icons.location_on,
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => GPSTracking(),
                    ),
                  );
                },
              ),
              MenuItem(
                  title: 'Gettemp',
                  icon: Icons.thermostat,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HealthTemp(),
                      ),
                    );
                  }),
            ],
          );
        }
      },
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  MenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 50.0, color: Colors.blue),
              SizedBox(height: 8.0),
              Text(
                title,
                style: TextStyle(fontSize: 16.0, color: Colors.blue),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
