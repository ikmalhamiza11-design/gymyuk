import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'payment_success_page.dart';

class QrisPaymentPage extends StatefulWidget {
  final Map<String, dynamic> payment;
  const QrisPaymentPage({super.key, required this.payment});

  @override
  State<QrisPaymentPage> createState() => _QrisPaymentPageState();
}

class _QrisPaymentPageState extends State<QrisPaymentPage> {
  late Timer _timer;
  int _secondsLeft = 15 * 60; // 15 menit

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 0) {
        timer.cancel();
        return;
      }
      setState(() => _secondsLeft--);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final m = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final payment = widget.payment;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'GYMYUK',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFD32F2F),
                      letterSpacing: 2,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(Icons.lock_outline, size: 14, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        'Secure Payment',
                        style: GoogleFonts.montserrat(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Order Summary
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ORDER SUMMARY',
                      style: GoogleFonts.montserrat(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue.shade700,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      payment['type'] ?? 'Membership',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      payment['gym'] ?? '',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Payment',
                          style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey.shade700),
                        ),
                        Text(
                          'Rp ${_formatPrice(payment['amount'] as int)}',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFFD32F2F),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Center(
                child: Text(
                  'Scan QRIS untuk menyelesaikan pembayaran',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 16),

              // QR Box
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFD32F2F), width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: CustomPaint(painter: _QrisPatternPainter()),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.access_time, size: 14, color: Colors.orange.shade700),
                    const SizedBox(width: 6),
                    Text(
                      'Expires in $_formattedTime',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Info bawah
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Transaction ID', style: GoogleFonts.montserrat(fontSize: 10, color: Colors.grey)),
                          Text('#GYM${payment.hashCode.toString().substring(0, 5)}', style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Method', style: GoogleFonts.montserrat(fontSize: 10, color: Colors.grey)),
                          Text('QRIS E-Wallet', style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Sistem pembayaran otomatis terdeteksi',
                  style: GoogleFonts.montserrat(fontSize: 11, color: Colors.grey.shade500),
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    payment['status'] = 'Berhasil';
                    payment['date'] = 'Baru saja • Lunas via QRIS';
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PaymentSuccessPage(payment: payment),
                      ),
                    );
                  },
                  icon: const Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
                  label: Text(
                    'Selesai',
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD32F2F),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Bantuan Pembayaran',
                    style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QrisPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = Colors.white;
    final black = Paint()..color = Colors.black;
    canvas.drawRect(Offset.zero & size, white);

    const gridCount = 21;
    final cell = size.width / gridCount;
    const seed = [3, 7, 1, 9, 5, 2, 8, 4, 6, 0];

    for (int row = 0; row < gridCount; row++) {
      for (int col = 0; col < gridCount; col++) {
        if (_inFinderZone(row, col, gridCount)) continue;
        final value = (row * 13 + col * 7 + seed[(row + col) % seed.length]) % 5;
        if (value == 0 || value == 2) {
          canvas.drawRect(Rect.fromLTWH(col * cell, row * cell, cell, cell), black);
        }
      }
    }
    _drawFinder(canvas, cell, 0, 0);
    _drawFinder(canvas, cell, 0, gridCount - 7);
    _drawFinder(canvas, cell, gridCount - 7, 0);
  }

  bool _inFinderZone(int row, int col, int gridCount) {
    final topLeft = row < 7 && col < 7;
    final topRight = row < 7 && col >= gridCount - 7;
    final bottomLeft = row >= gridCount - 7 && col < 7;
    return topLeft || topRight || bottomLeft;
  }

  void _drawFinder(Canvas canvas, double cell, int rowStart, int colStart) {
    final black = Paint()..color = Colors.black;
    final white = Paint()..color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(colStart * cell, rowStart * cell, cell * 7, cell * 7), black);
    canvas.drawRect(Rect.fromLTWH((colStart + 1) * cell, (rowStart + 1) * cell, cell * 5, cell * 5), white);
    canvas.drawRect(Rect.fromLTWH((colStart + 2) * cell, (rowStart + 2) * cell, cell * 3, cell * 3), black);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}