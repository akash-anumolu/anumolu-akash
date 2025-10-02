import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.accent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'AA',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(width: AppSpacing.md),
          Text(
            'Akash Anumolu',
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.text,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/home'),
          child: Text('Home'),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/about'),
          child: Text('About'),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/skills'),
          child: Text('Skills'),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/experience'),
          child: Text('Experience'),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/projects'),
          child: Text('Projects'),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/contact'),
          child: Text('Contact'),
        ),
        SizedBox(width: AppSpacing.lg),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}