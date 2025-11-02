import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String url;
  const SocialButton({super.key, required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 32, color: Colors.deepPurple[700]),
      onPressed: () => launchUrl(Uri.parse(url)),
    );
  }
}
