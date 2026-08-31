import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../widgets/bottom_navbar.dart';
import 'gym_detail_page.dart';
import 'explore_page.dart';
import 'workout_page.dart';
import 'profile_page.dart';
import 'notification_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String _searchQuery = '';

  final List<Map<String, dynamic>> _gyms = [
    {
      'name': 'Celebrity Fitness (CCM)',
      'location': 'Cibinong City Mall',
      'price': 459000,
      'rating': 4.5,
      'color': const Color(0xFF1A1A2E),
      'tag': '4.5',
    },
    {
      'name': 'Osbond Gym',
      'location': 'Jl. Tegar Beriman',
      'price': 180000,
      'rating': 4.2,
      'color': const Color(0xFF2D2D2D),
      'tag': '4.2',
    },
    {
      'name': 'Rambo Gym',
      'location': 'Cibinong Central',
      'price': 150000,
      'rating': 4.0,
      'color': const Color(0xFF1B1B1B),
      'tag': '4.0',
    },
    {
      'name': 'The Jungle Gym',
      'location': 'Gundul Haciby',
      'price': 200000,
      'rating': 4.3,
      'color': const Color(0xFF0D1B2A),
      'tag': '4.3',
    },
  ];

  List<Map<String, dynamic>> get _filteredGyms {
    if (_searchQuery.isEmpty) return _gyms;
    return _gyms.where((gym) {
      return gym['name'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          gym['location'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: _currentIndex == 1
          ? const ExplorePage()
          : _currentIndex == 2
          ? const WorkoutPage()
          : _currentIndex == 3
          ? const ProfilePage()
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    _buildHeroBanner(),
                    _buildSearchBar(),
                    _buildFeaturedSection(),
                    _buildGymList(),
                    _buildSummerChallenge(),
                    _buildCheckinCard(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  // HEADER (dropdown menu sudah dihapus, tinggal logo + notifikasi)
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'GYMYUK',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: const Color(0xFFD32F2F),
              letterSpacing: 2,
            ),
          ),
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD32F2F),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        onChanged: (val) => setState(() => _searchQuery = val),
        decoration: InputDecoration(
          hintText: 'Cari gym, lokasi...',
          hintStyle: GoogleFonts.montserrat(
            fontSize: 13,
            color: Colors.grey.shade400,
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD32F2F)),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFD32F2F),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.circle, color: Colors.white, size: 8),
                  const SizedBox(width: 4),
                  Text(
                    'LANGSUNG',
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gym Terdekat\ndi Cibinong',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Temukan tempat latihan terbaik di\nCibinong, mulai dari pusat kebugaran\nmewah hingga sanggar MMA khusus.',
                  style: GoogleFonts.montserrat(
                    fontSize: 11,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Gym\nUnggulan',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
              height: 1.2,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Lihat Semua',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: const Color(0xFFD32F2F),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGymList() {
    final gyms = _filteredGyms;

    if (gyms.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Text(
            'Gym tidak ditemukan 😔',
            style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: gyms.length,
      itemBuilder: (context, index) {
        return _buildGymCard(gyms[index]);
      },
    );
  }

  Widget _buildGymCard(Map<String, dynamic> gym) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  color: gym['color'] as Color,
                  gradient: LinearGradient(
                    colors: [
                      (gym['color'] as Color),
                      (gym['color'] as Color).withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.fitness_center,
                    color: Colors.white24,
                    size: 60,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '${gym['tag']}',
                        style: GoogleFonts.montserrat(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        gym['name'],
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 13,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            gym['location'],
                            style: GoogleFonts.montserrat(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      RatingBarIndicator(
                        rating: gym['rating'].toDouble(),
                        itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                        itemCount: 5,
                        itemSize: 14,
                      ),
                      const SizedBox(height: 6),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Rp ${_formatPrice(gym['price'])}/bln',
                              style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFD32F2F),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GymDetailPage(gym: gym),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD32F2F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                  ),
                  child: Text(
                    'Lihat Detail',
                    style: GoogleFonts.montserrat(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummerChallenge() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tantangan Musim Panas\n2026',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Bergabunglah dengan 500+ penggiat kebugaran Cibinong dalam tantangan transformasi kami. Hadiah eksklusif untuk performa terbaik!',
            style: GoogleFonts.montserrat(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1565C0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Gabung Sekarang',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckinCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFD32F2F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TOTAL CHECK-IN',
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  color: Colors.white70,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '1,284',
                style: GoogleFonts.montserrat(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              Text(
                '+21% dari minggu lalu',
                style: GoogleFonts.montserrat(
                  fontSize: 11,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Aktif Sekarang!',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFD32F2F),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}