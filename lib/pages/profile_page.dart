import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'payment_history_page.dart';
import 'login_page.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _profileImage = File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildProfileCard(),
              _buildStats(),
              _buildMenuList(context),
              const SizedBox(height: 20),
              Text(
                'Version 2.4 | Kinetic Build',
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ================== HEADER + DROPDOWN MENU ==================
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.menu, size: 22),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (value) => _handleMenuSelection(value),
            itemBuilder: (context) => [
              _popupItem('settings', Icons.settings_outlined, 'Pengaturan Aplikasi'),
              _popupItem('language', Icons.language, 'Bahasa'),
              _popupItem('theme', Icons.dark_mode_outlined, 'Tema Tampilan'),
              _popupItem('about', Icons.info_outline, 'Tentang Aplikasi'),
            ],
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
    );
  }

  PopupMenuItem<String> _popupItem(String value, IconData icon, String label) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFFD32F2F)),
          const SizedBox(width: 10),
          Text(label, style: GoogleFonts.montserrat(fontSize: 13)),
        ],
      ),
    );
  }

  void _handleMenuSelection(String value) {
    final titles = {
      'settings': 'Pengaturan Aplikasi',
      'language': 'Bahasa',
      'theme': 'Tema Tampilan',
      'about': 'Tentang Aplikasi',
    };
    final bodies = {
      'settings': 'Kelola notifikasi, privasi, dan preferensi akun Anda di sini.',
      'language': 'Pilih bahasa yang ingin digunakan pada aplikasi (Indonesia / English).',
      'theme': 'Pilih tampilan Terang atau Gelap sesuai preferensi Anda.',
      'about': 'GymYuk versi 2.4 — Aplikasi pencarian gym dan manajemen kebugaran berbasis Flutter.',
    };
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          titles[value] ?? '',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        content: Text(
          bodies[value] ?? '',
          style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey.shade700),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tutup', style: GoogleFonts.montserrat(color: const Color(0xFFD32F2F))),
          ),
        ],
      ),
    );
  }
  // ================== END HEADER + DROPDOWN ==================

  Widget _buildProfileCard() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Stack(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: _profileImage != null
                  ? FileImage(_profileImage!)
                  : null,
              child: _profileImage == null
                  ? const Icon(Icons.person, size: 50, color: Colors.white)
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Color(0xFFD32F2F),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Ikmal Hamiz Azhari',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFD32F2F),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'ELITE MEMBER',
            style: GoogleFonts.montserrat(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem('24', 'Workouts'),
          Container(width: 1, height: 40, color: Colors.grey.shade300),
          _statItem('12k', 'Points'),
          Container(width: 1, height: 40, color: Colors.grey.shade300),
          _statItem('4', 'Streaks'),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.montserrat(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }

  // ================== MENU LIST — SEMUA SUDAH BISA DIAKSES ==================
  Widget _buildMenuList(BuildContext context) {
    final menus = [
      {
        'icon': Icons.person_outline,
        'label': 'Profil Saya',
        'color': Colors.blue,
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EditProfilePage()),
        ),
      },
      {
        'icon': Icons.history,
        'label': 'Riwayat Membership',
        'color': Colors.orange,
        // FIX: sebelumnya salah arah ke EditProfilePage
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PaymentHistoryPage()),
        ),
      },
      {
        'icon': Icons.credit_card,
        'label': 'Metode Pembayaran',
        'color': Colors.green,
        'onTap': () => _showPaymentMethodsSheet(context),
      },
      {
        'icon': Icons.security,
        'label': 'Keamanan',
        'color': Colors.purple,
        'onTap': () => _showSecurityDialog(context),
      },
      {
        'icon': Icons.help_outline,
        'label': 'Pusat Bantuan',
        'color': Colors.teal,
        'onTap': () => _showHelpDialog(context),
      },
      {
        'icon': Icons.logout,
        'label': 'Keluar',
        'color': Colors.red,
        'onTap': () => _showLogoutDialog(context),
      },
    ];

    return Column(
      children: menus.map((menu) {
        return ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (menu['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              menu['icon'] as IconData,
              color: menu['color'] as Color,
              size: 20,
            ),
          ),
          title: Text(
            menu['label'] as String,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: menu['onTap'] as VoidCallback,
        );
      }).toList(),
    );
  }

  void _showPaymentMethodsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Metode Pembayaran',
              style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            _paymentMethodTile(Icons.qr_code, 'QRIS', 'Bayar cepat via scan QR', context),
            _paymentMethodTile(Icons.account_balance, 'Transfer Bank', 'BCA, Mandiri, BRI, BNI', context),
            _paymentMethodTile(Icons.credit_card, 'Kartu Kredit/Debit', 'Visa, Mastercard', context),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _paymentMethodTile(IconData icon, String title, String subtitle, BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: const Color(0xFFD32F2F)),
      title: Text(title, style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: GoogleFonts.montserrat(fontSize: 11, color: Colors.grey)),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PaymentHistoryPage()),
        );
      },
    );
  }

  void _showSecurityDialog(BuildContext context) {
    final currentCtrl = TextEditingController();
    final newCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Keamanan Akun', style: GoogleFonts.montserrat(fontWeight: FontWeight.w700)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password saat ini'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: newCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password baru'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD32F2F)),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password berhasil diperbarui'),
                  backgroundColor: Color(0xFFD32F2F),
                ),
              );
            },
            child: const Text('Simpan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Pusat Bantuan', style: GoogleFonts.montserrat(fontWeight: FontWeight.w700)),
        content: Text(
          'Butuh bantuan? Hubungi tim kami di support@gymyuk.com atau lihat FAQ di dalam aplikasi.',
          style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey.shade700),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tutup', style: GoogleFonts.montserrat(color: const Color(0xFFD32F2F))),
          ),
        ],
      ),
    );
  }
  // ================== END MENU LIST ==================

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.logout,
                color: Color(0xFFD32F2F),
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Konfirmasi Keluar',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Apakah Anda yakin ingin keluar? Anda perlu login kembali untuk mengakses data latihan Anda.',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD32F2F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Ya, Keluar',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Batal',
                style: GoogleFonts.montserrat(fontSize: 13, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}