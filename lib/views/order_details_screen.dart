import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/api_endpoints.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;

  OrderDetailsScreen({required this.orderId});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  Map<String, dynamic>? orderDetails;

  @override
  void initState() {
    super.initState();
    fetchOrderDetails();
  }

  Future<void> fetchOrderDetails() async {
    try {
      // Fetch all orders
      final response = await http.get(Uri.parse(ApiEndpoints.orders));
      if (response.statusCode == 200) {
        List<dynamic> orders = jsonDecode(response.body)['orders']; // Parse as List
        // Find the specific order by ID
        final order = orders.firstWhere(
          (order) => order['id'] == widget.orderId,
          orElse: () => null, // Provide a default value in case no order is found
        );
        if (order != null) {
          setState(() {
            orderDetails = order; // Store the order details if found
          });
        } else {
          throw Exception('Order not found');
        }
      } else {
        throw Exception('Failed to load order details');
      }
    } catch (error) {
      print('Error fetching order details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: orderDetails == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ID: ${orderDetails!['id']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Customer: ${orderDetails!['customerName']}'),
                  Text('Email: ${orderDetails!['customerEmail']}'),
                  Text('Total: \$${orderDetails!['total']}'),
                  Text('Status: ${orderDetails!['status']}'),
                  Text('Order Date: ${orderDetails!['createdAt']}'),
                  SizedBox(height: 20),
                  Text('Items:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: orderDetails!['items'].length,
                      itemBuilder: (context, index) {
                        final item = orderDetails!['items'][index];
                        return ListTile(
                          title: Text(item['itemName']),
                          subtitle: Text('Quantity: ${item['quantity']}'),
                          trailing: Text('\$${item['price']}'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

// Function to trigger the modal popup
void showOrderDetails(BuildContext context, String orderId) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Ensures the bottom sheet can be scrolled if content is long
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.8, // Adjust height as necessary
        child: OrderDetailsScreen(orderId: orderId),
      );
    },
  );
}
