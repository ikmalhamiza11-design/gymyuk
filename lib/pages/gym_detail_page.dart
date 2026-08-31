import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'qris_payment_page.dart';

class GymDetailPage extends StatefulWidget {
  final Map<String, dynamic> gym;

  const GymDetailPage({super.key, required this.gym});

  @override
  State<GymDetailPage> createState() => _GymDetailPageState();
}

class _GymDetailPageState extends State<GymDetailPage> {
  String _selectedMembership = 'annual';

  @override
  Widget build(BuildContext context) {
    final gym = widget.gym;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroImage(gym),
            _buildGymInfo(gym),
            _buildActionButtons(context),
            const Divider(height: 32),
            _buildFacilities(),
            const Divider(height: 32),
            _buildMembershipOptions(),
            const Divider(height: 32),
            _buildAboutClub(gym),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroImage(Map<String, dynamic> gym) {
    return Stack(
      children: [
        Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            color: gym['color'] as Color,
            gradient: LinearGradient(
              colors: [
                (gym['color'] as Color),
                (gym['color'] as Color).withOpacity(0.6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Center(
            child: Icon(Icons.fitness_center, color: Colors.white24, size: 80),
          ),
        ),

        // Back button & notif
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'GYMYUK',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Badge Klub Premium
        Positioned(
          bottom: 60,
          left: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFD32F2F),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'KLUB PREMIUM',
              style: GoogleFonts.montserrat(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),

        // Nama gym di atas foto
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                gym['name'],
                style: GoogleFonts.montserrat(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Colors.white70,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${gym['location']}, Jawa Barat',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGymInfo(Map<String, dynamic> gym) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 16),
          const SizedBox(width: 4),
          Text(
            '${gym['rating']}',
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '• ${gym['location']}',
            style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                size: 16,
                color: Color(0xFFD32F2F),
              ),
              label: Text(
                'Kembali',
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFD32F2F),
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
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                final gym = widget.gym;
                final isAnnual = _selectedMembership == 'annual';

                // Data pembayaran yang dikirim ke halaman QRIS,
                // menyesuaikan membership yang dipilih user.
                final payment = {
                  'type': isAnnual
                      ? 'Keanggotaan Tahunan'
                      : 'Komitmen Bulanan',
                  'gym': gym['name'],
                  'amount': isAnnual ? 4500000 : 450000,
                  'status': 'Menunggu Pembayaran',
                  'date': 'Baru saja',
                };

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QrisPaymentPage(payment: payment),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD32F2F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Daftar Sekarang',
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilities() {
    final facilities = [
      {
        'icon': Icons.pool,
        'name': 'Kolam Renang Olimpiade',
        'desc': 'Suhu terkontrol',
      },
      {
        'icon': Icons.fitness_center,
        'name': 'Peralatan Beban',
        'desc': 'Hammer Strength®',
      },
      {'icon': Icons.groups, 'name': 'Kelas Latihan', 'desc': 'Les Mills™'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fasilitas Unggulan',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Lihat Semua',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: const Color(0xFFD32F2F),
                  ),
                ),
              ),
            ],
          ),
          ...facilities.map(
            (f) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  f['icon'] as IconData,
                  color: const Color(0xFFD32F2F),
                  size: 20,
                ),
              ),
              title: Text(
                f['name'] as String,
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                f['desc'] as String,
                style: GoogleFonts.montserrat(fontSize: 11, color: Colors.grey),
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pilihan Keanggotaan',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),

          // Bulanan
          _membershipCard(
            type: 'monthly',
            title: 'KOMITMEN BULANAN',
            price: 'Rp 450.000',
            perks: ['Akses Penuh', 'Tanpa Biaya Pendaftaran'],
            isSelected: _selectedMembership == 'monthly',
            isBestValue: false,
          ),
          const SizedBox(height: 12),

          // Tahunan
          _membershipCard(
            type: 'annual',
            title: 'KEANGGOTAAN TAHUNAN',
            price: 'Rp 4.500.000',
            perks: ['Keuntungan VIP', 'Akses 12 Bulan'],
            isSelected: _selectedMembership == 'annual',
            isBestValue: true,
          ),
        ],
      ),
    );
  }

  Widget _membershipCard({
    required String type,
    required String title,
    required String price,
    required List<String> perks,
    required bool isSelected,
    required bool isBestValue,
  }) {
    return GestureDetector(
      onTap: () => setState(() => _selectedMembership = type),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFFD32F2F) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.montserrat(
                          fontSize: 11,
                          color: Colors.grey,
                          letterSpacing: 0.5,
                        ),
                      ),
                      if (isBestValue) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'PALING HEMAT · HEMAT 20%',
                            style: GoogleFonts.montserrat(
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: perks
                        .map(
                          (p) => Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                p,
                                style: GoogleFonts.montserrat(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            Radio(
              value: type,
              groupValue: _selectedMembership,
              activeColor: const Color(0xFFD32F2F),
              onChanged: (val) => setState(() => _selectedMembership = val!),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutClub(Map<String, dynamic> gym) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tentang Klub',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tingkatkan perjalanan kebugaranmu di ${gym['name']}. Berlokasi strategis di Cibinong, kami menawarkan lingkungan latihan berintensitas tinggi yang dipadukan dengan fasilitas gaya hidup premium. Baik kamu sedang mengejar target di ruang angkat beban maupun menemukan ritme di kelas dansa, pelatih kelas dunia kami siap mendorong batas kemampuanmu.',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: Colors.grey.shade600,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}