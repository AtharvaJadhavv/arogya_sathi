import 'package:flutter/material.dart';

class DoctorPrescriptionsScreen extends StatefulWidget {
  const DoctorPrescriptionsScreen({super.key});

  @override
  State<DoctorPrescriptionsScreen> createState() => _DoctorPrescriptionsScreenState();
}

class _DoctorPrescriptionsScreenState extends State<DoctorPrescriptionsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String selectedFilter = 'All';
  List<Prescription> filteredPrescriptions = [];

  final List<Prescription> allPrescriptions = [
    Prescription(
      id: 'RX-2025-001',
      patientName: 'Priya Sharma',
      abdmId: '91-1234-5678-9012',
      date: 'Today',
      medications: [
        Medication('Amlodipine', '5mg', 'Once daily', '30 days'),
        Medication('Aspirin', '75mg', 'Once daily', '30 days'),
      ],
      diagnosis: 'Hypertension - Stage 1',
      status: 'Active',
      followUp: '15 Feb 2026',
    ),
    Prescription(
      id: 'RX-2025-002',
      patientName: 'Rahul Verma',
      abdmId: '91-9876-5432-1098',
      date: '5 Jan 2026',
      medications: [
        Medication('Metformin', '500mg', 'Twice daily', '60 days'),
        Medication('Glimepiride', '2mg', 'Once daily', '60 days'),
      ],
      diagnosis: 'Type 2 Diabetes',
      status: 'Active',
      followUp: '5 Mar 2026',
    ),
    Prescription(
      id: 'RX-2024-098',
      patientName: 'Anita Singh',
      abdmId: '91-5555-6666-7777',
      date: '28 Dec 2025',
      medications: [
        Medication('Atorvastatin', '20mg', 'Once daily', '90 days'),
        Medication('Clopidogrel', '75mg', 'Once daily', '90 days'),
      ],
      diagnosis: 'Cardiac Risk - High Cholesterol',
      status: 'Completed',
      followUp: '28 Mar 2026',
    ),
    Prescription(
      id: 'RX-2024-095',
      patientName: 'Amit Patel',
      abdmId: '91-1111-2222-3333',
      date: '20 Dec 2025',
      medications: [
        Medication('Paracetamol', '500mg', 'As needed', '7 days'),
        Medication('Cetirizine', '10mg', 'Once daily', '7 days'),
      ],
      diagnosis: 'Common Cold',
      status: 'Completed',
      followUp: 'Not required',
    ),
    Prescription(
      id: 'RX-2025-003',
      patientName: 'Neha Gupta',
      abdmId: '91-4444-5555-6666',
      date: '3 Jan 2026',
      medications: [
        Medication('Levothyroxine', '50mcg', 'Once daily', '90 days'),
      ],
      diagnosis: 'Hypothyroidism',
      status: 'Active',
      followUp: '3 Apr 2026',
    ),
  ];

  @override
  void initState() {
    super.initState();
    filteredPrescriptions = allPrescriptions;
    _searchController.addListener(_filterPrescriptions);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterPrescriptions() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredPrescriptions = allPrescriptions.where((prescription) {
        final matchesSearch = query.isEmpty ||
            prescription.patientName.toLowerCase().contains(query) ||
            prescription.id.toLowerCase().contains(query) ||
            prescription.abdmId.contains(query) ||
            prescription.diagnosis.toLowerCase().contains(query);

        final matchesFilter = selectedFilter == 'All' ||
            (selectedFilter == 'Active' && prescription.status == 'Active') ||
            (selectedFilter == 'Completed' && prescription.status == 'Completed');

        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  void _selectFilter(String filter) {
    setState(() {
      selectedFilter = filter;
      _filterPrescriptions();
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
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline, color: Colors.white, size: 28),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Create New Prescription - Coming Soon!')),
                        );
                      },
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Prescriptions',
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
                    '${allPrescriptions.length} Total Prescriptions',
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
                    hintText: 'Search by patient, ID, or diagnosis...',
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
                        count: allPrescriptions.length,
                        isSelected: selectedFilter == 'All',
                        onTap: () => _selectFilter('All'),
                      ),
                      const SizedBox(width: 8),
                      _FilterPill(
                        label: 'Active',
                        count: allPrescriptions.where((p) => p.status == 'Active').length,
                        isSelected: selectedFilter == 'Active',
                        onTap: () => _selectFilter('Active'),
                        color: Colors.green,
                      ),
                      const SizedBox(width: 8),
                      _FilterPill(
                        label: 'Completed',
                        count: allPrescriptions.where((p) => p.status == 'Completed').length,
                        isSelected: selectedFilter == 'Completed',
                        onTap: () => _selectFilter('Completed'),
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Prescription List
          Expanded(
            child: filteredPrescriptions.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.description_outlined, size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text(
                    'No prescriptions found',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: filteredPrescriptions.length,
              itemBuilder: (context, index) {
                return _PrescriptionCard(prescription: filteredPrescriptions[index]);
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
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/doctor_home',
                          (route) => false,
                    );
                  },
                ),
                _NavItem(
                  icon: Icons.people_outline,
                  label: 'Patients',
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/doctor_patients');
                  },
                ),
                _NavItem(
                  icon: Icons.description,
                  label: 'Prescriptions',
                  isActive: true,
                  onTap: () {},
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

      // Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Create New Prescription - Coming Soon!')),
          );
        },
        backgroundColor: const Color(0xFF6BADE5),
        icon: const Icon(Icons.add),
        label: const Text('New Prescription'),
      ),
    );
  }
}

class Prescription {
  final String id;
  final String patientName;
  final String abdmId;
  final String date;
  final List<Medication> medications;
  final String diagnosis;
  final String status;
  final String followUp;

  Prescription({
    required this.id,
    required this.patientName,
    required this.abdmId,
    required this.date,
    required this.medications,
    required this.diagnosis,
    required this.status,
    required this.followUp,
  });
}

class Medication {
  final String name;
  final String dosage;
  final String frequency;
  final String duration;

  Medication(this.name, this.dosage, this.frequency, this.duration);
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

class _PrescriptionCard extends StatelessWidget {
  final Prescription prescription;

  const _PrescriptionCard({required this.prescription});

  Color get _statusColor {
    return prescription.status == 'Active' ? Colors.green : Colors.grey;
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
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.description,
                  color: Color(0xFF6BADE5),
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
                        Text(
                          prescription.id,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6BADE5),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            prescription.status,
                            style: TextStyle(
                              color: _statusColor,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      prescription.date,
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
          const Divider(),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.person_outline, size: 16, color: Colors.grey),
              const SizedBox(width: 6),
              Text(
                prescription.patientName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'ID: ${prescription.abdmId}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.orange.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.medical_information_outlined, size: 16, color: Colors.orange),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    prescription.diagnosis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Medications (${prescription.medications.length})',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...prescription.medications.map((med) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6BADE5),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${med.name} ${med.dosage} - ${med.frequency} (${med.duration})',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey.shade600),
              const SizedBox(width: 6),
              Text(
                'Follow-up: ${prescription.followUp}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download_outlined, size: 18),
                  label: const Text('Download'),
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
                  icon: const Icon(Icons.share_outlined, size: 18),
                  label: const Text('Share'),
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