import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/section_title.dart';

class SkillsPage extends StatefulWidget {
  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  final List<Map<String, dynamic>> skillCategories = [
    {
      'category': 'Frontend Development',
      'color': Colors.blue,
      'skills': [
        {'name': 'Flutter/Dart', 'percentage': 0.95, 'icon': Icons.phone_android},
        {'name': 'React.js', 'percentage': 0.85, 'icon': Icons.web},
        {'name': 'HTML/CSS', 'percentage': 0.90, 'icon': Icons.code},
        {'name': 'JavaScript', 'percentage': 0.88, 'icon': Icons.javascript},
      ],
    },
    {
      'category': 'Backend Development',
      'color': Colors.green,
      'skills': [
        {'name': 'Golang', 'percentage': 0.90, 'icon': Icons.api},
        {'name': 'Node.js', 'percentage': 0.80, 'icon': Icons.dns},
        {'name': 'RESTful APIs', 'percentage': 0.95, 'icon': Icons.webhook},
        {'name': 'Microservices', 'percentage': 0.85, 'icon': Icons.hub},
      ],
    },
    {
      'category': 'Database & DevOps',
      'color': Colors.orange,
      'skills': [
        {'name': 'MongoDB', 'percentage': 0.85, 'icon': Icons.storage},
        {'name': 'PostgreSQL', 'percentage': 0.80, 'icon': Icons.table_chart},
        {'name': 'Docker', 'percentage': 0.75, 'icon': Icons.directions_boat},
        {'name': 'AWS', 'percentage': 0.70, 'icon': Icons.cloud},
      ],
    },
    {
      'category': 'Other Skills',
      'color': Colors.purple,
      'skills': [
        {'name': 'Git', 'percentage': 0.90, 'icon': Icons.code_off},
        {'name': 'Grafana', 'percentage': 0.85, 'icon': Icons.analytics},
        {'name': 'Machine Learning', 'percentage': 0.70, 'icon': Icons.psychology},
        {'name': 'UI/UX Design', 'percentage': 0.80, 'icon': Icons.design_services},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.xl),
          child: Column(
            children: [
              SectionTitle(title: 'Technical Skills'),
              SizedBox(height: AppSpacing.xl),
              AnimationLimiter(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: size.width < 800 ? 1 : 2,
                    crossAxisSpacing: AppSpacing.xl,
                    mainAxisSpacing: AppSpacing.xl,
                    childAspectRatio: size.width < 800 ? 1.5 : 1.2,
                  ),
                  itemCount: skillCategories.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: Duration(milliseconds: 500),
                      columnCount: 2,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: _buildSkillCategory(skillCategories[index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillCategory(Map<String, dynamic> category) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: category['color'].withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: category['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.category,
                  color: category['color'],
                  size: 24,
                ),
              ),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  category['category'],
                  style: AppTextStyles.heading3,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.lg),
          Expanded(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.lg,
                mainAxisSpacing: AppSpacing.lg,
                childAspectRatio: 1,
              ),
              itemCount: category['skills'].length,
              itemBuilder: (context, index) {
                final skill = category['skills'][index];
                return _buildSkillItem(
                  skill['name'],
                  skill['percentage'],
                  skill['icon'],
                  category['color'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillItem(String name, double percentage, IconData icon, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 8.0,
          percent: percentage,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 24),
              SizedBox(height: 4),
              Text(
                '${(percentage * 100).toInt()}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: color,
                ),
              ),
            ],
          ),
          progressColor: color,
          backgroundColor: color.withOpacity(0.2),
          animation: true,
          animationDuration: 1500,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        SizedBox(height: AppSpacing.sm),
        Text(
          name,
          textAlign: TextAlign.center,
          style: AppTextStyles.body.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}