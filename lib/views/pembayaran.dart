import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ticketing_app/services/firebase.dart';
import 'package:ticketing_app/views/bukti_pembayaran.dart';

class PembayaranPage extends StatelessWidget {
  final String category;
  final String price;
  final String type;

  static final TextEditingController _controller = TextEditingController();

  const PembayaranPage({
    super.key,
    required this.category,
    required this.price,
    required this.type,
  });

  Future<void> _handlePayment(BuildContext context, String method) async {
    final service = FirestoreService();
    await service.addPayment(type: method, price: price);

    // Navigasi ke halaman bukti pembayaran
    Navigator.pop(context); // tutup dialog
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BuktiPembayaranPage(
          category: category,
          price: price,
          type: method,
          ticketType: type,
        ),
      ),
    );
  }

  void _showCenteredDialog(BuildContext context, Widget child) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        content: child,
      ),
    );
  }

  void _showPaymentInputDialog(BuildContext context, String method) {
    Widget content;

    if (method.contains("Tunai")) {
      content = _buildCashPayment(context, method);
    } else if (method.contains("Kartu Kredit")) {
      content = _buildCreditCardPayment(context, method);
    } else {
      content = _buildQRISPayment(context, method);
    }

    _showCenteredDialog(context, content);
  }

  Widget _buildCashPayment(BuildContext context, String method) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Pembayaran Tunai",
                style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold)),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            )
          ],
        ),
        const SizedBox(height: 16),
        Image.asset('assets/icons/cash.jpg', height: 150),
        const SizedBox(height: 8),
        const Text("Pembayaran Tunai",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        Text(
          "Jika pembayaran telah diterima, klik button konfirmasi pembayaran untuk menyelesaikan transaksi.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _handlePayment(context, method),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[700],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("Konfirmasi Pembayaran"),
        ),
      ],
    );
    }

  Widget _buildCreditCardPayment(BuildContext context, String method) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Pembayaran Kartu Kredit",
                style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold)),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            )
          ],
        ),
        const SizedBox(height: 16),
        Image.asset('assets/icons/card.png', height: 150),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    suffixIcon: TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                        backgroundColor: Colors.blue.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: _controller.text.replaceAll(" ", "")),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Nomor kartu disalin")),
                        );
                      },
                      icon: Icon(Icons.copy, size: 12, color: Colors.blue[700]),
                      label: Text(
                        "Salin",
                        style: TextStyle(fontSize: 11, fontFamily: 'Poppins', color: Colors.blue[700]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text("Transfer Pembayaran",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        const SizedBox(height: 8),
        Text(
          "Pastikan nominal dan tujuan pembayaran sudah benar sebelum melanjutkan.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _handlePayment(context, method),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[700],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("Konfirmasi Pembayaran"),
        ),
      ],
    );
  }

  Widget _buildQRISPayment(BuildContext context, String method) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Pembayaran QRIS",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.blue[700],
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup modal
              },
              icon: const Icon(Icons.close),
            )
          ],
        ),
        const SizedBox(height: 16),
        Image.asset('assets/icons/qris.png', height: 150),
        const SizedBox(height: 8),
        const Text("Scan QR untuk Membayar",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        const SizedBox(height: 8),
        Text(
          "Scan QR di atas dengan e-wallet atau mobile banking untuk scan QR diatas dan selesaikann pembayaran.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _handlePayment(context, method),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[700],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("Konfirmasi Pembayaran"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('d MMMM yyyy', 'id_ID').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        title: const Text("Pembayaran",
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Tagihan
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey[200],
                      child: Image.asset(
                        'assets/icons/tagihan.png',
                        width: 18,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Total Tagihan",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Poppins',
                                  fontSize: 14)),
                          Text("Rp $price",
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Nama Pesanan",
                                  style: TextStyle(fontFamily: 'Poppins')),
                              Text(
                                  "Tiket ${_capitalize(type)} - ${category.toUpperCase()}",
                                  style:
                                      const TextStyle(fontFamily: 'Poppins')),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Tanggal",
                                  style: TextStyle(fontFamily: 'Poppins')),
                              Text(formattedDate,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.grey)),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text("Pilih Metode Pembayaran",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            _buildPaymentOption(context, 'assets/icons/i.png', "Tunai (Cash)"),
            const SizedBox(height: 10),
            _buildPaymentOption(
                context, 'assets/icons/i (1).png', "Kartu Kredit"),
            const SizedBox(height: 10),
            _buildPaymentOption(
                context, 'assets/icons/qris i.png', "QRIS / QR Pay"),

            const SizedBox(height: 24),
            const Text("Punya pertanyaan?",
                style: TextStyle(color: Colors.grey)),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(Icons.help_outline, color: Colors.blue[700]),
                title: const Text(
                  "Hubungi Admin untuk bantuan pembayaran.",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
      BuildContext context, String imagePath, String title) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Image.asset(imagePath, width: 24, height: 24),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        onTap: () => _showPaymentInputDialog(context, title),
      ),
    );
  }

  String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
