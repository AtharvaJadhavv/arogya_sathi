import 'package:flutter/material.dart';

// SCREEN IMPORTS
import 'dash.dart';
import 'patient.dart';
import 'otp.dart';
import 'homepage.dart';
import 'bookapp.dart';
import 'record.dart';
import 'aicare.dart';
import 'schedule.dart';
import 'consent.dart';
import 'profile.dart';
import 'doctor_home.dart';
import 'docpatientlist.dart';
import 'prescriptions.dart';
import 'doc_prof.dart';
import 'pharmacyhome.dart';
import 'pharmacyprofile.dart';
import 'hospitaloverview.dart';
import 'hospitalcommunity.dart';
import 'hospitalprofile.dart';

void main() {
  runApp(const ArogyaSathiApp());
}

class ArogyaSathiApp extends StatelessWidget {
  const ArogyaSathiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arogya Sathi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6BADE5),
        brightness: Brightness.light,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case '/dash':
        return MaterialPageRoute(builder: (_) => const DashScreen());

    // PATIENT ROUTES
      case '/patient_login':
        return MaterialPageRoute(builder: (_) => const PatientLoginScreen(userType: 'patient'));
      case '/patient_otp':
        return MaterialPageRoute(builder: (_) => const OtpScreen(userType: 'patient'));
      case '/patient_dashboard':
        return MaterialPageRoute(builder: (_) => const PatientHomePage());
      case '/book_appointment':
        return MaterialPageRoute(builder: (_) => const BookAppointmentScreen());
      case '/records':
        return MaterialPageRoute(builder: (_) => const MedicalRecordsScreen());
      case '/aicare':
        return MaterialPageRoute(builder: (_) => const AICareScreen());
      case '/schedule_checkup':
        return MaterialPageRoute(builder: (_) => const ScheduleCheckupScreen());
      case '/consent':
        return MaterialPageRoute(builder: (_) => const ConsentScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

    // DOCTOR ROUTES
      case '/doctor_login':
        return MaterialPageRoute(builder: (_) => const PatientLoginScreen(userType: 'doctor'));
      case '/doctor_otp':
        return MaterialPageRoute(builder: (_) => const OtpScreen(userType: 'doctor'));
      case '/doctor_home':
        return MaterialPageRoute(builder: (_) => const DoctorHomePage());
      case '/doctor_patients':
        return MaterialPageRoute(builder: (_) => const DoctorPatientListScreen());
      case '/doctor_prescriptions':
        return MaterialPageRoute(builder: (_) => const DoctorPrescriptionsScreen());
      case '/doctor_profile':
        return MaterialPageRoute(builder: (_) => const DoctorProfilePage());

    // PHARMACY ROUTES
      case '/pharmacy_login':
        return MaterialPageRoute(builder: (_) => const PatientLoginScreen(userType: 'pharmacy'));
      case '/pharmacy_otp':
        return MaterialPageRoute(builder: (_) => const OtpScreen(userType: 'pharmacy'));
      case '/pharmacy_home':
        return MaterialPageRoute(builder: (_) => const PharmacyHomePage());
      case '/pharmacy_profile':
        return MaterialPageRoute(builder: (_) => const PharmacyProfilePage());
      case '/pharmacy_prescriptions':
        return MaterialPageRoute(builder: (_) => const PlaceholderPage(title: 'Pharmacy Prescriptions'));

    // HOSPITAL ROUTES
      case '/hospital_login':
        return MaterialPageRoute(builder: (_) => const PatientLoginScreen(userType: 'hospital'));
      case '/hospital_otp':
        return MaterialPageRoute(builder: (_) => const OtpScreen(userType: 'hospital'));
      case '/hospital_home':
        return MaterialPageRoute(builder: (_) => const HospitalOverviewPage());
      case '/hospital_community':
        return MaterialPageRoute(builder: (_) => const HospitalCommunityPage());
      case '/hospital_profile':
        return MaterialPageRoute(builder: (_) => const HospitalProfilePage());
      default:
        return MaterialPageRoute(builder: (_) => const WelcomePage());
    }
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  static const Color primaryBlue = Color(0xFF6BADE5);
  static const Color backgroundLight = Color(0xFFE8F4FB);
  static const Color textDark = Color(0xFF2C3E50);

  late AnimationController _heartbeatController;
  late Animation<double> _heartbeatAnimation;

  @override
  void initState() {
    super.initState();
    _heartbeatController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _heartbeatAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.2).chain(CurveTween(curve: Curves.easeOut)), weight: 30),
      TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1.0).chain(CurveTween(curve: Curves.easeIn)), weight: 20),
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.15).chain(CurveTween(curve: Curves.easeOut)), weight: 25),
      TweenSequenceItem(tween: Tween<double>(begin: 1.15, end: 1.0).chain(CurveTween(curve: Curves.easeIn)), weight: 25),
    ]).animate(_heartbeatController);
  }

  @override
  void dispose() {
    _heartbeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              GestureDetector(
                onTap: () => _heartbeatController.forward(from: 0.0),
                child: AnimatedBuilder(
                  animation: _heartbeatAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _heartbeatAnimation.value,
                      child: Container(
                        width: 100, height: 100,
                        decoration: BoxDecoration(
                          color: primaryBlue,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: primaryBlue.withOpacity(0.3 * _heartbeatAnimation.value),
                              blurRadius: 20 * _heartbeatAnimation.value,
                            ),
                          ],
                        ),
                        child: Icon(Icons.favorite, color: Colors.white, size: 50 * _heartbeatAnimation.value),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Text('Arogyaसाथी', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textDark, letterSpacing: 0.5)),
              const SizedBox(height: 4),
              const Text('Your AI Healthcare Companion', style: TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w400)),
              const SizedBox(height: 40),
              const _FeatureTile(icon: Icons.verified_user_outlined, title: 'ABDM Enabled', subtitle: 'Secure Health ID integration'),
              const SizedBox(height: 16),
              const _FeatureTile(icon: Icons.insights_outlined, title: 'AI-Powered Insights', subtitle: 'Smart health recommendations'),
              const SizedBox(height: 16),
              const _FeatureTile(icon: Icons.favorite_border_outlined, title: 'Complete Care', subtitle: 'Connect healthcare seamlessly'),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/dash'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Get Started', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'By continuing, you agree to our Terms of Service and Privacy Policy',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureTile({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF6BADE5), size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6BADE5),
        elevation: 0,
        title: Text(title, style: const TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 20),
            Text(
              '$title Coming Soon!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This feature is under development',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6BADE5),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}