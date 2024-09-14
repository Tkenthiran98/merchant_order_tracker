import 'package:flutter/material.dart';

class NotificationDrawerWidget extends StatelessWidget {
  final List<String> notifications;

  const NotificationDrawerWidget({Key? key, required this.notifications}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Drawer header
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Row(
              children: [
                Icon(Icons.notifications, color: Colors.white, size: 30),
                SizedBox(width: 10),
                Text(
                  'Notifications',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Notifications list
          Expanded(
            child: notifications.isEmpty
                ? Center(
                    child: Text(
                      'No new notifications',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.notification_important, color: Colors.blueAccent),
                        title: Text(notifications[index]),
                        onTap: () {
                          // Handle tapping on notification
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Tapped on: ${notifications[index]}')),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
