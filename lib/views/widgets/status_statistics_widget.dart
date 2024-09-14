import 'package:flutter/material.dart';
import 'menu_drawer_widget.dart';  

class DetailedStatusStatisticsWidget extends StatelessWidget {
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
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification button press
            },
          ),
        ],
      ),
      drawer: AppDrawer(), // Use the shared drawer here
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
           children: [
                     InkWell(
                        onTap: () {
                          Navigator.pop(context); // Navigate back
                        },
                        child: Text(
                          '< Status Statistics ', 
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                      ),
            SizedBox(height: 20),
            _buildStatisticsCards(),
            SizedBox(height: 20),
            _buildExpandableStatusList(),
            SizedBox(height: 20),
            _buildSeeMoreButton(),
            Spacer(),
            Text(
              'Powered by curfox.lk',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build the statistics cards
  Widget _buildStatisticsCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildCard(
          title: 'No of Orders',
          value: '76',
          icon: Icons.shopping_cart_outlined,
        ),
        _buildCard(
          title: 'Delivery Charge',
          value: '50371.50',
          icon: Icons.attach_money,
        ),
      ],
    );
  }

  // Widget for each card in the statistics
  Widget _buildCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 40, color: Colors.blue),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // Widget to build the expandable status list
  Widget _buildExpandableStatusList() {
    return Column(
      children: [
        _buildStatusTile('Picked Up', Colors.green),
        _buildStatusTile('Confirmed', Colors.green),
        _buildStatusTile('Cancelled', Colors.red),
        _buildStatusTile('Delivered', Colors.blue),
        _buildStatusTile('Partially Delivered', Colors.lightBlueAccent),
      ],
    );
  }

  // Widget for each status tile
  Widget _buildStatusTile(String status, Color iconColor) {
    return ExpansionTile(
      title: Row(
        children: [
          Icon(Icons.circle, color: iconColor, size: 16),
          SizedBox(width: 10),
          Text(status),
        ],
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Additional details for $status'),
        ),
      ],
    );
  }

  // Widget to build the "See More" button
  Widget _buildSeeMoreButton() {
    return GestureDetector(
      onTap: () {
        // Handle "See More" action
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'See more',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(Icons.arrow_drop_down, color: Colors.blue),
        ],
      ),
    );
  }
}
