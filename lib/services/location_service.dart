import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  // You can add methods to fetch location data from your backend if needed.

  // Example: Convert location data into LatLng
  LatLng getLatLngFromLocationData(Map<String, dynamic> locationData) {
    final double lat = locationData['latitude'];
    final double lng = locationData['longitude'];
    return LatLng(lat, lng);
  }
}
