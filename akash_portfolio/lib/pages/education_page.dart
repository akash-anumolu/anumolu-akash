import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../utils/constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/section_title.dart';

class EducationPage extends StatefulWidget {
  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> education = [
    {
      'degree': 'B.Tech in Computer Science',
      'institution': 'Vellore Institute of Technology (VIT)',
      'location': 'Amaravati, Guntur, Andhra Pradesh',
      'duration': '2021 - 2025',
      'cgpa': '8.16',
      'icon': Icons.school,
      'color': Colors.blue,
      'courses': [
        'Data Structures & Algorithms',
        'Database Management Systems',
        'Operating Systems',
        'Computer Networks',
        'Machine Learning',
        'Web Development',
      ],
    },
  ];

  final List<Map<String, dynamic>> achievements = [
    {
      'title': 'API Performance Optimization',
      'description': 'Reduced API latency by 25% via Golang optimization and MongoDB indexing',
      'icon': Icons.speed,
      'color': Colors.green,
    },
    {
      'title': 'Team Leadership',
      'description': 'Led ML rainfall prediction project, mentoring peers on Python and model development',
      'icon': Icons.groups,
      'color': Colors.orange,
    },
    {
      'title': 'Full Stack Development',
      'description': 'Successfully delivered multiple end-to-end web applications using modern tech stack',
      'icon': Icons.developer_mode,
      'color': Colors.purple,
    },
    {
      'title': 'IoT Innovation',
      'description': 'Developed scalable IoT monitoring system handling 300+ devices in real-time',
      'icon': Icons.sensors,
      'color': Colors.blue,
    },
  ];

  final List<Map<String, dynamic>> certifications = [
    {
      'name': 'Advanced Golang Development',
      'issuer': 'Online Platform',
      'date': '2024',
      'icon': Icons.verified,
    },
    {
      'name': 'Flutter & Dart - The Complete Guide',
      'issuer': 'Online Course',
      'date': '2024',
      'icon': Icons.verified,
    },
    {
      'name': 'AWS Cloud Practitioner',
      'issuer': 'Amazon Web Services',
      'date': '2024',
      'icon': Icons.cloud_done,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.xl),
            child: Column(
              children: [
                SectionTitle(title: 'Education & Achievements'),
                SizedBox(height: AppSpacing.xxl),
                
                // Education Section
                _buildEducationSection(),
                SizedBox(height: AppSpacing.xxl),
                
                // Achievements Section
                Text(
                  'Key Achievements',
                  style: AppTextStyles.heading2,
                ),
                SizedBox(height: AppSpacing.xl),
                _buildAchievementsGrid(),
                SizedBox(height: AppSpacing.xxl),
                
                // Certifications Section
                Text(
                  'Certifications',
                  style: AppTextStyles.heading2,
                ),
                SizedBox(height: AppSpacing.xl),
                _buildCertificationsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEducationSection() {
    final edu = education[0];
    return Container(
      constraints: BoxConstraints(maxWidth: 800),
      child: TimelineTile(
        alignment: TimelineAlign.center,
        isFirst: true,
        isLast: true,
        indicatorStyle: IndicatorStyle(
          width: 60,
          height: 60,
          indicator: Container(
            decoration: BoxDecoration(
              color: edu['color'],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: edu['color'].withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(
              edu['icon'],
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        startChild: Container(
          padding: EdgeInsets.only(right: AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                edu['duration'],
                style: AppTextStyles.heading3.copyWith(
                  color: edu['color'],
                ),
              ),
              SizedBox(height: AppSpacing.sm),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: edu['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.grade,
                      color: edu['color'],
                      size: 20,
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Text(
                      'CGPA: ${edu['cgpa']}',
                      style: TextStyle(
                        color: edu['color'],
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        endChild: Container(
          padding: EdgeInsets.only(left: AppSpacing.xl),
          child: Container(
            padding: EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: edu['color'].withOpacity(0.1),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  edu['degree'],
                  style: AppTextStyles.heading3,
                ),
                SizedBox(height: AppSpacing.sm),
                Text(
                  edu['institution'],
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: edu['color'],
                  ),
                ),
                SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppColors.textLight,
                    ),
                    SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        edu['location'],
                        style: AppTextStyles.body.copyWith(
                          fontSize: 14,
                          color: AppColors.textLight,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.lg),
                Text(
                  'Key Courses:',
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: edu['courses'].map<Widget>((course) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: edu['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        course,
                        style: TextStyle(
                          color: edu['color'],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width < 800 ? 1 : 2,
        crossAxisSpacing: AppSpacing.lg,
        mainAxisSpacing: AppSpacing.lg,
        childAspectRatio: MediaQuery.of(context).size.width < 800 ? 2 : 1.5,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final achievement = achievements[index];
        return Container(
          padding: EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: achievement['color'].withOpacity(0.2),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: achievement['color'].withOpacity(0.1),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: achievement['color'].withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  achievement['icon'],
                  color: achievement['color'],
                  size: 30,
                ),
              ),
              SizedBox(height: AppSpacing.md),
              Text(
                achievement['title'],
                style: AppTextStyles.heading3.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                achievement['description'],
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCertificationsSection() {
    return Container(
      constraints: BoxConstraints(maxWidth: 800),
      child: Column(
        children: certifications.map((cert) {
          return Container(
            margin: EdgeInsets.only(bottom: AppSpacing.lg),
            padding: EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    cert['icon'],
                    color: AppColors.primary,
                    size: 25,
                  ),
                ),
                SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cert['name'],
                        style: AppTextStyles.heading3.copyWith(fontSize: 18),
                      ),
                      SizedBox(height: AppSpacing.xs),
                      Text(
                        cert['issuer'],
                        style: AppTextStyles.body,
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
                    color: AppColors.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    cert['date'],
                    style: TextStyle(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}