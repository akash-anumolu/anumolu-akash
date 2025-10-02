import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/social_links.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(),
      body: Stack(
        children: [
          // Particle Background
          // Particle Background (removed due to missing package)
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1,
                vertical: AppSpacing.xxl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.1),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, I\'m',
                            style: AppTextStyles.heading3.copyWith(
                              color: AppColors.textLight,
                            ),
                          ),
                          SizedBox(height: AppSpacing.md),
                          Text(
                            'Akash Anumolu',
                            style: AppTextStyles.heading1.copyWith(
                              fontSize: size.width < 600 ? 36 : 48,
                              color: AppColors.secondary,
                            ),
                          ),
                          SizedBox(height: AppSpacing.lg),
                          AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                'Full Stack Developer',
                                textStyle: AppTextStyles.heading3.copyWith(
                                  color: AppColors.primary,
                                ),
                                speed: Duration(milliseconds: 100),
                              ),
                              TypewriterAnimatedText(
                                'IoT Specialist',
                                textStyle: AppTextStyles.heading3.copyWith(
                                  color: AppColors.primary,
                                ),
                                speed: Duration(milliseconds: 100),
                              ),
                              TypewriterAnimatedText(
                                'Flutter Expert',
                                textStyle: AppTextStyles.heading3.copyWith(
                                  color: AppColors.primary,
                                ),
                                speed: Duration(milliseconds: 100),
                              ),
                            ],
                            repeatForever: true,
                            pause: Duration(milliseconds: 1000),
                          ),
                          SizedBox(height: AppSpacing.xl),
                          Container(
                            width: size.width < 600 ? size.width * 0.8 : 500,
                            child: Text(
                              'Passionate about building scalable applications and innovative IoT solutions. '
                              'Currently working at greenkwh.net, specializing in Golang, Flutter, and cloud technologies.',
                              style: AppTextStyles.body.copyWith(
                                fontSize: 18,
                                height: 1.8,
                              ),
                            ),
                          ),
                          SizedBox(height: AppSpacing.xl),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/projects');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppSpacing.xl,
                                    vertical: AppSpacing.lg,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 5,
                                ),
                                child: Row(
                                  children: [
                                    Text('View Projects', style: AppTextStyles.button),
                                    SizedBox(width: AppSpacing.sm),
                                    Icon(Icons.arrow_forward, color: AppColors.white),
                                  ],
                                ),
                              ),
                              SizedBox(width: AppSpacing.lg),
                              OutlinedButton(
                                onPressed: () {
                                  // Download resume functionality
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppSpacing.xl,
                                    vertical: AppSpacing.lg,
                                  ),
                                  side: BorderSide(
                                    color: AppColors.primary,
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.download, color: AppColors.primary),
                                    SizedBox(width: AppSpacing.sm),
                                    Text(
                                      'Download Resume',
                                      style: AppTextStyles.button.copyWith(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppSpacing.xl),
                          SocialLinks(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}