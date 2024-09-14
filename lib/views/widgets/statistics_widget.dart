import 'package:flutter/material.dart';
import 'status_statistics_widget.dart'; // Import the newly renamed file

class StatusStatisticsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  Icons.bar_chart,
                  size: 40,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Status Statistics',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the detailed status statistics view
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailedStatusStatisticsWidget(),
                    ),
                  );
                },
                child: Text('Show Details'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
