import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Stream<QuerySnapshot> getTickets() {
    return FirebaseFirestore.instance.collection('tickets').snapshots();
  }

  Future<void> addPayment({required String type, required String price}) async {
    FirebaseFirestore.instance.collection('payment').add({
      'type': type.toLowerCase(),
      'price': price,
      'timestamp': Timestamp.now(),
    });
  }
}