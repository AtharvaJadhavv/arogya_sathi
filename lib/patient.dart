import 'package:flutter/material.dart';

class PatientLoginScreen extends StatefulWidget {
  final String? userType; // 'patient' or 'doctor'

  const PatientLoginScreen({super.key, this.userType});

  @override
  State<PatientLoginScreen> createState() => _PatientLoginScreenState();
}

class _PatientLoginScreenState extends State<PatientLoginScreen> {
  final TextEditingController _healthIdController = TextEditingController();

  // Track if the ID is valid (14 digits)
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    // Add listener to check text length as the user types
    _healthIdController.addListener(_validateInput);
  }

  void _validateInput() {
    // Check if length is 14 (adjust logic if you want to ignore dashes)
    final text = _healthIdController.text.replaceAll('-', '');
    setState(() {
      _isValid = text.length == 14;
    });
  }

  @override
  void dispose() {
    _healthIdController.removeListener(_validateInput);
    _healthIdController.dispose();
    super.dispose();
  }

  String get _title {
    if (widget.userType == 'doctor') return 'Doctor Login';
    return 'Patient Login';
  }

  String get _subtitle {
    if (widget.userType == 'doctor') return 'Sign in with your Doctor ABDM Health ID';
    return 'Sign in with your ABDM Health ID';
  }

  void _handleContinue() {
    if (_isValid) {
      if (widget.userType == 'doctor') {
        Navigator.pushNamed(context, '/doctor_otp');
      } else if (widget.userType == 'pharmacy') {
        Navigator.pushNamed(context, '/pharmacy_otp');
      } else {
        Navigator.pushNamed(context, '/patient_otp');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Blue Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 50, 24, 40),
              decoration: const BoxDecoration(
                color: Color(0xFF7CB6D9),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        widget.userType == 'doctor'
                            ? Icons.medical_services_outlined
                            : Icons.favorite_outline,
                        color: Colors.white,
                        size: 32,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Arogyaसाथी',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _subtitle,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),

            // Input Section
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userType == 'doctor' ? 'Doctor ABDM Health ID' : 'ABDM Health ID',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _healthIdController,
                    decoration: InputDecoration(
                      hintText: '91-1234-5678-9012',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Enter your 14-digit ABDM Health ID',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 32),

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _isValid ? _handleContinue : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isValid
                            ? const Color(0xFF1976D2)
                            : const Color(0xFFB3D4E9),
                        disabledBackgroundColor: const Color(0xFFB3D4E9),
                        foregroundColor: Colors.white,
                        disabledForegroundColor: Colors.white.withOpacity(0.7),
                        elevation: _isValid ? 4 : 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Footer Link
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Don\'t have a Health ID? Create one',
                        style: TextStyle(
                          color: Color(0xFF5C9ECA),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}