import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'qris_payment_page.dart';

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  String _selectedFilter = 'Semua';
  final List<String> _filters = ['Semua', 'Berhasil', 'Pending', 'Gagal'];

  final List<Map<String, dynamic>> _payments = [
    {
      'gym': 'Titanium Fitness Center',
      'type': 'MEMBERSHIP BULANAN',
      'date': '12 Oct 2023 • 19:20',
      'amount': 450000,
      'status': 'Berhasil',
    },
    {
      'gym': 'Elite Performance Hub',
      'type': 'PERSONAL TRAINER 10 SESI',
      'date': 'Sekarang • Menunggu Pembayaran',
      'amount': 2500000,
      'status': 'Pending',
    },
    {
      'gym': 'Oceanic Sport Club',
      'type': 'HARIAN PASS',
      'date': '01 Oct 2023 • 08:15',
      'amount': 75000,
      'status': 'Berhasil',
    },
  ];

  List<Map<String, dynamic>> get _filteredPayments {
    if (_selectedFilter == 'Semua') return _payments;
    return _payments.where((p) => p['status'] == _selectedFilter).toList();
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Berhasil':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Gagal':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'GYMYUK',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFD32F2F),
                      letterSpacing: 2,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.notifications_outlined),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Riwayat\nPembayaran',
                style: GoogleFonts.montserrat(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Pantau semua transaksi membership dan paket latihan Anda.',
                style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),

            // Filter
            SizedBox(
              height: 36,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  final f = _filters[index];
                  final isSelected = _selectedFilter == f;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = f),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFD32F2F)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        f,
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // List pembayaran
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filteredPayments.length,
                itemBuilder: (context, index) {
                  final p = _filteredPayments[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.fitness_center,
                                    size: 18,
                                    color: Color(0xFFD32F2F),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p['gym'],
                                      style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      p['type'],
                                      style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: _statusColor(
                                  p['status'],
                                ).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '● ${p['status']}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: _statusColor(p['status']),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          p['date'],
                          style: GoogleFonts.montserrat(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rp ${_formatPrice(p['amount'] as int)}',
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFFD32F2F),
                              ),
                            ),
                            if (p['status'] == 'Pending')
                              ElevatedButton(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        QrisPaymentPage(payment: p),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD32F2F),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Bayar Sekarang',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            else
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Lihat E-Struk →',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 11,
                                    color: const Color(0xFFD32F2F),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Total pengeluaran
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.bar_chart, color: Colors.blue, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        'Ringkasan Pengeluaran Bulan Ini',
                        style: GoogleFonts.montserrat(
                          fontSize: 11,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Rp 3.025.000',
                        style: GoogleFonts.montserrat(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '+12% vs bulan lalu',
                          style: GoogleFonts.montserrat(
                            fontSize: 9,
                            color: Colors.green,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.headset_mic,
                        color: Color(0xFFD32F2F),
                        size: 16,
                      ),
                      label: Text(
                        'Hubungi Bantuan',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: const Color(0xFFD32F2F),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFD32F2F)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}