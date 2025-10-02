import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../utils/constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/section_title.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SectionTitle(title: 'About Me'),
                SizedBox(height: AppSpacing.xl),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Image Section
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Container(
                          width: 300,
                          height: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [AppColors.primary, AppColors.accent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: [
                                // Placeholder for actual image
                                Container(
                                  color: AppColors.primary.withOpacity(0.1),
                                  child: Center(
                                    child: Icon(
                                      Icons.person,
                                      size: 100,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(AppSpacing.md),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.7),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Akash Anumolu',
                                          style: AppTextStyles.heading3.copyWith(
                                            color: AppColors.white,
                                          ),
                                        ),
                                        Text(
                                          'Full Stack Developer',
                                          style: AppTextStyles.body.copyWith(
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: AppSpacing.xl),
                    // Bio Content
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello! I\'m Akash Anumolu',
                            style: AppTextStyles.heading2,
                          ),
                          SizedBox(height: AppSpacing.lg),
                          Text(
                            'A passionate Full Stack Developer with expertise in building scalable web applications and IoT solutions. '
                            'Currently working at greenkwh.net, where I develop innovative solutions using Golang, Flutter, and cloud technologies.',
                            style: AppTextStyles.body.copyWith(
                              fontSize: 18,
                              height: 1.8,
                            ),
                          ),
                          SizedBox(height: AppSpacing.lg),
                          Text(
                            'With a strong foundation in computer science from VIT Amaravati and hands-on experience in real-world projects, '
                            'I specialize in creating efficient, user-friendly applications that solve complex business problems.',
                            style: AppTextStyles.body.copyWith(
                              fontSize: 18,
                              height: 1.8,
                            ),
                          ),
                          SizedBox(height: AppSpacing.xl),
                          // Stats Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildStatCard(
                                icon: Icons.code,
                                value: '50+',
                                label: 'Projects\nCompleted',
                              ),
                              _buildStatCard(
                                icon: Icons.calendar_today,
                                value: '2+',
                                label: 'Years\nExperience',
                              ),
                              _buildStatCard(
                                icon: Icons.devices,
                                value: '10+',
                                label: 'Technologies\nMastered',
                              ),
                              _buildStatCard(
                                icon: Icons.terminal,
                                value: '100K+',
                                label: 'Lines of\nCode',
                              ),
                            ],
                          ),
                          SizedBox(height: AppSpacing.xl),
                          // Quick Info
                          _buildInfoRow('Location', 'Guntur, Andhra Pradesh'),
                          _buildInfoRow('Email', 'anumoluakash@gmail.com'),
                          _buildInfoRow('Phone', '+91-9100226642'),
                          _buildInfoRow('Degree', 'B.Tech Computer Science'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
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
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 30),
          SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.body.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}