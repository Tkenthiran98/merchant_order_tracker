import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/location_service.dart';

class LocationTrackingScreen extends StatefulWidget {
  final Map<String, dynamic> locationData;

  LocationTrackingScreen({required this.locationData});

  @override
  _LocationTrackingScreenState createState() => _LocationTrackingScreenState();
}

class _LocationTrackingScreenState extends State<LocationTrackingScreen> {
  late LatLng _orderLocation;
  late GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
    final locationService = LocationService();
    _orderLocation = locationService.getLatLngFromLocationData(widget.locationData);
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    // Move the camera to the initial position when the map is created
    _mapController.animateCamera(
      CameraUpdate.newLatLng(_orderLocation),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Location Tracking'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _orderLocation,
          zoom: 14.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId('orderLocation'),
            position: _orderLocation,
            infoWindow: InfoWindow(title: 'Order Location'),
          ),
        },
      ),
    );
  }
}
