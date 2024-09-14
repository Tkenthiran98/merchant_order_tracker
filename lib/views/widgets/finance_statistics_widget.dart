import 'package:flutter/material.dart';
import 'order_statistics_widget.dart';

class FinanceStatisticsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Finance Statistics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StatItem(icon: Icons.attach_money, label: 'Invoice Value', value: '234.1k'),
                StatItem(icon: Icons.pending, label: 'Pending Invoice', value: '122.3k'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StatItem(icon: Icons.money_off, label: 'Paid Invoice', value: '678.7k'),
                StatItem(icon: Icons.approval, label: 'Approved Invoice', value: '101.1k'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
