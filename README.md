 
## Project Overview

This Flutter application is designed to provide insights about the shipping progress of customer orders. The app includes functionality for tracking order locations, managing orders, and receiving push notifications. The project adheres to the provided Figma design file and includes both UI and functionalities as outlined.

## Live Demo

You can access the demo of the application (https://github.com/Tkenthiran98/merchant_order_tracker.git).


## Postman Mock server API Endpoints

- **Orders Base URL:** `https://f04b61b5-b2c9-4e62-a542-eb4f7de75cb4.mock.pstmn.io`
- **My Orders Base URL:** `https://0ca3a04c-8c75-4458-b897-3b4e59e985ef.mock.pstmn.io`

## Login Details

To log in, use the following credentials:

- **Email:** `test@gemail.com`
- **Password:** `123456789`

## File Structure

The project is structured as follows:

```
lib
├── firebase_options.dart
├── main.dart
├── repositories
│   ├── auth_repository.dart
│   ├── notification_repository.dart
│   └── order_repository.dart
├── services
│   ├── firebase_service.dart
│   ├── location_service.dart
│   └── push_notification_service.dart
├── utils
│   ├── api_endpoints.dart
│   ├── constants.dart
│   ├── fetch_and_post_order.dart
│   ├── location_api.dart
│   ├── order_excel_generator.dart
│   └── validators.dart
├── views
│   ├── all_orders_screen.dart
│   ├── dashboard_screen.dart
│   ├── location_tracking_screen.dart
│   ├── login_screen.dart
│   ├── logout.dart
│   ├── orders_screen.dart
│   ├── order_details_screen.dart
│   ├── order_remarks_screen.dart
│   └── order_tracking_screen.dart
└── widgets
    ├── finance_statistics_widget.dart
    ├── menu_drawer_widget.dart
    ├── notification_drawer_widget.dart
    ├── order_statistics_widget.dart
    ├── remarks_widget.dart
    ├── statistics_widget.dart
    └── status_statistics_widget.dart
```Vedio 
   Screenshots

##Features Implemented

1. **Login Screen:** 
   - Loading page with the merchant logo.
   - Login functionality using email and password.

2. **Dashboard View:**
   - Widgets for order statistics, finance statistics, and status statistics.

3. **Orders Section:**
   - View orders by status.
   - Download orders as Excel files.
   - View and add remarks to orders.

4. **Order Location Tracking:**
   - Integration with Google Maps API to track order location.

5. **Push Notifications:**
   - Implemented push notifications using Firebase Services for order status updates.
 
## Setup and Installation

1. **Clone the Repository:**
 
   git clone https://github.com/Tkenthiran98/merchant_order_tracker.git
   

2. **Navigate to the Project Directory:**
 
   cd merchant_order_tracker
 

3. **Install Dependencies:**
 
   flutter pub get
   ```

4. **Set Up Firebase:**
   - Follow the instructions provided in the (https://firebase.google.com/docs/flutter/setup).

5. **Run the Application:**
 
   flutter run
 

## Screenshots

![Login Screen](screenshots/login_screen.png)
![Dashboard](screenshots/dashboard.png)
![Order Location Tracking](screenshots/location_tracking.png)

## Video Demo

You can view the demo video of the application from video file.
 