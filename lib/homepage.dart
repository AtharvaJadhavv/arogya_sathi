import 'package:flutter/material.dart';

class PatientHomePage extends StatelessWidget {
  const PatientHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFE),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF6BADE5),
        unselectedItemColor: Colors.grey,
        currentIndex: 0, // Home is selected
        onTap: (index) {
          // Handle navigation based on index
          switch (index) {
            case 0:
            // Already on Home
              break;
            case 1:
            // Navigate to Records
              Navigator.pushNamed(context, '/records');
              break;
            case 2:
            // Navigate to AI Care
              Navigator.pushNamed(context, '/aicare');
              break;
            case 3:
            // Navigate to Consent
              Navigator.pushNamed(context, '/consent');
              break;
            case 4:
            // Navigate to Profile
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: 'Records'),
          BottomNavigationBarItem(icon: Icon(Icons.psychology), label: 'AI Care'),
          BottomNavigationBarItem(icon: Icon(Icons.verified_user), label: 'Consent'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildStatusBox(
                    title: 'AI Health Summary',
                    tag: 'Good',
                    content: 'Your health metrics are stable. Continue your current medication and lifestyle habits.',
                    actionText: 'View detailed insights',
                    baseColor: Colors.green,
                  ),
                  const SizedBox(height: 16),
                  _buildStatusBox(
                    title: 'Blood Pressure Monitoring Required',
                    tag: null,
                    content: 'Your last BP reading was 145/92. Please monitor daily and consult Dr. Kumar if readings remain elevated.',
                    actionText: 'Schedule Check-up',
                    baseColor: Colors.red,
                    isAlert: true,
                  ),
                  const SizedBox(height: 24),
                  _buildSectionHeader(context, 'Upcoming Appointments', true),
                  const SizedBox(height: 10),
                  _buildAppointmentCard('Dr. Rajesh Kumar', 'Cardiologist', '15 Jan', '10:00 AM'),
                  const SizedBox(height: 12),
                  _buildAppointmentCard('Dr. Anita Desai', 'General Physician', '20 Jan', '03:00 PM'),
                  const SizedBox(height: 24),
                  _buildSectionHeader(context, 'Quick Actions', false),
                  const SizedBox(height: 12),
                  _buildQuickActionsGrid(context),
                  const SizedBox(height: 24),
                  _buildPreventiveCareCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBox({
    required String title,
    String? tag,
    required String content,
    required String actionText,
    required Color baseColor,
    bool isAlert = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: baseColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: baseColor.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(isAlert ? Icons.error_outline : Icons.auto_awesome_outlined, color: baseColor, size: 20),
              const SizedBox(width: 8),
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
              if (tag != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: baseColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Text(tag, style: TextStyle(color: baseColor, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.4)),
          const SizedBox(height: 12),
          isAlert
              ? ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: baseColor.withOpacity(0.2),
              foregroundColor: baseColor,
              elevation: 0,
              minimumSize: const Size(0, 36),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(actionText, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          )
              : Row(
            children: [
              Text(actionText, style: TextStyle(color: baseColor, fontWeight: FontWeight.bold, fontSize: 13)),
              Icon(Icons.chevron_right, color: baseColor, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
      decoration: const BoxDecoration(
        color: Color(0xFF7CB6D9),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome back,', style: TextStyle(color: Colors.white, fontSize: 14)),
                  Text('Priya Sharma', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  IconButton(icon: const Icon(Icons.shield, color: Color(0xFFD32F2F)), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.notifications_none, color: Colors.white), onPressed: () {}),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ABDM Health ID', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    Text('91-1234-5678-9012', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                Icon(Icons.favorite, color: Colors.white, size: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, bool showViewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        if (showViewAll)
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/book_appointment'),
            child: const Text('View all >', style: TextStyle(color: Color(0xFF6BADE5))),
          ),
      ],
    );
  }

  Widget _buildAppointmentCard(String name, String spec, String date, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade50),
      ),
      child: Row(
        children: [
          const CircleAvatar(backgroundColor: Color(0xFFE3F2FD), child: Icon(Icons.calendar_today, size: 18)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(spec, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                Text('$date • $time', style: const TextStyle(fontSize: 11, color: Colors.blueGrey)),
              ],
            ),
          ),
          TextButton(onPressed: () {}, child: const Text('Details')),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _actionItem(context, Icons.calendar_month, 'Book Appointment', Colors.blue, '/book_appointment'),
        _actionItem(context, Icons.biotech, 'Lab Tests', Colors.green, null),
        _actionItem(context, Icons.medication, 'Medications', Colors.red, null),
        _actionItem(context, Icons.alarm, 'Reminders', Colors.orange, null),
      ],
    );
  }

  Widget _actionItem(BuildContext context, IconData icon, String label, Color color, String? route) {
    return GestureDetector(
      onTap: () {
        if (route != null) {
          Navigator.pushNamed(context, route);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$label - Coming Soon!')),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.shade50),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildPreventiveCareCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Preventive Care Reminder', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _careRow('Annual Health Checkup', 'Due in 2 months', Colors.orange),
          const Divider(),
          _careRow('Eye Examination', 'Completed', Colors.green),
          const Divider(),
          _careRow('Dental Checkup', 'Overdue', Colors.red),
        ],
      ),
    );
  }

  Widget _careRow(String t, String s, Color c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(t, style: const TextStyle(fontSize: 13)),
          Text(s, style: TextStyle(color: c, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}