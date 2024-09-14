import 'package:flutter/material.dart';
import '../utils/api_endpoints.dart'; // Ensure this path is correct
import 'all_orders_screen.dart';
import 'widgets/menu_drawer_widget.dart';
import 'widgets/notification_drawer_widget.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMyOrders();
  }

  Future<void> fetchMyOrders() async {
    try {
      final List<dynamic> data = await ApiEndpoints.fetchMyOrders();
      setState(() {
        orders = data; // Directly assign the list of orders
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      // Handle the error
      print('Error fetching my orders: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
        flexibleSpace: Container(
          padding: EdgeInsets.only(top: 45.0),
          child: Center(
            child: Text(
              'My Orders',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      drawer: AppDrawer(), // Add the menu drawer
      endDrawer: NotificationDrawerWidget(notifications: []), // Add the notification drawer with an empty list
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two cards per row
                  crossAxisSpacing: 16.0, // Space between columns
                  mainAxisSpacing: 16.0, // Space between rows
                  childAspectRatio: 1, // Adjust based on height/width of card
                ),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return _buildOrderCard(
                    context,
                    order['count'] ?? 'N/A', // Adjust based on your API response
                    order['status'] ?? 'Unknown', // Adjust based on your API response
                    _getIcon(order['status']), // Implement a function to get the icon
                    _getColor(order['status']), // Implement a function to get the color
                    order['type'] ?? 'allOrders', // Adjust based on your API response
                  );
                },
              ),
            ),
    );
  }

  Widget _buildOrderCard(BuildContext context, String count, String status, IconData icon, Color color, String orderType) {
    return GestureDetector(
      onTap: () {
        if (orderType == 'allOrders') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AllOrdersScreen()), // Navigate to All Orders Screen
          );
        }
        // Add more navigation logic for other order types if needed
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              SizedBox(height: 10),
              Text(
                count,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
              ),
              SizedBox(height: 5),
              Text(
                status,
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIcon(String status) {
    // Map statuses to icons
    switch (status) {
      case 'Draft':
        return Icons.drafts;
      case 'Confirmed':
        return Icons.check_circle;
      case 'Cancelled':
        return Icons.cancel;
      case 'Delivered':
        return Icons.local_shipping;
      case 'Partially Delivered':
        return Icons.local_mall;
      case 'Rescheduled':
        return Icons.calendar_today;
      case 'Failed To Deliver':
        return Icons.error;
      default:
        return Icons.assignment_turned_in;
    }
  }

  Color _getColor(String status) {
    // Map statuses to colors
    switch (status) {
      case 'Draft':
        return Colors.pinkAccent;
      case 'Confirmed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      case 'Delivered':
        return Colors.orange;
      case 'Partially Delivered':
        return Colors.lightGreen;
      case 'Rescheduled':
        return Colors.amber;
      case 'Failed To Deliver':
        return Colors.redAccent;
      default:
        return Colors.blue;
    }
  }
}
