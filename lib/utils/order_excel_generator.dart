import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';

class OrderExcelGenerator {
  static Future<void> downloadOrders() async {
    // Request storage permission
    if (await Permission.storage.request().isGranted) {
      // Fetch orders from Firestore
      QuerySnapshot ordersSnapshot =
          await FirebaseFirestore.instance.collection('orders').get();

      // Create an Excel document
      final xlsio.Workbook workbook = xlsio.Workbook();
      final xlsio.Worksheet sheet = workbook.worksheets[0];
      
      // Add column headers
      sheet.getRangeByName('A1').setText('Order ID');
      sheet.getRangeByName('B1').setText('Status');
      sheet.getRangeByName('C1').setText('Total');

      // Fill in data from Firestore
      int row = 2;
      for (var order in ordersSnapshot.docs) {
        sheet.getRangeByName('A$row').setText(order['id']);
        sheet.getRangeByName('B$row').setText(order['status']);
        sheet.getRangeByName('C$row').setNumber(order['total']);
        row++;
      }

      // Save the document to a byte array
      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();

      // Get the path to save the file
      final Directory? directory = await getExternalStorageDirectory();
      
      if (directory != null) {
        final String path = '${directory.path}/orders.xlsx';

        // Write the file to the local storage
        final File file = File(path);
        await file.writeAsBytes(bytes);

        print('Orders Excel file saved to $path');
      } else {
        print('Failed to get external storage directory');
      }
    } else {
      print('Storage permission not granted');
    }
  }
}
