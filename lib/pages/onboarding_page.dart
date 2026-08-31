import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'icon': Icons.fitness_center,
      'color': const Color(0xFF1A1A2E),
      'title': 'Temukan Gym\nTerbaik di Sekitarmu',
      'desc':
          'Jelajahi ratusan gym premium di Cibinong dan sekitarnya. Dari fitness center mewah hingga dojo MMA khusus.',
    },
    {
      'icon': Icons.track_changes,
      'color': const Color(0xFF2D1B1B),
      'title': 'Lacak Progress\nLatihanmu',
      'desc':
          'Monitor setiap sesi latihan, catat personal record, dan lihat perkembangan fisikmu dari waktu ke waktu.',
    },
    {
      'icon': Icons.emoji_events,
      'color': const Color(0xFF1B2D1B),
      'title': 'Raih Target &\nMenangkan Hadiah',
      'desc':
          'Ikuti challenge komunitas, kumpulkan poin setiap check-in, dan tukarkan dengan reward eksklusif.',
    },
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  void _skip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: _skip,
                  child: Text(
                    'Lewati',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Ilustrasi
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: page['color'] as Color,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            page['icon'] as IconData,
                            color: Colors.white24,
                            size: 80,
                          ),
                        ),
                        const SizedBox(height: 48),

                        // Judul
                        Text(
                          page['title'],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Deskripsi
                        Text(
                          page['desc'],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Dot indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? const Color(0xFFD32F2F)
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Tombol
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD32F2F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _currentPage == _pages.length - 1
                        ? 'Mulai Sekarang!'
                        : 'Selanjutnya  ›',
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
