import 'package:flutter/material.dart';
import 'widgets/order_statistics_widget.dart';
import 'widgets/finance_statistics_widget.dart';
import 'widgets/statistics_widget.dart';
import './widgets/menu_drawer_widget.dart';  

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Open the drawer
            },
          ),
        ),
        title: Column(
          children: [
            SizedBox(height: 30),
            Text(
              'Dashboard',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Notification action
            },
          ),
        ],
      ),
      drawer: AppDrawer(), // Use the custom drawer widget
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OrderStatisticsWidget(),
            SizedBox(height: 20),
            FinanceStatisticsWidget(),
            SizedBox(height: 20),
            StatusStatisticsWidget(),
          ],
        ),
      ),
    );
  }
}
