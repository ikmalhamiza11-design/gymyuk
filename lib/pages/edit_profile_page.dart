import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController(text: 'ikmal hamiz azhari');
  final _emailController = TextEditingController(text: 'ikmal@gymyuk.com');
  final _phoneController = TextEditingController(text: '08123456789');
  final _weightController = TextEditingController(text: '75');
  final _heightController = TextEditingController(text: '175');
  final _ageController = TextEditingController(text: '25');
  String _selectedGender = 'Pria';
  String _selectedGoal = 'Membentuk Otot';
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  final List<String> _goals = [
    'Membentuk Otot',
    'Menurunkan Berat',
    'Meningkatkan Stamina',
    'Menjaga Kesehatan',
  ];

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _profileImage = File(image.path));
    }
  }

  void _saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'Profil berhasil disimpan!',
              style: GoogleFonts.montserrat(fontSize: 13),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildPhotoSection(),
                    const SizedBox(height: 20),
                    _buildPersonalInfo(),
                    const SizedBox(height: 16),
                    _buildBodyStats(),
                    const SizedBox(height: 16),
                    _buildFitnessGoal(),
                    const SizedBox(height: 24),
                    _buildSaveButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back),
          ),
          const SizedBox(width: 12),
          Text(
            'Edit Profil',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 55,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : null,
                child: _profileImage == null
                    ? const Icon(Icons.person, size: 55, color: Colors.white)
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFFD32F2F),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Tap kamera untuk ganti foto',
            style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Pribadi',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _nameController,
            label: 'Nama Lengkap',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _emailController,
            label: 'Email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _phoneController,
            label: 'Nomor HP',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),

          // Gender selector
          Text(
            'Jenis Kelamin',
            style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            children: ['Pria', 'Wanita'].map((gender) {
              final isSelected = _selectedGender == gender;
              return GestureDetector(
                onTap: () => setState(() => _selectedGender = gender),
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFD32F2F)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        gender == 'Pria' ? Icons.male : Icons.female,
                        color: isSelected ? Colors.white : Colors.grey,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        gender,
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Data Fisik',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _weightController,
                  label: 'Berat (kg)',
                  icon: Icons.monitor_weight_outlined,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTextField(
                  controller: _heightController,
                  label: 'Tinggi (cm)',
                  icon: Icons.height,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _ageController,
            label: 'Usia',
            icon: Icons.cake_outlined,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),

          // BMI Calculator otomatis
          _buildBMICard(),
        ],
      ),
    );
  }

  Widget _buildBMICard() {
    final weight = double.tryParse(_weightController.text) ?? 0;
    final height = (double.tryParse(_heightController.text) ?? 0) / 100;
    final bmi = height > 0 ? weight / (height * height) : 0.0;

    String bmiCategory = '';
    Color bmiColor = Colors.grey;

    if (bmi < 18.5) {
      bmiCategory = 'Kurus';
      bmiColor = Colors.blue;
    } else if (bmi < 25) {
      bmiCategory = 'Normal ✓';
      bmiColor = Colors.green;
    } else if (bmi < 30) {
      bmiCategory = 'Gemuk';
      bmiColor = Colors.orange;
    } else {
      bmiCategory = 'Obesitas';
      bmiColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bmiColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: bmiColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BMI Kamu',
                style: GoogleFonts.montserrat(fontSize: 11, color: Colors.grey),
              ),
              Text(
                bmi > 0 ? bmi.toStringAsFixed(1) : '-',
                style: GoogleFonts.montserrat(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: bmiColor,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: bmiColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              bmiCategory,
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFitnessGoal() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Target Fitness',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _goals.map((goal) {
              final isSelected = _selectedGoal == goal;
              return GestureDetector(
                onTap: () => setState(() => _selectedGoal = goal),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFD32F2F)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFFD32F2F)
                          : Colors.transparent,
                    ),
                  ),
                  child: Text(
                    goal,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.grey.shade600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: _saveProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD32F2F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Simpan Perubahan',
          style: GoogleFonts.montserrat(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.montserrat(fontSize: 12),
        prefixIcon: Icon(icon, size: 20, color: const Color(0xFFD32F2F)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFD32F2F)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
      ),
    );
  }
}
