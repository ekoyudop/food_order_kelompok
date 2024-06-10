import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');

  Future<void> saveOrderToDatabase(String receipt) async {
    await orders.add({
      'data': DateTime.now(),
      'order': receipt,
    });
  }

  Future<List<String>> getOrderHistory() async {
    QuerySnapshot querySnapshot =
        await orders.orderBy('timestamp', descending: true).get();
    List<String> receipts =
        querySnapshot.docs.map((doc) => doc['receipt'] as String).toList();
    return receipts;
  }
}
