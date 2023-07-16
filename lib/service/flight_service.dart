import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import '../model/all_state.dart';

class FlightService {
  Future<List<AllState>> getAllStateBounds(LatLng sw, LatLng ne) async {
    final String url =
        'https://opensky-network.org/api/states/all?lamin=${sw.latitude.toString()}&lomin=${sw.longitude.toString()}&lamax=${ne.latitude.toString()}&lomax=${ne.longitude.toString()}';
    try {
      print('Request URL: $url');

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<AllState> allStates = (data['states'] as List<dynamic>)
            .map((e) => AllState.fromJson(e))
            .toList();

        print('Fetched data: $allStates');


        // We return only the first 350 flights
        if (allStates.length > 250) {
          return allStates.toList().sublist(0, 250);
        }

        return allStates;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error: $error');
      return [];
    }
  }
}
