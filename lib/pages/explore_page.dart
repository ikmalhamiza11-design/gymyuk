import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'gym_detail_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int _selectedGymIndex = 0;

  final List<Map<String, dynamic>> _gyms = [
    {
      'name': 'Celebrity Fitness',
      'location': 'Cibinong City Mall',
      'price': 459000,
      'rating': 4.8,
      'color': const Color(0xFF1A1A2E),
      'tag': '4.8',
      'tags': ['CARDIO', 'ZUMBA'],
      'distance': '0.8km',
      'status': 'OPEN',
    },
    {
      'name': 'Osbond Gym',
      'location': 'Jl. Tegar Beriman',
      'price': 180000,
      'rating': 4.5,
      'color': const Color(0xFF2D2D2D),
      'tag': '4.5',
      'tags': ['CROSSFIT'],
      'distance': '1.2km',
      'status': 'OPEN',
    },
    {
      'name': 'Rambo Gym',
      'location': 'Cibinong Central',
      'price': 150000,
      'rating': 4.0,
      'color': const Color(0xFF1B1B1B),
      'tag': '4.0',
      'tags': ['BOXING'],
      'distance': '2.1km',
      'status': 'OPEN',
    },
    {
      'name': 'The Jungle Gym',
      'location': 'Gundul Haciby',
      'price': 200000,
      'rating': 4.3,
      'color': const Color(0xFF0D1B2A),
      'tag': '4.3',
      'tags': ['YOGA', 'PILATES'],
      'distance': '3.0km',
      'status': 'OPEN',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Stack(children: [_buildDummyMap(), _buildGymCards()]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
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
          const Spacer(),
          const Icon(Icons.notifications_outlined),
        ],
      ),
    );
  }

  Widget _buildDummyMap() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0D1B2A), Color(0xFF1A1A2E), Color(0xFF16213E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Grid lines simulasi peta
          CustomPaint(size: Size.infinite, painter: _MapGridPainter()),

          // Pin lokasi gym
          ..._gyms.asMap().entries.map((entry) {
            final positions = [
              const Offset(0.5, 0.3),
              const Offset(0.3, 0.45),
              const Offset(0.65, 0.5),
              const Offset(0.4, 0.6),
            ];
            return _buildMapPin(entry.key, entry.value, positions[entry.key]);
          }),
        ],
      ),
    );
  }

  Widget _buildMapPin(int index, Map<String, dynamic> gym, Offset relativePos) {
    final isSelected = _selectedGymIndex == index;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Positioned(
          left: constraints.maxWidth * relativePos.dx - 40,
          top: constraints.maxHeight * relativePos.dy - 20,
          child: GestureDetector(
            onTap: () => setState(() => _selectedGymIndex = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFD32F2F) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Text(
                gym['name'],
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGymCards() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: _gyms.length,
        itemBuilder: (context, index) {
          final gym = _gyms[index];
          final isSelected = _selectedGymIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedGymIndex = index);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GymDetailPage(gym: gym),
                ),
              );
            },
            child: Container(
              width: 200,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFD32F2F)
                      : Colors.transparent,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    decoration: BoxDecoration(
                      color: gym['color'] as Color,
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (gym['status'] == 'OPEN')
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'OPEN',
                              style: GoogleFonts.montserrat(
                                fontSize: 8,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        const SizedBox(height: 4),
                        const Icon(
                          Icons.fitness_center,
                          color: Colors.white54,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            gym['name'],
                            style: GoogleFonts.montserrat(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 11,
                              ),
                              Text(
                                ' ${gym['rating']}',
                                style: GoogleFonts.montserrat(fontSize: 10),
                              ),
                              Text(
                                ' • ${gym['distance']}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 4,
                            children: (gym['tags'] as List<String>)
                                .map(
                                  (tag) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      tag,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
