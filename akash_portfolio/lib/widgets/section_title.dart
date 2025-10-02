import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  
  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyles.heading1.copyWith(
            fontSize: MediaQuery.of(context).size.width < 600 ? 36 : 48,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppSpacing.md),
        Container(
          width: 100,
          height: 4,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.accent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}