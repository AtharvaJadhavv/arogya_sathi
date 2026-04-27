import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  // App Theme Colors to match the design
  static const Color primaryBlue = Color(0xFF6BADE5);
  static const Color backgroundLight = Color(0xFFE8F4FB);
  static const Color textDark = Color(0xFF2C3E50);
  static const Color cardBackground = Colors.white;

  late AnimationController _heartbeatController;
  late Animation<double> _heartbeatAnimation;

  @override
  void initState() {
    super.initState();

    // Create heartbeat animation controller
    _heartbeatController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Create heartbeat animation (scale effect)
    _heartbeatAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.2)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.15)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.15, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 25,
      ),
    ]).animate(_heartbeatController);
  }

  @override
  void dispose() {
    _heartbeatController.dispose();
    super.dispose();
  }

  void _playHeartbeat() {
    _heartbeatController.forward(from: 0.0);
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

              // App Logo with Interactive Heart Icon
              GestureDetector(
                onTap: _playHeartbeat,
                child: AnimatedBuilder(
                  animation: _heartbeatAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _heartbeatAnimation.value,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: primaryBlue,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: primaryBlue.withOpacity(0.3 * _heartbeatAnimation.value),
                              blurRadius: 20 * _heartbeatAnimation.value,
                              spreadRadius: 5 * (_heartbeatAnimation.value - 1),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 50 * _heartbeatAnimation.value,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 50),

              // Title and Subtitle
              const Text(
                'Arogyaसाथी',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Your AI Healthcare Companion',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 40),

              // Feature Highlight Cards
              const _FeatureTile(
                icon: Icons.verified_user_outlined,
                title: 'ABDM Enabled',
                subtitle: 'Secure Health ID integration for continuity of care',
              ),
              const SizedBox(height: 50),
              const _FeatureTile(
                icon: Icons.insights_outlined,
                title: 'AI-Powered Insights',
                subtitle: 'Smart recommendations for your health journey',
              ),
              const SizedBox(height: 50),
              const _FeatureTile(
                icon: Icons.favorite_border_outlined,
                title: 'Complete Care',
                subtitle: 'Connect doctors, labs, and pharmacies seamlessly',
              ),

              const SizedBox(height: 50),

              // Get Started Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the next screen (e.g., Login or Dashboard)
                    Navigator.pushNamed(context, '/dash');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 46),

              // Terms and Privacy Text
              const Text(
                'By continuing, you agree to our Terms of Service and Privacy Policy',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable widget for the feature cards
class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: _WelcomePageState.primaryBlue, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: _WelcomePageState.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}