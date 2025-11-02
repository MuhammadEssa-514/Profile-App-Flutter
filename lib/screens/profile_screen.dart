import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/profile_model.dart';
import '../widgets/profile_card.dart';
import '../widgets/contact_item.dart';
import '../widgets/social_button.dart';
import 'about_me_screen.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback onToggle;
  final bool dark;

  const ProfileScreen({super.key, required this.onToggle, required this.dark});

  static const Profile profile = Profile(
    name: "Muhammad Essa",
    profession: "Frontend Developer",
    bio:
        "Passionate Frontend developer crafting beautiful, responsive apps with Flutter. Love clean code, animations, and coffee.",
    email: "muhammadessa1514@gmail.com",
    phone: "+92 3194944514",
    location: "Gilgit, Pakistan",
    skills: [
      Skill("Flutter", 0.3),
      Skill("Dart", 0.2),
      Skill("Firebase", 0.1),
      Skill("UI/UX", 0.3),
      Skill("HTML", 0.95),
      Skill("Css", 0.85),
      Skill("Javascript", 0.95),
      Skill("NextJs", 0.85),
    ],
    education: [
      "Matric in Computer Science – Army Public Jutial Gilgit (2021)",
      "FSC in Computer Science – Army Public Jutial Gilgit (2023)",
      "ADP in Computer Science – UMT University lahore (2023-2025)",
      "BS in Computer Science – KIU Gilgit (2025-continue)",
    ],
    hobbies: [
      "listening music",
      "Gaming",
      "Travel",
      "watching movies related to technology"
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        actions: [
          IconButton(
            icon: Icon(dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: onToggle,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile picture
            const Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
            ),
            const SizedBox(height: 20),

            // Name & profession
            Text(
              profile.name,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(
              profile.profession,
              style: TextStyle(fontSize: 18, color: Colors.deepPurple[700]),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                profile.bio,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),

            // Contact Card – Now includes WhatsApp, LinkedIn, GitHub
            ProfileCard(
              child: Column(
                children: [
                  // Email
                  ContactItem(
                    icon: Icons.email_outlined,
                    label: "Email",
                    value: profile.email,
                    backgroundColor: Colors.deepPurple.shade50,
                    iconColor: Colors.deepPurple,
                    onTap: () => _launch('mailto:${profile.email}'),
                    trailingIcon: Icons.send,
                    trailingOnTap: () => _launch('mailto:${profile.email}'),
                  ),
                  const Divider(height: 1),

                  // Phone
                  ContactItem(
                    icon: Icons.phone_android,
                    label: "Phone",
                    value: profile.phone,
                    backgroundColor: Colors.teal.shade50,
                    iconColor: Colors.teal[700],
                    onTap: () => _launch('tel:${profile.phone}'),
                    trailingIcon: Icons.call,
                    trailingOnTap: () => _launch('tel:${profile.phone}'),
                  ),
                  const Divider(height: 1),

                  // Location
                  ContactItem(
                    icon: Icons.location_on_outlined,
                    label: "Location",
                    value: profile.location,
                    backgroundColor: Colors.orange.shade50,
                    iconColor: Colors.deepOrange,
                    onTap: () => _openMap(profile.location),
                    trailingIcon: Icons.map,
                    trailingOnTap: () => _openMap(profile.location),
                  ),
                  const Divider(height: 1),

                  // WhatsApp
                  ContactItem(
                    icon: Icons.message_rounded,
                    label: "WhatsApp",
                    value: "03555915756",
                    backgroundColor: Colors.green.shade50,
                    iconColor: Colors.green[700],
                    onTap: () => _launchWhatsApp(profile.phone),
                    trailingIcon: Icons.open_in_new,
                    trailingOnTap: () => _launchWhatsApp(profile.phone),
                  ),
                  const Divider(height: 1),

                  // LinkedIn
                  ContactItem(
                    icon: Icons.work_outline,
                    label: "LinkedIn",
                    value: "Muhammad-Essa",
                    backgroundColor: Colors.blue.shade50,
                    iconColor: Colors.blue[700],
                    onTap: () =>
                        _launch('https://linkedin.com/in/muhammad-essa'),
                    trailingIcon: Icons.open_in_new,
                    trailingOnTap: () =>
                        _launch('https://linkedin.com/in/muhammad-essa'),
                  ),
                  const Divider(height: 1),

                  // GitHub
                  ContactItem(
                    icon: Icons.code,
                    label: "GitHub",
                    value: "MuhammadEssa-514",
                    backgroundColor: Colors.grey.shade200,
                    iconColor: Colors.black87,
                    onTap: () => _launch('https://github.com/MuhammadEssa-514'),
                    trailingIcon: Icons.open_in_new,
                    trailingOnTap: () =>
                        _launch('https://github.com/MuhammadEssa-514'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Optional: Keep small social icons below (or delete this Row)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialButton(
                    icon: Icons.work,
                    url: "https://linkedin.com/in/muhammad-essa"),
                SocialButton(
                    icon: Icons.code,
                    url: "https://github.com/MuhammadEssa-514"),
                SocialButton(
                    icon: Icons.message,
                    url:
                        "https://wa.me/${profile.phone.replaceAll(RegExp(r'\D'), '')}"),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AboutMeScreen(profile: profile)),
        ),
        label: const Text("About Me"),
        icon: const Icon(Icons.person_outline),
      ),
    );
  }

  // Launch any URL
  void _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  // Open Google Maps
  void _openMap(String query) async {
    final encoded = Uri.encodeComponent(query);
    final uri =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$encoded');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  // Open WhatsApp chat
  void _launchWhatsApp(String phone) async {
    final cleanPhone = phone.replaceAll(RegExp(r'\D'), ''); // Remove +,-,spaces
    final uri = Uri.parse('https://wa.me/$cleanPhone');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }
}
