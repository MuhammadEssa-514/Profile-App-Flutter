import 'package:flutter/material.dart';
import 'profile_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onToggle;
  final bool dark;

  const WelcomeScreen({super.key, required this.onToggle, required this.dark});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image using the profile image with an overlay for
          // readability. The overlay color adapts to light/dark mode.
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/scree_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              // overlay to improve contrast between text and image
              decoration: BoxDecoration(
                color: dark
                    ? const Color.fromARGB(82, 30, 81, 2).withOpacity(0.45)
                    : const Color.fromARGB(128, 173, 172, 172)
                        .withOpacity(0.35),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to Muhammad Essa Profile',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: dark
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(221, 255, 255, 255),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36.0),
                    child: Text(
                      'I build beautiful, responsive mobile apps using Flutter. Browse my profile to see projects, skills, and ways to get in touch.',
                      style: TextStyle(
                        fontSize: 16,
                        color: dark
                            ? Colors.white70
                            : const Color.fromARGB(221, 194, 192, 192),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 24.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProfileScreen(onToggle: onToggle, dark: dark),
                        ),
                      ),
                      child: const Text('View Profile',
                          style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              icon: Icon(dark ? Icons.light_mode : Icons.dark_mode,
                  color: Colors.white),
              onPressed: onToggle,
            ),
          ),
        ],
      ),
    );
  }
}
