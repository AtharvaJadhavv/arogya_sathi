import 'package:flutter/material.dart';

class DoctorPatientListScreen extends StatefulWidget {
  const DoctorPatientListScreen({super.key});

  @override
  State<DoctorPatientListScreen> createState() => _DoctorPatientListScreenState();
}

class _DoctorPatientListScreenState extends State<DoctorPatientListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String selectedFilter = 'All';
  List<Patient> filteredPatients = [];

  final List<Patient> allPatients = [
    Patient(
      name: 'Priya Sharma',
      abdmId: '91-1234-5678-9012',
      age: 32,
      gender: 'Female',
      bloodGroup: 'O+',
      lastVisit: '15 Dec 2025',
      riskScore: 72,
      riskLevel: 'High',
      condition: 'Hypertension',
      nextAppointment: 'Tomorrow, 10:00 AM',
    ),
    Patient(
      name: 'Rahul Verma',
      abdmId: '91-9876-5432-1098',
      age: 45,
      gender: 'Male',
      bloodGroup: 'A+',
      lastVisit: '10 Dec 2025',
      riskScore: 45,
      riskLevel: 'Low',
      condition: 'Diabetes',
      nextAppointment: '20 Jan, 10:30 AM',
    ),
    Patient(
      name: 'Anita Singh',
      abdmId: '91-5555-6666-7777',
      age: 58,
      gender: 'Female',
      bloodGroup: 'B+',
      lastVisit: 'Today',
      riskScore: 88,
      riskLevel: 'High',
      condition: 'Cardiac Issue',
      nextAppointment: 'Today, 11:00 AM',
    ),
    Patient(
      name: 'Amit Patel',
      abdmId: '91-1111-2222-3333',
      age: 38,
      gender: 'Male',
      bloodGroup: 'AB+',
      lastVisit: '5 Dec 2025',
      riskScore: 35,
      riskLevel: 'Low',
      condition: 'General Checkup',
      nextAppointment: '25 Jan, 3:00 PM',
    ),
    Patient(
      name: 'Neha Gupta',
      abdmId: '91-4444-5555-6666',
      age: 29,
      gender: 'Female',
      bloodGroup: 'O-',
      lastVisit: '18 Dec 2025',
      riskScore: 28,
      riskLevel: 'Low',
      condition: 'Thyroid',
      nextAppointment: '22 Jan, 2:00 PM',
    ),
    Patient(
      name: 'Rajesh Kumar',
      abdmId: '91-7777-8888-9999',
      age: 52,
      gender: 'Male',
      bloodGroup: 'A-',
      lastVisit: '12 Dec 2025',
      riskScore: 65,
      riskLevel: 'Medium',
      condition: 'Cholesterol',
      nextAppointment: '18 Jan, 11:30 AM',
    ),
  ];

  @override
  void initState() {
    super.initState();
    filteredPatients = allPatients;
    _searchController.addListener(_filterPatients);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterPatients() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredPatients = allPatients.where((patient) {
        final matchesSearch = query.isEmpty ||
            patient.name.toLowerCase().contains(query) ||
            patient.abdmId.contains(query) ||
            patient.condition.toLowerCase().contains(query);

        final matchesFilter = selectedFilter == 'All' ||
            (selectedFilter == 'High Risk' && patient.riskLevel == 'High') ||
            (selectedFilter == 'Low Risk' && patient.riskLevel == 'Low') ||
            (selectedFilter == 'Medium Risk' && patient.riskLevel == 'Medium');

        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  void _selectFilter(String filter) {
    setState(() {
      selectedFilter = filter;
      _filterPatients();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            decoration: const BoxDecoration(
              color: Color(0xFF6BADE5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'My Patients',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '${allPatients.length} Total Patients',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by name, ID, or condition...',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () => _searchController.clear(),
                    )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Filter Pills
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterPill(
                        label: 'All',
                        count: allPatients.length,
                        isSelected: selectedFilter == 'All',
                        onTap: () => _selectFilter('All'),
                      ),
                      const SizedBox(width: 8),
                      _FilterPill(
                        label: 'High Risk',
                        count: allPatients.where((p) => p.riskLevel == 'High').length,
                        isSelected: selectedFilter == 'High Risk',
                        onTap: () => _selectFilter('High Risk'),
                        color: Colors.red,
                      ),
                      const SizedBox(width: 8),
                      _FilterPill(
                        label: 'Medium Risk',
                        count: allPatients.where((p) => p.riskLevel == 'Medium').length,
                        isSelected: selectedFilter == 'Medium Risk',
                        onTap: () => _selectFilter('Medium Risk'),
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      _FilterPill(
                        label: 'Low Risk',
                        count: allPatients.where((p) => p.riskLevel == 'Low').length,
                        isSelected: selectedFilter == 'Low Risk',
                        onTap: () => _selectFilter('Low Risk'),
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Patient List
          Expanded(
            child: filteredPatients.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text(
                    'No patients found',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: filteredPatients.length,
              itemBuilder: (context, index) {
                return _PatientCard(patient: filteredPatients[index]);
              },
            ),
          ),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.dashboard_outlined,
                  label: 'Dashboard',
                  onTap: () => Navigator.pop(context),
                ),
                _NavItem(
                  icon: Icons.people,
                  label: 'Patients',
                  isActive: true,
                  onTap: () {},
                ),
                _NavItem(
                  icon: Icons.description_outlined,
                  label: 'Prescriptions',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Prescriptions - Coming Soon!')),
                    );
                  },
                ),
                _NavItem(
                  icon: Icons.biotech_outlined,
                  label: 'Labs',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Labs - Coming Soon!')),
                    );
                  },
                ),
                _NavItem(
                  icon: Icons.person_outline,
                  label: 'Profile',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile - Coming Soon!')),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Patient {
  final String name;
  final String abdmId;
  final int age;
  final String gender;
  final String bloodGroup;
  final String lastVisit;
  final int riskScore;
  final String riskLevel;
  final String condition;
  final String nextAppointment;

  Patient({
    required this.name,
    required this.abdmId,
    required this.age,
    required this.gender,
    required this.bloodGroup,
    required this.lastVisit,
    required this.riskScore,
    required this.riskLevel,
    required this.condition,
    required this.nextAppointment,
  });
}

class _FilterPill extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? color;

  const _FilterPill({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final displayColor = color ?? const Color(0xFF6BADE5);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? displayColor : Colors.white,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? displayColor.withOpacity(0.1) : Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  color: isSelected ? displayColor : Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PatientCard extends StatelessWidget {
  final Patient patient;

  const _PatientCard({required this.patient});

  Color get _riskColor {
    switch (patient.riskLevel) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  patient.gender == 'Male' ? Icons.male : Icons.female,
                  color: const Color(0xFF6BADE5),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            patient.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C3E50),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _riskColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            patient.riskLevel,
                            style: TextStyle(
                              color: _riskColor,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${patient.age} yrs • ${patient.bloodGroup} • ${patient.gender}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'ID: ${patient.abdmId}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.medical_information_outlined, size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 6),
                    Text(
                      'Condition: ',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                    Text(
                      patient.condition,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 6),
                    Text(
                      'Next: ',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                    Text(
                      patient.nextAppointment,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'AI Risk Score',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              const Spacer(),
              Text(
                '${patient.riskScore}/100',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _riskColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: patient.riskScore / 100,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(_riskColor),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  label: const Text('View Profile'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF6BADE5),
                    side: const BorderSide(color: Color(0xFF6BADE5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.chat_bubble_outline, size: 18),
                  label: const Text('Message'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6BADE5),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFF6BADE5) : Colors.grey.shade400,
            size: 26,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? const Color(0xFF6BADE5) : Colors.grey.shade400,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}