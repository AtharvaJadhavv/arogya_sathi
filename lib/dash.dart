import 'package:flutter/material.dart';

class DashScreen extends StatelessWidget {
  const DashScreen({super.key});

  // Theme Colors aligned with WelcomePage
  static const Color primaryBlue = Color(0xFF6BADE5);
  static const Color backgroundLight = Color(0xFFE8F4FB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [backgroundLight, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                // Logo Icon
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: primaryBlue,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: primaryBlue.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: const Icon(Icons.favorite, color: Colors.white, size: 50),
                ),
                const SizedBox(height: 16),
                // App Title
                const Text(
                  'Arogyaसाथी',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const Text(
                  'AI-Powered ABDM Healthcare Ecosystem',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 40),

                // Role Selection List
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      RoleCard(
                        title: 'Patient',
                        subtitle: 'Access your health records, book appointments, and get AI-powered care insights',
                        icon: Icons.account_circle_outlined,
                        color: const Color(0xFFD1E9F9),
                        iconColor: const Color(0xFF1976D2),
                        onTap: () => Navigator.pushNamed(context, '/patient_login'),
                      ),
                      RoleCard(
                        title: 'Doctor',
                        subtitle: 'Manage patient consultations, prescriptions, and clinical workflows',
                        icon: Icons.medical_services_outlined,
                        color: const Color(0xFFE3F2FD),
                        iconColor: const Color(0xFF0D47A1),
                        onTap: () => Navigator.pushNamed(context, '/doctor_login'),
                      ),
                      RoleCard(
                        title: 'Pharmacy',
                        subtitle: 'Process prescriptions, manage inventory, and suggest generic alternatives',
                        icon: Icons.medication_outlined,
                        color: const Color(0xFFE8F5E9),
                        iconColor: const Color(0xFF388E3C),
                        onTap: () => Navigator.pushNamed(context, '/pharmacy_login'),
                      ),
                      RoleCard(
                        title: 'Hospital',
                        subtitle: 'Coordinate care, manage resources, and monitor hospital operations',
                        icon: Icons.domain,
                        color: const Color(0xFFFFEBEE),
                        iconColor: const Color(0xFFD32F2F),
                        onTap: () => Navigator.pushNamed(context, '/hospital_home'),
                      ),
                    ],
                  ),
                ),

                // Footer
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'ABDM Compliant • Privacy First • Continuity of Care',
                    style: TextStyle(color: Colors.grey, fontSize: 11, letterSpacing: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: iconColor.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 30, color: iconColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blueGrey.shade600,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}