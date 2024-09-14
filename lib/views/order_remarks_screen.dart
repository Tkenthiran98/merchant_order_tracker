import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderRemarksScreen extends StatelessWidget {
  final String orderId;

  OrderRemarksScreen({required this.orderId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController remarkController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Remarks'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('orders')
                  .doc(orderId)
                  .collection('remarks')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView(
                  children: snapshot.data!.docs.map((remark) {
                    return ListTile(
                      title: Text(remark['text']),
                      subtitle: Text(remark['timestamp'].toDate().toString()),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: remarkController,
                    decoration: InputDecoration(
                      labelText: 'Add a remark',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    if (remarkController.text.isNotEmpty) {
                      await FirebaseFirestore.instance
                          .collection('orders')
                          .doc(orderId)
                          .collection('remarks')
                          .add({
                        'text': remarkController.text,
                        'timestamp': Timestamp.now(),
                      });
                      remarkController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
