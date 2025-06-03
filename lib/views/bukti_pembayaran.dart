import 'package:flutter/material.dart';

class BuktiPembayaranPage extends StatefulWidget {
  final String type;
  final String category;
  final String price;
  final String ticketType;

  const BuktiPembayaranPage({
    super.key,
    required this.type,
    required this.category,
    required this.price,
    required this.ticketType,
  });

  @override
  State<BuktiPembayaranPage> createState() => _BuktiPembayaranPageState();
}

class _BuktiPembayaranPageState extends State<BuktiPembayaranPage> {
  bool _isDownloaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Bukti Pembayaran",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_isDownloaded) ...[ //pengecekan beberapa widget
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FFF4),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFA0F0BC), width: 1.5),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green[700]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Bukti pembayaran berhasil di unduh!",
                        style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xFFE0ECFF),
                      child: Icon(Icons.check, color: Colors.blue[700], size: 32),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Pembayaran Berhasil",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Transaksi kamu telah selesai.\nDetail pembelian ada di bawah ini.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tiket untuk ${widget.ticketType}", //Di StatefulWidget (State)	Harus widget.type karena bukan field milik classnya sendiri
                                    style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                                  ),
                                  Text(widget.category, style: const TextStyle(color: Colors.grey, fontFamily: 'Poppins')),
                                ],
                              ),
                              Text(
                                "Rp. ${widget.price}",
                                style: const TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Total Pembayaran", style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
                              Text("Rp. ${widget.price}", style: TextStyle(color: Colors.blue[700], fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Divider(height: 24),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              side: const BorderSide(color: Colors.blue, width: 1.5),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Kembali", style: TextStyle(color: Colors.blue, fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[700],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () {
                              setState(() {
                                _isDownloaded = true;
                              });
                            },
                            child: const Text("Unduh bukti", style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
