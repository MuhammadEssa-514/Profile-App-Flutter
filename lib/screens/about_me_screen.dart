import 'package:flutter/material.dart';
import '../models/profile_model.dart';

class AboutMeScreen extends StatefulWidget {
  final Profile profile;
  const AboutMeScreen({super.key, required this.profile});

  @override
  State<AboutMeScreen> createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends State<AboutMeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) => _controller.forward();
  void _onTapUp(TapUpDetails details) => _controller.reverse();
  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Adaptive colors
    final buttonBg =
        isDark ? Colors.deepPurple.shade400 : Colors.deepPurple.shade600;

    final buttonBgPressed =
        isDark ? Colors.deepPurple.shade300 : Colors.deepPurple.shade800;

    final textColor = Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text("About Me"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section("Education", Icons.school, widget.profile.education),
          const SizedBox(height: 16),
          _skills(context),
          const SizedBox(height: 16),
          _section("Hobbies", Icons.favorite, widget.profile.hobbies),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: () => Navigator.pop(context),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final currentColor =
                Color.lerp(buttonBg, buttonBgPressed, _controller.value)!;

            return Transform.scale(
              scale: _scaleAnimation.value,
              child: FloatingActionButton.extended(
                onPressed: null, // We handle tap manually
                backgroundColor: currentColor,
                foregroundColor: textColor,
                elevation: 8,
                highlightElevation: 12,
                label: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                    SizedBox(width: 8),
                    Text(
                      "Back to Profile",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _section(String title, IconData icon, List<String> items) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.deepPurple),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 24),
            ...items.map((i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text("• $i", style: const TextStyle(fontSize: 15)),
                )),
          ],
        ),
      ),
    );
  }

  Widget _skills(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.star, color: Colors.deepPurple),
                SizedBox(width: 8),
                Text(
                  "Skills",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 10,
              children: widget.profile.skills.map((s) {
                final chipBg = isDark
                    ? Colors.white.withOpacity(0.12)
                    : const Color(0xFFF5F0FF);
                final labelColor = isDark ? Colors.white : Colors.black87;

                return Chip(
                  label: Text(
                    s.name,
                    style: TextStyle(
                      color: labelColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  backgroundColor: chipBg,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  avatar: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.deepPurple,
                    child: Text(
                      "${(s.level * 100).toInt()}%",
                      style: const TextStyle(fontSize: 9, color: Colors.white),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
