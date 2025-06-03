import 'package:ticketing_app/services/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ticketing_app/views/pembayaran.dart';

class TicketPage extends StatelessWidget {
  TicketPage({super.key});

  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'Ticketing App',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getTickets(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List ticketList = snapshot.data!.docs;
            
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: ticketList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = ticketList[index];

                  // mengambil data dari tiap id
                  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                  String category = data['category'];
                  String price = data['price'].toString();
                  String type = data['type'];

                  // menampilkan data
                  return Column(
                    children: [
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tiket untuk $type",
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                category[0].toUpperCase() + category.substring(1), // Capitalize
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Rp. $price",
                                    style: TextStyle(
                                      color: Colors.blue[700],
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => PembayaranPage(
                                          category: category,
                                          price: price,
                                          type: type,
                                        ),
                                      ));
                                    },
                                    icon: const Icon(Icons.shopping_cart, size: 16),
                                    label: const Text(
                                      "Beli",
                                      style: TextStyle(fontFamily: 'Poppins'),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue[700],
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                }
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
        }
      ),
    );
  }
}