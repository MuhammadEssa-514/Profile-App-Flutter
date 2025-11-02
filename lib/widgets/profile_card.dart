import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final Widget child;
  const ProfileCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }
}
