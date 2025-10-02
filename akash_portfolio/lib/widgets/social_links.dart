import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';

class SocialLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildSocialIcon(
          icon: Icons.email,
          url: 'mailto:anumoluakash@gmail.com',
          color: Colors.red,
        ),
        SizedBox(width: AppSpacing.md),
        _buildSocialIcon(
          icon: Icons.code,
          url: 'https://github.com/akash-anumolu',
          color: Colors.black,
        ),
        SizedBox(width: AppSpacing.md),
        _buildSocialIcon(
          icon: Icons.work,
          url: 'https://www.linkedin.com/in/akash-anumolu-a54b42227/',
          color: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildSocialIcon({
    required IconData icon,
    required String url,
    required Color color,
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: IconButton(
        onPressed: () async {
          if (await canLaunch(url)) {
            await launch(url);
          }
        },
        icon: Icon(icon, size: 20, color: color),
        padding: EdgeInsets.zero,
      ),
    );
  }
}