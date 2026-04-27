import 'package:flutter/material.dart';

class ScheduleCheckupScreen extends StatefulWidget {
  const ScheduleCheckupScreen({super.key});

  @override
  State<ScheduleCheckupScreen> createState() => _ScheduleCheckupScreenState();
}

class _ScheduleCheckupScreenState extends State<ScheduleCheckupScreen> {
  String? selectedCheckupType;
  String? selectedDate;
  String? selectedTime;

  final List<CheckupType> checkupTypes = [
    CheckupType('General Health Checkup', 500, 30),
    CheckupType('Cardiac Health Checkup', 1200, 45),
    CheckupType('Diabetes Checkup', 800, 30),
    CheckupType('Thyroid Checkup', 700, 30),
  ];

  final List<DateOption> dateOptions = [
    DateOption('Thu', '8 Jan'),
    DateOption('Fri', '9 Jan'),
    DateOption('Sat', '10 Jan'),
    DateOption('Sun', '11 Jan'),
    DateOption('Mon', '12 Jan'),
    DateOption('Tue', '13 Jan'),
    DateOption('Wed', '14 Jan'),
  ];

  final List<String> timeSlots = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
            decoration: const BoxDecoration(
              color: Color(0xFF6BADE5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back, color: Colors.white, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Back',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Schedule Health Checkup',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Choose your checkup type and time',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Checkup Types
                  ...checkupTypes.asMap().entries.map((entry) {
                    int index = entry.key;
                    CheckupType checkup = entry.value;
                    return TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 300 + (index * 100)),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.easeOutBack,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Opacity(
                            opacity: value,
                            child: child,
                          ),
                        );
                      },
                      child: _CheckupTypeCard(
                        checkup: checkup,
                        isSelected: selectedCheckupType == checkup.name,
                        onTap: () {
                          setState(() {
                            selectedCheckupType = checkup.name;
                          });
                        },
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 24),

                  // Select Date
                  Text(
                    'Select Date',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 12),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: dateOptions.map((date) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: _DateCard(
                            date: date,
                            isSelected: selectedDate == date.fullDate,
                            onTap: () {
                              setState(() {
                                selectedDate = date.fullDate;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Select Time
                  Text(
                    'Select Time',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 12),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2.2,
                    ),
                    itemCount: timeSlots.length,
                    itemBuilder: (context, index) {
                      return _TimeSlotCard(
                        time: timeSlots[index],
                        isSelected: selectedTime == timeSlots[index],
                        onTap: () {
                          setState(() {
                            selectedTime = timeSlots[index];
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  // Confirm Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: selectedCheckupType != null &&
                          selectedDate != null &&
                          selectedTime != null
                          ? () {
                        _showConfirmationDialog(context);
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6BADE5),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey.shade300,
                        disabledForegroundColor: Colors.grey.shade500,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Confirm Checkup',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 12),
            Text('Checkup Scheduled!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: $selectedCheckupType'),
            const SizedBox(height: 8),
            Text('Date: $selectedDate'),
            const SizedBox(height: 8),
            Text('Time: $selectedTime'),
            const SizedBox(height: 16),
            const Text(
              'You will receive a confirmation message shortly.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class CheckupType {
  final String name;
  final int price;
  final int duration;

  CheckupType(this.name, this.price, this.duration);
}

class DateOption {
  final String day;
  final String date;

  DateOption(this.day, this.date);

  String get fullDate => '$day $date';
}

class _CheckupTypeCard extends StatefulWidget {
  final CheckupType checkup;
  final bool isSelected;
  final VoidCallback onTap;

  const _CheckupTypeCard({
    required this.checkup,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_CheckupTypeCard> createState() => _CheckupTypeCardState();
}

class _CheckupTypeCardState extends State<_CheckupTypeCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        transform: Matrix4.identity()..scale(_isPressed ? 0.97 : 1.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: widget.isSelected
                ? const Color(0xFF6BADE5)
                : Colors.grey.shade200,
            width: widget.isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isSelected
                  ? const Color(0xFF6BADE5).withOpacity(0.2)
                  : Colors.black.withOpacity(0.03),
              blurRadius: widget.isSelected ? 8 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.checkup.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: widget.isSelected
                          ? const Color(0xFF6BADE5)
                          : Colors.grey.shade800,
                    ),
                  ),
                ),
                Text(
                  '₹${widget.checkup.price}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: widget.isSelected
                        ? const Color(0xFF6BADE5)
                        : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Duration: ${widget.checkup.duration} min',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateCard extends StatefulWidget {
  final DateOption date;
  final bool isSelected;
  final VoidCallback onTap;

  const _DateCard({
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_DateCard> createState() => _DateCardState();
}

class _DateCardState extends State<_DateCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        transform: Matrix4.identity()..scale(_isPressed ? 0.95 : 1.0),
        decoration: BoxDecoration(
          color: widget.isSelected ? const Color(0xFF6BADE5) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: widget.isSelected
                ? const Color(0xFF6BADE5)
                : Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isSelected
                  ? const Color(0xFF6BADE5).withOpacity(0.3)
                  : Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              widget.date.day,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: widget.isSelected ? Colors.white : Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.date.date,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: widget.isSelected ? Colors.white : Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeSlotCard extends StatefulWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  const _TimeSlotCard({
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_TimeSlotCard> createState() => _TimeSlotCardState();
}

class _TimeSlotCardState extends State<_TimeSlotCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.identity()..scale(_isPressed ? 0.95 : 1.0),
        decoration: BoxDecoration(
          color: widget.isSelected ? const Color(0xFF6BADE5) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.isSelected
                ? const Color(0xFF6BADE5)
                : Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isSelected
                  ? const Color(0xFF6BADE5).withOpacity(0.3)
                  : Colors.black.withOpacity(0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.access_time,
              color: widget.isSelected ? Colors.white : Colors.grey.shade600,
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              widget.time,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: widget.isSelected ? Colors.white : Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}