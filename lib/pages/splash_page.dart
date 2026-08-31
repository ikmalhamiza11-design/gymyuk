import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  // Controllers animasi
  late AnimationController _bgController;
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _pulseController;

  // Animasi background
  late Animation<double> _bgAnimation;

  // Animasi logo
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _logoRotate;

  // Animasi teks
  late Animation<double> _titleOpacity;
  late Animation<Offset> _titleSlide;
  late Animation<double> _taglineOpacity;
  late Animation<Offset> _taglineSlide;
  late Animation<double> _versionOpacity;

  // Animasi pulse lingkaran
  late Animation<double> _pulseScale;
  late Animation<double> _pulseOpacity;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startSequence();
  }

  void _setupAnimations() {
    // Background gradient animation
    _bgController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _bgAnimation = CurvedAnimation(parent: _bgController, curve: Curves.easeIn);

    // Logo animation
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));
    _logoRotate = Tween<double>(
      begin: -0.3,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeOut));

    // Text animation
    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    _titleSlide = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _textController,
            curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
          ),
        );
    _taglineOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );
    _taglineSlide = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _textController,
            curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
          ),
        );
    _versionOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
      ),
    );

    // Pulse animation (loop)
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _pulseScale = Tween<double>(
      begin: 1.0,
      end: 1.8,
    ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeOut));
    _pulseOpacity = Tween<double>(
      begin: 0.4,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeOut));
  }

  Future<void> _startSequence() async {
    // 1. Background muncul
    _bgController.forward();
    await Future.delayed(const Duration(milliseconds: 600));

    // 2. Logo muncul dengan animasi elastic
    _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 700));

    // 3. Teks muncul slide dari bawah
    _textController.forward();
    await Future.delayed(const Duration(milliseconds: 1200));

    // 4. Navigasi ke Onboarding
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const OnboardingPage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 600),
        ),
      );
    }
  }

  @override
  void dispose() {
    _bgController.dispose();
    _logoController.dispose();
    _textController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _bgController,
          _logoController,
          _textController,
          _pulseController,
        ]),
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(
                    const Color(0xFFF5F0EE),
                    const Color(0xFFFFEBEE),
                    _bgAnimation.value,
                  )!,
                  Color.lerp(
                    Colors.white,
                    const Color(0xFFFFF5F5),
                    _bgAnimation.value,
                  )!,
                ],
              ),
            ),
            child: Stack(
              children: [
                // Dekorasi lingkaran besar kanan atas
                Positioned(
                  top: -80,
                  right: -80,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFD32F2F).withOpacity(0.05),
                    ),
                  ),
                ),

                // Dekorasi lingkaran kiri bawah
                Positioned(
                  bottom: -60,
                  left: -60,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFD32F2F).withOpacity(0.05),
                    ),
                  ),
                ),

                // Konten utama
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo dengan pulse effect
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Pulse ring
                            Transform.scale(
                              scale: _pulseScale.value,
                              child: Opacity(
                                opacity:
                                    _pulseOpacity.value * _logoOpacity.value,
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFFD32F2F),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Logo utama
                            Transform.scale(
                              scale: _logoScale.value,
                              child: Transform.rotate(
                                angle: _logoRotate.value,
                                child: Opacity(
                                  opacity: _logoOpacity.value,
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(
                                            0xFFD32F2F,
                                          ).withOpacity(0.3),
                                          blurRadius: 20,
                                          spreadRadius: 4,
                                        ),
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.fitness_center,
                                        color: Color(0xFFD32F2F),
                                        size: 44,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Teks GYMYUK slide dari bawah
                      SlideTransition(
                        position: _titleSlide,
                        child: FadeTransition(
                          opacity: _titleOpacity,
                          child: ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xFFD32F2F), Color(0xFFB71C1C)],
                            ).createShader(bounds),
                            child: Text(
                              'GYMYUK',
                              style: GoogleFonts.montserrat(
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 6,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Tagline slide dari bawah
                      SlideTransition(
                        position: _taglineSlide,
                        child: FadeTransition(
                          opacity: _taglineOpacity,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 40,
                                height: 1.5,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.grey.shade400,
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'ENERGI TANPA BATAS',
                                style: GoogleFonts.montserrat(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade500,
                                  letterSpacing: 3,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                width: 40,
                                height: 1.5,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.grey.shade400,
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Versi app di bawah
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: FadeTransition(
                    opacity: _versionOpacity,
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 3,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD32F2F).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Ver 2.0 • Kinetic Engine Active',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 11,
                            color: Colors.grey.shade400,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
