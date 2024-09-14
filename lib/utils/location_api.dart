// lib/api/location_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationApi {
  final String apiUrl = "https://example.com/location"; // Your API URL

  Future<Map<String, dynamic>> fetchOrderLocation(String orderId) async {
    final response = await http.get(Uri.parse('$apiUrl/$orderId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load location');
    }
  }
}
