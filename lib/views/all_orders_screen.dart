import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/api_endpoints.dart';
import 'order_details_screen.dart';
import '../utils/order_excel_generator.dart';
import 'widgets/menu_drawer_widget.dart';  // Added the AppDrawer
import 'widgets/notification_drawer_widget.dart'; // Added the NotificationDrawerWidget

class AllOrdersScreen extends StatefulWidget {
  @override
  _AllOrdersScreenState createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic>? ordersList;
  List<String> notifications = []; // Initialize with empty list

  @override
  void initState() {
    super.initState();
    fetchOrdersData();
  }

  Future<void> fetchOrdersData() async {
    try {
      final response = await http.get(Uri.parse(ApiEndpoints.orders));
      if (response.statusCode == 200) {
        setState(() {
          ordersList = jsonDecode(response.body)['orders'];
        });
      } else {
        throw Exception('Failed to load order data');
      }
    } catch (error) {
      print('Error fetching order data: $error');
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Confirmed':
        return Colors.blue;
      case 'Delivered':
        return Colors.green;
      case 'Canceled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),  
      endDrawer: NotificationDrawerWidget(notifications: notifications),  // Pass notifications
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),   
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
      ),
      body: ordersList == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row containing 'All Orders' text and download button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     InkWell(
                        onTap: () {
                          Navigator.pop(context); // Navigate back
                        },
                        child: Text(
                          '﹤ All Orders ', 
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.download),
                        onPressed: () async {
                          await OrderExcelGenerator.downloadOrders();
                        },
                        tooltip: 'Download Orders',
                      ),
                    ],
                  ),
                  SizedBox(height: 16),  // Space between the header and list
                  Expanded(
                    child: ListView.builder(
                      itemCount: ordersList!.length,
                      itemBuilder: (context, index) {
                        final order = ordersList![index];
                        return Card(
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: EdgeInsets.symmetric(vertical: 6.0),
                          child: ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    order['id'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                _buildStatusBadge(order['status']),
                              ],
                            ),
                            trailing: Icon(Icons.more_vert),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (context) => Container(
                                  padding: EdgeInsets.all(16.0),
                                  height: MediaQuery.of(context).size.height * 0.8,
                                  child: OrderDetailsScreen(
                                    orderId: order['id'],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color badgeColor = getStatusColor(status);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: badgeColor),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: badgeColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
