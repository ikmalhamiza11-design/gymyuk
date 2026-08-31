import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Dummy credentials
  final String _dummyEmail = 'ikmal@gmail.com';
  final String _dummyPassword = '123456';

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackbar('Email dan password tidak boleh kosong!');
      return;
    }

    if (email == _dummyEmail && password == _dummyPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      _showSnackbar('Email atau password salah!');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFD32F2F),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo & Brand
              Text(
                'GYMYUK',
                style: GoogleFonts.montserrat(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFD32F2F),
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 24),

              // Judul
              Text(
                'Selamat Datang',
                style: GoogleFonts.montserrat(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Masuk ke akun untuk mulai kelola performa\nAnda',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: 32),

              // Field Email
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'namagmail.com',
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFD32F2F)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Field Password
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Masukkan password',
                  labelText: 'Lupa Password?',
                  prefixIcon: const Icon(Icons.lock_outline, size: 20),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFD32F2F)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Tombol Masuk
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD32F2F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Masuk  ›',
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Divider ATAU MASUK DENGAN
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'ATAU MASUK DENGAN',
                      style: GoogleFonts.montserrat(
                        fontSize: 10,
                        color: Colors.grey.shade400,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),
              const SizedBox(height: 16),

              // Tombol Google
              _socialButton(
                label: 'Google',
                color: Colors.white,
                textColor: Colors.black87,
                borderColor: Colors.grey.shade300,
                icon: Icons.g_mobiledata_rounded,
                iconColor: const Color(0xFFD32F2F),
                onTap: () => _showSnackbar('Google Sign-In belum tersedia'),
              ),
              const SizedBox(height: 10),

              // Tombol Facebook
              _socialButton(
                label: 'Facebook',
                color: const Color(0xFF1877F2),
                textColor: Colors.white,
                borderColor: const Color(0xFF1877F2),
                icon: Icons.facebook_rounded,
                iconColor: Colors.white,
                onTap: () => _showSnackbar('Facebook Sign-In belum tersedia'),
              ),
              const SizedBox(height: 10),

              // Tombol Apple
              _socialButton(
                label: 'Apple',
                color: Colors.black,
                textColor: Colors.white,
                borderColor: Colors.black,
                icon: Icons.apple_rounded,
                iconColor: Colors.white,
                onTap: () => _showSnackbar('Apple Sign-In belum tersedia'),
              ),
              const SizedBox(height: 28),

              // Daftar sekarang
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Daftar Sekarang',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFD32F2F),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton({
    required String label,
    required Color color,
    required Color textColor,
    required Color borderColor,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: iconColor, size: 22),
        label: Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
