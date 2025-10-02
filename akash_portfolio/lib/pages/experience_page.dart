import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/section_title.dart';

class ExperiencePage extends StatefulWidget {
  @override
  _ExperiencePageState createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  final List<Map<String, dynamic>> experiences = [
    {
      'company': 'greenkwh.net',
      'role': 'Full Stack Developer',
      'duration': 'Jan 2025 - Present',
      'location': 'Bangalore, Karnataka',
      'logo': Icons.business,
      'color': Colors.green,
      'achievements': [
        'Built and integrated scalable REST APIs in Golang with Flutter frontend and React components',
        'Improved system responsiveness by 30% through optimization',
        'Implemented Grafana dashboards with Prometheus & Pushgateway',
        'Worked with MongoDB and PostgreSQL for large-scale IoT data',
        'Containerized services with Docker and deployed on AWS EC2',
        'Managed Git workflows for team collaboration',
      ],
      'technologies': ['Golang', 'Flutter', 'React', 'MongoDB', 'PostgreSQL', 'Docker', 'AWS', 'Grafana'],
    },
    {
      'company': 'Freelance Project',
      'role': 'Full Stack Developer',
      'duration': 'Nov 2024 - Dec 2024',
      'location': 'Remote',
      'logo': Icons.work,
      'color': Colors.blue,
      'achievements': [
        'Developed responsive website (gyplife.com) using Flutter',
        'Ensured cross-platform accessibility',
        'Deployed on GoDaddy with DNS configuration',
        'Achieved 99.9% uptime and seamless access',
        'Handled end-to-end development from requirements to deployment',
      ],
      'technologies': ['Flutter', 'Dart', 'Web Development', 'GoDaddy'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.xl),
        child: Column(
          children: [
            SectionTitle(title: 'Professional Experience'),
            SizedBox(height: AppSpacing.xl),
            Container(
              constraints: BoxConstraints(maxWidth: 1000),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: experiences.length,
                itemBuilder: (context, index) {
                  final exp = experiences[index];
                  final isFirst = index == 0;
                  final isLast = index == experiences.length - 1;
                  
                  return TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: 0.3,
                    isFirst: isFirst,
                    isLast: isLast,
                    indicatorStyle: IndicatorStyle(
                      width: 50,
                      height: 50,
                      indicator: Container(
                        decoration: BoxDecoration(
                          color: exp['color'],
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: exp['color'].withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(
                          exp['logo'],
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                    beforeLineStyle: LineStyle(
                      color: exp['color'].withOpacity(0.3),
                      thickness: 3,
                    ),
                    startChild: Container(
                      constraints: BoxConstraints(
                        minHeight: 200,
                      ),
                      padding: EdgeInsets.only(right: AppSpacing.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            exp['duration'],
                            style: AppTextStyles.body.copyWith(
                              fontWeight: FontWeight.w600,
                              color: exp['color'],
                            ),
                          ),
                          SizedBox(height: AppSpacing.xs),
                          Text(
                            exp['location'],
                            style: AppTextStyles.body.copyWith(
                              fontSize: 14,
                              color: AppColors.textLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    endChild: Container(
                      margin: EdgeInsets.only(
                        left: AppSpacing.lg,
                        bottom: AppSpacing.xl,
                        top: AppSpacing.md,
                      ),
                      child: _buildExperienceCard(exp),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceCard(Map<String, dynamic> exp) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: exp['color'].withOpacity(0.1),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exp['company'],
                      style: AppTextStyles.heading3.copyWith(
                        color: exp['color'],
                      ),
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      exp['role'],
                      style: AppTextStyles.body.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: exp['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  exp['duration'].contains('Present') ? 'Current' : 'Completed',
                  style: TextStyle(
                    color: exp['color'],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.lg),
          Text(
            'Key Achievements:',
            style: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          ...exp['achievements'].map<Widget>((achievement) => Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: exp['color'],
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    achievement,
                    style: AppTextStyles.body,
                  ),
                ),
              ],
            ),
          )).toList(),
          SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: exp['technologies'].map<Widget>((tech) => Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: exp['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                tech,
                style: TextStyle(
                  color: exp['color'],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}