import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/custom_app_bar.dart';

class ProjectDetailPage extends StatefulWidget {
  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final project = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    project['color'].withOpacity(0.8),
                    project['color'].withOpacity(0.4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  // Background Pattern
                  Positioned.fill(
                    child: CustomPaint(
                      painter: BackgroundPattern(color: AppColors.white.withOpacity(0.1)),
                    ),
                  ),
                  // Content
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            project['image'],
                            size: 50,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(height: AppSpacing.lg),
                        Text(
                          project['title'],
                          style: AppTextStyles.heading1.copyWith(
                            color: AppColors.white,
                            fontSize: size.width < 600 ? 32 : 48,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: AppSpacing.md),
                        Text(
                          project['description'],
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.white,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Main Content
            Container(
              padding: EdgeInsets.all(AppSpacing.xl),
              constraints: BoxConstraints(maxWidth: 1000),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Project Overview
                  _buildSection(
                    'Project Overview',
                    project['details'],
                  ),
                  SizedBox(height: AppSpacing.xl),
                  
                  // Technology Stack
                  _buildSection(
                    'Technology Stack',
                    null,
                    child: Wrap(
                      spacing: AppSpacing.md,
                      runSpacing: AppSpacing.md,
                      children: project['technologies'].map<Widget>((tech) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                            vertical: AppSpacing.md,
                          ),
                          decoration: BoxDecoration(
                            color: project['color'].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: project['color'].withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.code,
                                color: project['color'],
                                size: 20,
                              ),
                              SizedBox(width: AppSpacing.sm),
                              Text(
                                tech,
                                style: TextStyle(
                                  color: project['color'],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: AppSpacing.xl),
                  
                  // Key Features
                  _buildSection(
                    'Key Features',
                    null,
                    child: Column(
                      children: [
                        _buildFeatureItem(
                          Icons.speed,
                          'High Performance',
                          'Optimized for speed and scalability',
                          project['color'],
                        ),
                        _buildFeatureItem(
                          Icons.security,
                          'Secure',
                          'Implemented best security practices',
                          project['color'],
                        ),
                        _buildFeatureItem(
                          Icons.devices,
                          'Responsive',
                          'Works perfectly on all devices',
                          project['color'],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSpacing.xl),
                  
                  // Call to Action
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (project.containsKey('liveUrl'))
                          ElevatedButton.icon(
                            onPressed: () {
                              // Launch URL
                            },
                            icon: Icon(Icons.launch),
                            label: Text('View Live Demo'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: project['color'],
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSpacing.xl,
                                vertical: AppSpacing.lg,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        if (project.containsKey('liveUrl'))
                          SizedBox(width: AppSpacing.lg),
                        OutlinedButton.icon(
                          onPressed: () {
                            // View source code
                          },
                          icon: Icon(Icons.code),
                          label: Text('View Source Code'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: project['color'],
                            side: BorderSide(color: project['color'], width: 2),
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.xl,
                              vertical: AppSpacing.lg,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String? content, {Widget? child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.heading2,
        ),
        SizedBox(height: AppSpacing.lg),
        if (content != null)
          Text(
            content,
            style: AppTextStyles.body.copyWith(
              fontSize: 18,
              height: 1.8,
            ),
          ),
        if (child != null) child,
      ],
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.lg),
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
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
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color),
          ),
          SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.heading3.copyWith(fontSize: 18),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  description,
                  style: AppTextStyles.body,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundPattern extends CustomPainter {
  final Color color;
  BackgroundPattern({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final spacing = 30.0;
    
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i, size.height),
        paint,
      );
    }
    
    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(
        Offset(0, i),
        Offset(size.width, i),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}