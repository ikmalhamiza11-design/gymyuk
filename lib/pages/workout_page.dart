import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  String _selectedCategory = 'Semua';
  final _searchController = TextEditingController();
  String _searchQuery = '';

  final List<String> _categories = [
    'Semua',
    'Nutrisi',
    'Latihan',
    'Recovery',
    'Mental',
  ];

  final List<Map<String, dynamic>> _articles = [
    {
      'category': 'Nutrisi',
      'title': '5 Makanan Super untuk Pemulihan Otot Cepat',
      'desc':
          'Optimalkan progres latihan Anda dengan mengonsumsi sumber protein dan karbohidrat yang tepat setelah sesi gym...',
      'readTime': '5 Menit Membaca',
      'color': const Color(0xFF1A1A2E),
      'icon': Icons.restaurant,
    },
    {
      'category': 'Latihan',
      'title': 'Teknik Pernapasan untuk Kekuatan Maksimal',
      'desc':
          'Pelajari bagaimana kontrol napas yang benar dapat meningkatkan stabilitas core dan performa angkatan Anda...',
      'readTime': '8 Menit Membaca',
      'color': const Color(0xFF2D1B1B),
      'icon': Icons.fitness_center,
    },
    {
      'category': 'Recovery',
      'title': 'Pentingnya Tidur Teratur Bagi Pertumbuhan Otot',
      'desc':
          'Mengapa istirahat malam yang berkualitas lebih penting dari suplemen mahal dalam proses pembentukan otot...',
      'readTime': '6 Menit Membaca',
      'color': const Color(0xFF1B2D1B),
      'icon': Icons.bedtime,
    },
    {
      'category': 'Mental',
      'title': 'Mindset Juara: Cara Tetap Konsisten di Gym',
      'desc':
          'Strategi psikologi olahraga untuk membangun kebiasaan gym yang tidak mudah patah meski jadwal padat...',
      'readTime': '7 Menit Membaca',
      'color': const Color(0xFF1B1B2D),
      'icon': Icons.psychology,
    },
    {
      'category': 'Nutrisi',
      'title': 'Pre-Workout Meal: Makan Apa Sebelum Latihan?',
      'desc':
          'Panduan lengkap memilih makanan yang memberikan energi optimal tanpa membuat perut tidak nyaman saat latihan...',
      'readTime': '4 Menit Membaca',
      'color': const Color(0xFF2D2D1B),
      'icon': Icons.lunch_dining,
    },
    {
      'category': 'Latihan',
      'title': 'Program Push Pull Legs untuk Pemula',
      'desc':
          'Jadwal latihan 6 hari yang terbukti efektif untuk membangun massa otot secara merata di seluruh tubuh...',
      'readTime': '10 Menit Membaca',
      'color': const Color(0xFF2D1B2D),
      'icon': Icons.sports_gymnastics,
    },
  ];

  List<Map<String, dynamic>> get _filteredArticles {
    return _articles.where((article) {
      final matchCategory =
          _selectedCategory == 'Semua' ||
          article['category'] == _selectedCategory;
      final matchSearch =
          _searchQuery.isEmpty ||
          article['title'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          article['desc'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
      return matchCategory && matchSearch;
    }).toList();
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Nutrisi':
        return const Color(0xFF4CAF50);
      case 'Latihan':
        return const Color(0xFFD32F2F);
      case 'Recovery':
        return const Color(0xFF2196F3);
      case 'Mental':
        return const Color(0xFF9C27B0);
      default:
        return Colors.grey;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildTitle(),
            _buildSearchBar(),
            _buildCategories(),
            Expanded(child: _buildArticleList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
       Row(
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
            ],
          ),
          const Icon(Icons.notifications_outlined),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'Tips & Artikel\nKesehatan',
        style: GoogleFonts.montserrat(
          fontSize: 26,
          fontWeight: FontWeight.w800,
          color: Colors.black87,
          height: 1.2,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        onChanged: (val) => setState(() => _searchQuery = val),
        decoration: InputDecoration(
          hintText: 'Cari nutrisi, workout...',
          hintStyle: GoogleFonts.montserrat(
            fontSize: 13,
            color: Colors.grey.shade400,
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final isSelected = _selectedCategory == cat;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = cat),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFD32F2F)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                cat,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.grey.shade600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildArticleList() {
    final articles = _filteredArticles;

    if (articles.isEmpty) {
      return Center(
        child: Text(
          'Tidak ada artikel ditemukan',
          style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return _buildArticleCard(articles[index]);
      },
    );
  }

  Widget _buildArticleCard(Map<String, dynamic> article) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar artikel
          Stack(
            children: [
              Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  color: article['color'] as Color,
                ),
                child: Center(
                  child: Icon(
                    article['icon'] as IconData,
                    color: Colors.white24,
                    size: 60,
                  ),
                ),
              ),
              // Badge kategori
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(article['category']),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    article['category'].toString().toUpperCase(),
                    style: GoogleFonts.montserrat(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Konten artikel
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article['title'],
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  article['desc'],
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      article['readTime'],
                      style: GoogleFonts.montserrat(
                        fontSize: 11,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Membuka: ${article['title']}',
                              style: GoogleFonts.montserrat(fontSize: 12),
                            ),
                            backgroundColor: const Color(0xFFD32F2F),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            'Read More',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFD32F2F),
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward,
                            size: 14,
                            color: Color(0xFFD32F2F),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
