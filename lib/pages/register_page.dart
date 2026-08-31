import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreeToTerms = false;

  void _register() {
    final fullname = _fullnameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmPasswordController.text.trim();

    if (fullname.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirm.isEmpty) {
      _showSnackbar('Semua field harus diisi!');
      return;
    }

    if (password != confirm) {
      _showSnackbar('Password tidak cocok!');
      return;
    }

    if (!_agreeToTerms) {
      _showSnackbar('Harap setujui Syarat & Kebijakan Privasi!');
      return;
    }

    // Dummy register — langsung masuk ke Home
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
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
    _fullnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header GYMYUK + tombol close
              Row(
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
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // GABUNG SEKARANG
              Text(
                'GABUNG\nSEKARANG',
                style: GoogleFonts.montserrat(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFFD32F2F),
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Wujudkan ambisimu dengan pelacakan\nperforma Kinetic.',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: 28),

              // Nama Lengkap
              _buildTextField(
                controller: _fullnameController,
                label: 'Nama Lengkap',
                hint: 'John Doe',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 14),

              // Email
              _buildTextField(
                controller: _emailController,
                label: 'Alamat Email',
                hint: 'hai@contoh.com',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 14),

              // Password
              _buildTextField(
                controller: _passwordController,
                label: 'Kata Sandi',
                hint: '••••••••',
                icon: Icons.lock_outline,
                isPassword: true,
                obscure: _obscurePassword,
                onToggleObscure: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
              const SizedBox(height: 14),

              // Konfirmasi Password
              _buildTextField(
                controller: _confirmPasswordController,
                label: 'Konfirmasi Kata Sandi',
                hint: '••••••••',
                icon: Icons.lock_outline,
                isPassword: true,
                obscure: _obscureConfirm,
                onToggleObscure: () {
                  setState(() => _obscureConfirm = !_obscureConfirm);
                },
              ),
              const SizedBox(height: 16),

              // Syarat & Ketentuan
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (val) {
                      setState(() => _agreeToTerms = val ?? false);
                    },
                    activeColor: const Color(0xFFD32F2F),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Expanded(
                    child: Text(
                      'Saya setuju dengan Syarat Layanan dan Kebijakan Privasi',
                      style: GoogleFonts.montserrat(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Tombol DAFTAR SEKARANG
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD32F2F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'DAFTAR SEKARANG  ›',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Sudah Punya Akun
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Sudah punya akun? ',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                      children: [
                        TextSpan(
                          text: 'MASUK DI SINI',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFFD32F2F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
    bool obscure = false,
    VoidCallback? onToggleObscure,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? obscure : false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, size: 20),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20,
                ),
                onPressed: onToggleObscure,
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFD32F2F)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
      ),
    );
  }
}