import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiEndpoints {
  // Base URLs
  static const String ordersBaseUrl = 'https://f04b61b5-b2c9-4e62-a542-eb4f7de75cb4.mock.pstmn.io';
  static const String myOrdersBaseUrl = 'https://0ca3a04c-8c75-4458-b897-3b4e59e985ef.mock.pstmn.io';

  // Endpoints
  static const String orders = '$ordersBaseUrl/orders';
  static const String myOrders = '$myOrdersBaseUrl/myorders';

  // GET request to fetch orders
  static Future<Map<String, dynamic>> fetchOrders() async {
    try {
      final response = await http.get(Uri.parse(orders)); // Use the orders endpoint

      if (response.statusCode == 200) {
        return json.decode(response.body); // Decode response as Map<String, dynamic>
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (error) {
      throw Exception('Error fetching orders: $error');
    }
  }

  // POST request to create a new order
  static Future<void> postOrder(Map<String, dynamic> orderData) async {
    try {
      final response = await http.post(
        Uri.parse(orders), // Use the orders endpoint
        headers: {'Content-Type': 'application/json'},
        body: json.encode(orderData),
      );

      if (response.statusCode == 201) {
        print('Order posted successfully');
      } else {
        throw Exception('Failed to post order');
      }
    } catch (error) {
      throw Exception('Error posting order: $error');
    }
  }

  // GET request to fetch my orders
static Future<List<dynamic>> fetchMyOrders() async {
  try {
    final response = await http.get(Uri.parse(myOrders)); // Use the myorders endpoint

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('orderCategories') && data['orderCategories'] is List<dynamic>) {
        return data['orderCategories']; // Extract the list of order categories
      } else {
        throw Exception('Invalid data format: Missing or invalid orderCategories key');
      }
    } else {
      throw Exception('Failed to load my orders');
    }
  } catch (error) {
    throw Exception('Error fetching my orders: $error');
  }
}

}
