import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import '../model/all_state.dart';
import '../service/flight_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MapController _mapController = MapController();
  String? _countryName = 'Germany';
  late LatLng _sw = LatLng(47.40724, 5.98815);
  late LatLng _ne = LatLng(54.9079, 14.98853);
  late List<AllState> allState;
  //late MarkerLayer locationPin;
  //Set<Marker> _markers = {};
  List<Marker> _markers = [];

  List<BoundingCountryBox> boundingList = [
    BoundingCountryBox(
        'MT', 'Malta', LatLng(35.82583, 14.20361), LatLng(36.07222, 14.56701)),
    BoundingCountryBox(
        'GER', 'Germany', LatLng(47.40724, 5.98815), LatLng(54.9079, 14.98853)),
    BoundingCountryBox('ESP', 'Spain', LatLng(27.4335426, -18.3936845),
        LatLng(43.9933088, 4.5918885)),
    BoundingCountryBox('USA', 'United States of America',
        LatLng(24.9493, -125.0011), LatLng(49.5904, -66.9326)),
    BoundingCountryBox('JPN', 'Japan', LatLng(20.2145811, 122.7141744),
        LatLng(45.7112046, 154.205541)),
    BoundingCountryBox('UK', 'United Kongdom', LatLng(49.674, -14.015517),
        LatLng(61.061, 2.0919117)),
  ];

  @override
  void initState() {
    super.initState();
    // setCustomMapPin();
  }

  void handleSelected() {
    allState = []; // Initialize the allState field

    doSetState();
  }

  void doSetState() {
    setState(() {
      _mapController.move(
        LatLng(((_sw.latitude + _ne.latitude) / 2),
            ((_sw.longitude + _ne.longitude) / 2)),
        _mapController.zoom,
      );
      _mapController.fitBounds(
        LatLngBounds(_sw, _ne),
      );
      //_markers = createMarkers(allState) as List<Marker>;
      _fetchFlightData(_mapController);
    });
  } // für den zoom  und zentrierung

  void _fetchFlightData(MapController controller) async {
    _mapController = controller;
    allState = await FlightService().getAllStateBounds(_sw, _ne);
    // Get the current zoom level from the map controller
    double zoom = _mapController.zoom;
    _markers = createMarkers(allState, zoom);
    setState(() {});
  }

  List<Marker> createMarkers(List<AllState> allState, double zoom) {
    allState.forEach((state) {
      final latitude = state.latitude;
      final longitude = state.longitude;

      if (latitude != null && longitude != null) {
        final position = LatLng(latitude, longitude);

        // Calculate the size based on the zoom level
        double size = 80.0;
        if (zoom < 10) {
          size = 40.0;
        } else if (zoom < 15) {
          size = 60.0;
        }

        _markers.add(
          Marker(
            width: size,
            height: size,
            point: position,
            builder: (ctx) => GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(state.callsign!.trim()),
                      // Additional content or actions for the popup
                    );
                  },
                );
              },
              child: Container(
                child: Icon(
                  Icons.airplanemode_on, size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      }
    });

    return _markers;
  }

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
                            boundingList.forEach((element) {
                              if (element.id == value) {
                                _sw = element.sw;
                                _ne = element.ne;
                                _countryName = element.name;
                                handleSelected();
                              }
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
                            DropdownMenuItem(
                              child: Text("United Kingdom"),
                              value: "UK",
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
                          "Air Traffic over $_countryName".toUpperCase(),
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
                        mapController: _mapController,
                        options: MapOptions(
                          center: LatLng(_sw.latitude, _ne.latitude),
                          zoom: 1.5,
                          onPositionChanged:
                              (MapPosition position, bool hasGesture) {
                            // Handle map position changes if needed
                          },
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: ['a', 'b', 'c'],
                          ),

                          MarkerLayer(markers: _markers.toList()),
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
  final LatLng sw;
  final LatLng ne;

  BoundingCountryBox(this.id, this.name, this.sw, this.ne);
}
