import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MapController mapController = MapController();
  String? countryName;
  LatLng sw;
  LatLng ne;

  List<BoundingCountryBox> boundingList = [
    BoundingCountryBox('MT', 'Malta', LatLng(35.8, 14.2) as String,
        LatLng(36.1, 14.6) as String),
    BoundingCountryBox(
        'Ger',
        'Germany',
        LatLng(47.2701114, 5.8663153) as String,
        LatLng(55.099161, 15.0419319) as String),
    BoundingCountryBox(
        'ESP',
        'Spain',
        LatLng(27.4335426, -18.3936845) as String,
        LatLng(43.9933088, 4.5918885) as String),
    BoundingCountryBox(
        'USA',
        'United States of America',
        LatLng(24.9493, -125.0011) as String,
        LatLng(49.5904, -669326) as String),
    BoundingCountryBox(
        'JPN',
        'Japan',
        LatLng(20.2145811, 122.7141744) as String,
        LatLng(45.7112046, 154.205541) as String),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/maltaair1.jpg"),
                alignment: Alignment.centerLeft,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Flight Radar'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.orange[800],
                        ),
                      ),
                      Text(
                        'Real-time flight tracker'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.orange[800],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 30),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Select country",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              countryName = value;
                            });
                          },
                          items: [
                            DropdownMenuItem(
                              child: Text("Malta"),
                              value: "MT",
                            ),
                            DropdownMenuItem(
                              child: Text("Germany"),
                              value: "GER",
                            ),
                            DropdownMenuItem(
                              child: Text("Spain"),
                              value: "ESP",
                            ),
                            DropdownMenuItem(
                              child: Text("United State of America"),
                              value: "USA",
                            ),
                            DropdownMenuItem(
                              child: Text("Japan"),
                              value: "JPN",
                            ),
                            // Other DropdownMenuItem entries
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Air Traffic over $countryName".toUpperCase(),
                          style: TextStyle(
                            color: Colors.orange[900],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Total flights 123".toUpperCase(),
                          style: TextStyle(
                            color: Colors.orange[900],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 500,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      child: FlutterMap(
                        options: MapOptions(
                          center: LatLng(49.674, 2.0919),
                          zoom: 6,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: ['a', 'b', 'c'],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BoundingCountryBox {
  final String id;
  final String name;
  final String sw;
  final String ne;

  BoundingCountryBox(this.id, this.name, this.sw, this.ne);
}
