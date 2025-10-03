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
    final isMobile = size.width < 600;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.background,
              AppColors.background.withOpacity(0.8),
              AppColors.primary.withOpacity(0.05),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(maxWidth: 1200),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? AppSpacing.xl : AppSpacing.xxl * 2,
                vertical: AppSpacing.xxl,
              ),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Greeting Badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '👋 Welcome to my portfolio',
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: AppSpacing.xl),

                      // Name
                      Text(
                        'Akash Anumolu',
                        style: AppTextStyles.heading1.copyWith(
                          fontSize: isMobile ? 40 : 64,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                          letterSpacing: -1.5,
                          height: 1.1,
                        ),
                      ),

                      SizedBox(height: AppSpacing.lg),

                      // Animated Role
                      Row(
                        children: [
                          Text(
                            'I\'m a ',
                            style: AppTextStyles.heading3.copyWith(
                              fontSize: isMobile ? 20 : 28,
                              color: AppColors.textLight,
                            ),
                          ),
                          AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                'Full Stack Developer',
                                textStyle: AppTextStyles.heading3.copyWith(
                                  fontSize: isMobile ? 20 : 28,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                                speed: Duration(milliseconds: 100),
                              ),
                              TypewriterAnimatedText(
                                'IoT Specialist',
                                textStyle: AppTextStyles.heading3.copyWith(
                                  fontSize: isMobile ? 20 : 28,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                                speed: Duration(milliseconds: 100),
                              ),
                              TypewriterAnimatedText(
                                'Flutter Expert',
                                textStyle: AppTextStyles.heading3.copyWith(
                                  fontSize: isMobile ? 20 : 28,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                                speed: Duration(milliseconds: 100),
                              ),
                            ],
                            repeatForever: true,
                            pause: Duration(milliseconds: 1000),
                          ),
                        ],
                      ),

                      SizedBox(height: AppSpacing.xl),

                      // Description
                      Container(
                        constraints: BoxConstraints(maxWidth: 600),
                        child: Text(
                          'Building scalable applications and innovative IoT solutions at greenkwh.net. Specialized in Golang, Flutter, and cloud technologies.',
                          style: AppTextStyles.body.copyWith(
                            fontSize: isMobile ? 16 : 18,
                            height: 1.7,
                            color: AppColors.textLight.withOpacity(0.9),
                          ),
                        ),
                      ),

                      SizedBox(height: AppSpacing.xxl),

                      // Action Buttons
                      Wrap(
                        spacing: AppSpacing.lg,
                        runSpacing: AppSpacing.md,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/projects');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSpacing.xl * 1.5,
                                vertical: AppSpacing.lg,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                              shadowColor: AppColors.primary.withOpacity(0.5),
                            ).copyWith(
                              overlayColor: MaterialStateProperty.all(
                                AppColors.secondary.withOpacity(0.1),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'View Projects',
                                  style: AppTextStyles.button.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: AppSpacing.sm),
                                Icon(Icons.arrow_forward, 
                                  color: AppColors.white, 
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              // Download resume functionality
                            },
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSpacing.xl * 1.5,
                                vertical: AppSpacing.lg,
                              ),
                              side: BorderSide(
                                color: AppColors.primary.withOpacity(0.5),
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ).copyWith(
                              overlayColor: MaterialStateProperty.all(
                                AppColors.primary.withOpacity(0.05),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.download_rounded, 
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                                SizedBox(width: AppSpacing.sm),
                                Text(
                                  'Resume',
                                  style: AppTextStyles.button.copyWith(
                                    color: AppColors.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: AppSpacing.xxl),

                      // Social Links
                      SocialLinks(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}