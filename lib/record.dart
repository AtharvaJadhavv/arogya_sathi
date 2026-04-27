import 'package:flutter/material.dart';

class MedicalRecordsScreen extends StatefulWidget {
  const MedicalRecordsScreen({super.key});

  @override
  State<MedicalRecordsScreen> createState() => _MedicalRecordsScreenState();
}

class _MedicalRecordsScreenState extends State<MedicalRecordsScreen> {
  String selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  List<MedicalRecord> filteredRecords = [];

  final List<MedicalRecord> allRecords = [
    MedicalRecord(
      title: 'Hypertension - Stage 1',
      date: '15 Nov 2025',
      doctor: 'Dr. Rajesh Kumar',
      hospital: 'Apollo Hospital, Delhi',
      description: 'Diagnosed with Stage 1 Hypertension. Lifestyle modifications and medication recommended.',
      tags: ['cardiology', 'hypertension'],
      icon: Icons.favorite_outline,
      iconColor: Color(0xFF6BADE5),
      backgroundColor: Color(0xFFE3F2FD),
      category: 'Diagnosis',
    ),
    MedicalRecord(
      title: 'COVID-19 Booster Dose',
      date: '5 Oct 2025',
      doctor: '',
      hospital: 'Vaccination Center • Government Hospital, Delhi',
      description: 'COVID-19 vaccine booster dose administered.',
      tags: ['vaccination', 'covid-19'],
      icon: Icons.vaccines_outlined,
      iconColor: Color(0xFFE57373),
      backgroundColor: Color(0xFFFFEBEE),
      category: 'Prescriptions',
    ),
    MedicalRecord(
      title: 'Lipid Profile Test',
      date: '18 Sept 2025',
      doctor: 'Dr. Rajesh Kumar',
      hospital: 'Apollo Diagnostics, Delhi',
      description: 'Lipid profile showing elevated LDL cholesterol levels.',
      tags: ['lab test', 'cholesterol'],
      icon: Icons.science_outlined,
      iconColor: Color(0xFF81C784),
      backgroundColor: Color(0xFFE8F5E9),
      category: 'Lab Reports',
    ),
  ];

  @override
  void initState() {
    super.initState();
    filteredRecords = allRecords;
    _searchController.addListener(_filterRecords);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterRecords() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredRecords = allRecords.where((record) {
        final matchesSearch = query.isEmpty ||
            record.title.toLowerCase().contains(query) ||
            record.description.toLowerCase().contains(query) ||
            record.tags.any((tag) => tag.toLowerCase().contains(query));

        final matchesCategory = selectedCategory == 'All' ||
            record.category == selectedCategory;

        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void _selectCategory(String category) {
    setState(() {
      selectedCategory = category;
      _filterRecords();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Medical Records',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Search Bar
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search records...',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () => _searchController.clear(),
                      )
                          : null,
                      filled: true,
                      fillColor: const Color(0xFFF5F7FA),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Category Pills
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _CategoryPill(
                          label: 'All',
                          isSelected: selectedCategory == 'All',
                          onTap: () => _selectCategory('All'),
                        ),
                        const SizedBox(width: 12),
                        _CategoryPill(
                          label: 'Prescriptions',
                          isSelected: selectedCategory == 'Prescriptions',
                          onTap: () => _selectCategory('Prescriptions'),
                        ),
                        const SizedBox(width: 12),
                        _CategoryPill(
                          label: 'Lab Reports',
                          isSelected: selectedCategory == 'Lab Reports',
                          onTap: () => _selectCategory('Lab Reports'),
                        ),
                        const SizedBox(width: 12),
                        _CategoryPill(
                          label: 'Diagnosis',
                          isSelected: selectedCategory == 'Diagnosis',
                          onTap: () => _selectCategory('Diagnosis'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Timeline
            Expanded(
              child: filteredRecords.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.folder_open, size: 64, color: Colors.grey.shade300),
                    const SizedBox(height: 16),
                    Text(
                      'No records found',
                      style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: filteredRecords.length,
                itemBuilder: (context, index) {
                  return _RecordCard(
                    record: filteredRecords[index],
                    isFirst: index == 0,
                    isLast: index == filteredRecords.length - 1,
                  );
                },
              ),
            ),

            // Bottom Navigation Bar
            Container(
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
                        icon: Icons.home_outlined,
                        label: 'Home',
                        onTap: () => Navigator.pushReplacementNamed(context, '/patient_dashboard'),
                      ),
                      _NavItem(
                        icon: Icons.description,
                        label: 'Records',
                        isActive: true,
                        onTap: () {},
                      ),
                      _NavItem(
                        icon: Icons.psychology_outlined,
                        label: 'AI Care',
                        onTap: () => Navigator.pushReplacementNamed(context, '/aicare'),
                      ),
                      _NavItem(
                        icon: Icons.verified_user_outlined,
                        label: 'Consent',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Consent - Coming Soon!')),
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
          ],
        ),
      ),
    );
  }
}

class MedicalRecord {
  final String title;
  final String date;
  final String doctor;
  final String hospital;
  final String description;
  final List<String> tags;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String category;

  MedicalRecord({
    required this.title,
    required this.date,
    required this.doctor,
    required this.hospital,
    required this.description,
    required this.tags,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.category,
  });
}

class _CategoryPill extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6BADE5) : const Color(0xFFE8F4FB),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF6BADE5),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _RecordCard extends StatelessWidget {
  final MedicalRecord record;
  final bool isFirst;
  final bool isLast;

  const _RecordCard({
    required this.record,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Timeline Line
        Positioned(
          left: 19,
          top: isFirst ? 30 : 0,
          bottom: isLast ? null : 0,
          child: Container(
            width: 2,
            color: Colors.grey.shade300,
            height: isLast ? 30 : null,
          ),
        ),

        // Content
        Padding(
          padding: const EdgeInsets.only(left: 50, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline Dot
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: record.iconColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ],
                ),
              ),

              // Card
              Container(
                decoration: BoxDecoration(
                  color: record.backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: record.iconColor.withOpacity(0.2)),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(record.icon, color: record.iconColor, size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            record.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C3E50),
                            ),
                          ),
                        ),
                        Text(
                          record.date,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (record.doctor.isNotEmpty)
                      Text(
                        '${record.doctor} • ${record.hospital}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      )
                    else
                      Text(
                        record.hospital,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    const SizedBox(height: 12),
                    Text(
                      record.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade800,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: record.tags
                          .map((tag) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ))
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.description, size: 18),
                            label: const Text('View'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: record.iconColor,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.download_outlined),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.share_outlined),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
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