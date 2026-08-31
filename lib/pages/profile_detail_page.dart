import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              _buildProfileInfo(),
              _buildStreakInfo(),
              _buildAccountSettings(context),
              _buildMembershipHistory(),
              _buildLogoutButton(context),
              const SizedBox(height: 20),
              Text(
                'Version 2.4 | 070291',
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
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
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      children: [
        const SizedBox(height: 8),
        CircleAvatar(
          radius: 45,
          backgroundColor: Colors.grey.shade300,
          child: const Icon(Icons.person, size: 45, color: Colors.white),
        ),
        const SizedBox(height: 12),
        Text(
          'ikmal hamiz azhari',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFD32F2F),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'ELITE MEMBER',
                style: GoogleFonts.montserrat(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'ACTIVE SINCE 2022',
              style: GoogleFonts.montserrat(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Streak info
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _statItem('12 Days', 'CURRENT STREAK'),
              Container(width: 1, height: 40, color: Colors.grey.shade300),
              _statItem('Oct 15', 'NEXT BILLING'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 10,
            color: Colors.grey,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildStreakInfo() => const SizedBox.shrink();

  Widget _buildAccountSettings(BuildContext context) {
    final settings = [
      {
        'icon': Icons.person_outline,
        'title': 'Personal Information',
        'desc': 'Update your height, weight, and details',
      },
      {
        'icon': Icons.lock_outline,
        'title': 'Password & Security',
        'desc': 'Change password and 2FA settings',
      },
      {
        'icon': Icons.credit_card,
        'title': 'Payment Methods',
        'desc': 'Managing to xxxx 4242',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            'Account Settings',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ...settings.map(
          (s) => ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                s['icon'] as IconData,
                color: const Color(0xFFD32F2F),
                size: 20,
              ),
            ),
            title: Text(
              s['title'] as String,
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              s['desc'] as String,
              style: GoogleFonts.montserrat(fontSize: 11, color: Colors.grey),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildMembershipHistory() {
    final memberships = [
      {
        'status': 'ACTIVE PLAN',
        'name': 'Diamond Yearly Elite',
        'price': '\$599/yr',
        'expires': 'Expires Sept 12, 2024',
        'color': Colors.green,
      },
      {
        'status': 'EXPIRED',
        'name': 'Monthly Pro Membership',
        'price': '\$49/mo',
        'expires': 'Jan 2022 — Aug 2023',
        'color': Colors.grey,
      },
      {
        'status': 'EXPIRED',
        'name': 'Standard Introductory',
        'price': '\$29/mo',
        'expires': 'Oct 2021 — Dec 2021',
        'color': Colors.grey,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            'Membership History',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ...memberships.map(
          (m) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: (m['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        m['status'] as String,
                        style: GoogleFonts.montserrat(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: m['color'] as Color,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      m['name'] as String,
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      m['expires'] as String,
                      style: GoogleFonts.montserrat(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Text(
                  m['price'] as String,
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFD32F2F),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () => _showLogoutDialog(context),
          icon: const Icon(Icons.logout, color: Color(0xFFD32F2F)),
          label: Text(
            'Logout',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFD32F2F),
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFFD32F2F)),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

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
