// lib/services/push_notification_service.dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Request notification permissions (iOS only)
    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received: ${message.notification?.title}');
      // Display notification in a Snackbar or Dialog, or use local notifications
      if (message.notification != null) {
        // Display a local notification or Snackbar
        _showNotification(message.notification);
      }
    });

    // Handle background and terminated notifications
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked!');
      _handleNotification(message);
    });

    // Handle notifications when the app is in terminated state
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      _handleNotification(initialMessage);
    }
  }

  // Show notification using a Snackbar or Dialog
  void _showNotification(RemoteNotification? notification) {
    // Implement your notification display logic here
    // Example: Show a Snackbar with the notification content
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(notification?.title ?? 'No title'),
        action: SnackBarAction(
          label: 'View',
          onPressed: () {
            // Handle view action, e.g., navigate to a specific screen
            Navigator.pushNamed(navigatorKey.currentContext!, '/order-details');
          },
        ),
      ),
    );
  }

  // Handle notification click actions
  void _handleNotification(RemoteMessage message) {
    if (message.data['type'] == 'order') {
      // Navigate to order details screen
      Navigator.pushNamed(navigatorKey.currentContext!, '/order-details', arguments: message.data);
    }
  }

  // Subscribe to order status updates
  Future<void> subscribeToOrderUpdates(String orderId) async {
    await _fcm.subscribeToTopic(orderId);
    print('Subscribed to order updates: $orderId');
  }

  // Unsubscribe when no longer needed
  Future<void> unsubscribeFromOrderUpdates(String orderId) async {
    await _fcm.unsubscribeFromTopic(orderId);
    print('Unsubscribed from order updates: $orderId');
  }
}

// You need to provide a global navigator key to use for navigation from service
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
