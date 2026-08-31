import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';

class PaymentSuccessPage extends StatelessWidget {
  final Map<String, dynamic> payment;
  const PaymentSuccessPage({super.key, required this.payment});

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateStr = '${now.day} ${_monthName(now.month)} ${now.year}';

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
                  GestureDetector(
                    onTap: () => Navigator.popUntil(context, (route) => route.isFirst),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check_circle, color: Colors.green.shade600, size: 56),
                ),
              ),
              const SizedBox(height: 20),

              Center(
                child: Text(
                  'Payment Successful',
                  style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(height: 6),
              Center(
                child: Text(
                  'Your transaction has been processed and your\nmembership is now active.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey.shade600),
                ),
              ),
              const SizedBox(height: 28),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    _detailRow('Amount Paid', 'Rp ${_formatPrice(payment['amount'] as int)}', highlight: true),
                    const Divider(height: 20),
                    _detailRow('Date', dateStr),
                    const Divider(height: 20),
                    _detailRow('Transaction ID', 'GYM-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}'),
                    const Divider(height: 20),
                    _detailRow('Payment Method', 'Digital Wallet (QRIS)'),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD32F2F),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    'Go to Dashboard  →',
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Struk berhasil diunduh')),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    'Download Receipt',
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.grey.shade900, const Color(0xFFD32F2F)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Training Now',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            'View your personalized workout plan',
                            style: GoogleFonts.montserrat(color: Colors.white70, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value, {bool highlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey.shade600)),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: highlight ? 16 : 12,
            fontWeight: FontWeight.w700,
            color: highlight ? const Color(0xFFD32F2F) : Colors.black87,
          ),
        ),
      ],
    );
  }

  String _monthName(int m) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[m - 1];
  }
}