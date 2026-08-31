import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  final List<Map<String, dynamic>> _notifications = const [
    {
      'icon': Icons.fitness_center,
      'color': Color(0xFFD32F2F),
      'title': 'Jadwal Latihan Hari Ini!',
      'desc': 'Jangan lupa sesi latihan Push Day kamu jam 07.00 pagi.',
      'time': '5 menit lalu',
      'isRead': false,
    },
    {
      'icon': Icons.emoji_events,
      'color': Color(0xFFFFC107),
      'title': 'Summer Challenge Dimulai!',
      'desc': 'Join 500+ member Cibinong dalam Summer Challenge 2026.',
      'time': '1 jam lalu',
      'isRead': false,
    },
    {
      'icon': Icons.credit_card,
      'color': Color(0xFF4CAF50),
      'title': 'Pembayaran Berhasil',
      'desc': 'Membership Celebrity Fitness CCM bulan ini telah dibayar.',
      'time': '2 jam lalu',
      'isRead': true,
    },
    {
      'icon': Icons.local_offer,
      'color': Color(0xFF2196F3),
      'title': 'Promo Spesial Untukmu!',
      'desc': 'Dapatkan diskon 20% untuk annual membership minggu ini.',
      'time': 'Kemarin',
      'isRead': true,
    },
    {
      'icon': Icons.check_circle,
      'color': Color(0xFF4CAF50),
      'title': 'Check-in Berhasil!',
      'desc': 'Kamu berhasil check-in di Osbond Gym. Streak 4 hari! 🔥',
      'time': 'Kemarin',
      'isRead': true,
    },
    {
      'icon': Icons.article,
      'color': Color(0xFF9C27B0),
      'title': 'Artikel Baru Tersedia',
      'desc': 'Baca: 5 Makanan Super untuk Pemulihan Otot Cepat.',
      'time': '2 hari lalu',
      'isRead': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notifications
        .where((n) => !(n['isRead'] as bool))
        .length;

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
                    'Notifikasi',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  if (unreadCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD32F2F),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$unreadCount baru',
                        style: GoogleFonts.montserrat(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // List notifikasi
            Expanded(
              child: ListView.builder(
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  final notif = _notifications[index];
                  final isRead = notif['isRead'] as bool;
                  return Container(
                    color: isRead ? Colors.white : Colors.red.shade50,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: (notif['color'] as Color).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            notif['icon'] as IconData,
                            color: notif['color'] as Color,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      notif['title'],
                                      style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        fontWeight: isRead
                                            ? FontWeight.w600
                                            : FontWeight.w800,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  if (!isRead)
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFD32F2F),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notif['desc'],
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notif['time'],
                                style: GoogleFonts.montserrat(
                                  fontSize: 11,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
