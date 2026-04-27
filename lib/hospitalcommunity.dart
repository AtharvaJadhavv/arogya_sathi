import 'package:flutter/material.dart';

class HospitalCommunityPage extends StatefulWidget {
  const HospitalCommunityPage({super.key});

  @override
  State<HospitalCommunityPage> createState() => _HospitalCommunityPageState();
}

class _HospitalCommunityPageState extends State<HospitalCommunityPage> {
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Awareness',
    'Recovery Stories',
    'Wellbeing',
    'Announcements'
  ];

  final List<CommunityPost> allPosts = [
    CommunityPost(
      author: 'Hospital Administration',
      hospital: 'Apollo Hospital',
      type: 'Announcement',
      typeColor: const Color(0xFFE85D75),
      icon: Icons.apps,
      iconColor: const Color(0xFF6C5CE7),
      title: 'New Telehealth Services Now Available',
      description:
      'Connect with your doctors from the comfort of your home. Introducing our new telemedicine platform.',
      relevantFor: 'General',
      likes: 198,
      loves: 56,
    ),
    CommunityPost(
      author: 'Apollo Hospital',
      hospital: 'Apollo Hospital',
      type: 'Announcement',
      typeColor: const Color(0xFFE85D75),
      icon: Icons.favorite,
      iconColor: const Color(0xFFE85D75),
      title: 'Free Health Checkup Camp - January 15-17',
      description:
      'Join us for comprehensive health screenings. Early detection saves lives.',
      relevantFor: 'General',
      likes: 234,
      loves: 67,
    ),
    CommunityPost(
      author: 'Apollo Wellness Team',
      hospital: 'Apollo Hospital',
      type: 'Recovery Story',
      typeColor: const Color(0xFF5FC6B2),
      icon: Icons.nature,
      iconColor: const Color(0xFF27AE60),
      title: 'Recovery Journey: From Diagnosis to Strength',
      description:
      'Inspiring story of resilience and hope. Recovery is a journey, not a destination.',
      relevantFor: 'Diabetes, Cardiac Care, Orthopedics',
      likes: 234,
      loves: 178,
    ),
    CommunityPost(
      author: 'Apollo Wellness Team',
      hospital: 'Apollo Hospital',
      type: 'Recovery Story',
      typeColor: const Color(0xFF5FC6B2),
      icon: Icons.star,
      iconColor: const Color(0xFFFFC107),
      title: 'Celebrating Small Victories in Recovery',
      description:
      'Every step forward matters. Celebrate your progress, no matter how small.',
      relevantFor: 'General',
      likes: 267,
      loves: 223,
    ),
    CommunityPost(
      author: 'Dr. Rajesh Kumar',
      hospital: 'Apollo Hospital',
      type: 'Health Awareness',
      typeColor: const Color(0xFF6BADE5),
      icon: Icons.favorite,
      iconColor: const Color(0xFFE85D75),
      title: 'Understanding Heart Health: Simple Steps for a Healthier Heart',
      description:
      'Small lifestyle changes can make a big difference in your cardiac health. Learn evidence-based tips for heart...',
      relevantFor: 'Hypertension, Cardiac Care',
      likes: 156,
      loves: 89,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredPosts = selectedCategory == 'All'
        ? allPosts
        : allPosts
        .where((post) =>
    (selectedCategory == 'Announcements' &&
        post.type == 'Announcement') ||
        (selectedCategory == 'Recovery Stories' &&
            post.type == 'Recovery Story') ||
        (selectedCategory == 'Awareness' &&
            post.type == 'Health Awareness') ||
        (selectedCategory == 'Wellbeing' && post.type == 'Wellbeing'))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF6BADE5),
                    const Color(0xFF5FC6B2),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      IconButton(
                        icon:
                        const Icon(Icons.trending_up, color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.people,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hospital Community',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Row(
                                  children: [
                                    Text(
                                      'Apollo Hospital',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.verified,
                                      size: 14,
                                      color: Colors.white70,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Category Tabs
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categories
                                .map((category) => Padding(
                              padding:
                              const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = category;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: selectedCategory == category
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.2),
                                    borderRadius:
                                    BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: selectedCategory == category
                                          ? const Color(0xFF6BADE5)
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ))
                                .toList(),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Scroll Indicator
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade600,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Educational Disclaimer
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFBBDEFB),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info,
                          color: Color(0xFF6BADE5),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Educational & Support Only. This is not medical advice. Always consult your doctor.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Posts List
                  ...filteredPosts.map((post) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: _CommunityPostCard(post: post),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommunityPost {
  final String author;
  final String hospital;
  final String type;
  final Color typeColor;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String relevantFor;
  final int likes;
  final int loves;

  CommunityPost({
    required this.author,
    required this.hospital,
    required this.type,
    required this.typeColor,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.relevantFor,
    required this.likes,
    required this.loves,
  });
}

class _CommunityPostCard extends StatelessWidget {
  final CommunityPost post;

  const _CommunityPostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Author Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.author,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    post.hospital,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: post.typeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  post.type,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: post.typeColor,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Icon and Title
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    String.fromCharCode(post.icon.codePoint),
                    style: TextStyle(
                      fontSize: 28,
                      color: post.iconColor,
                      fontFamily: post.icon.fontFamily,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      post.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Relevant For
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                size: 14,
                color: Color(0xFF6BADE5),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Relevant for: ${post.relevantFor}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6BADE5),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.thumb_up_outlined,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${post.likes}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.favorite_outline,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${post.loves}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.bookmark_outline,
                size: 18,
                color: Colors.grey.shade600,
              ),
            ],
          ),
        ],
      ),
    );
  }
}