import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:math' as math;
import '../../utils/constants.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late AnimationController _particleController;
  late AnimationController _shimmerController;
  
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _particleAnimation;
  late Animation<double> _shimmerAnimation;
  late Animation<double> _blurAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
  }

  void _initializeAnimations() {
    // Main animation controller
    _mainController = AnimationController(
      duration: Duration(milliseconds: 2500),
      vsync: this,
    );

    // Rotation controller for logo
    _rotationController = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
    );

    // Pulse controller
    _pulseController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    // Particle animation controller
    _particleController = AnimationController(
      duration: Duration(milliseconds: 4000),
      vsync: this,
    )..repeat();

    // Shimmer effect controller
    _shimmerController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    // Fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: Interval(0.0, 0.5, curve: Curves.easeInOut),
    ));

    // Scale animation with bounce
    _scaleAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: Interval(0.0, 0.6, curve: Curves.elasticOut),
    ));

    // Slide animation
    _slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: Interval(0.3, 0.8, curve: Curves.easeOutCubic),
    ));

    // Rotation animation
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeInOutCubic,
    ));

    // Pulse animation
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Particle animation
    _particleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_particleController);

    // Shimmer animation
    _shimmerAnimation = Tween<double>(
      begin: -2.0,
      end: 2.0,
    ).animate(_shimmerController);

    // Blur animation
    _blurAnimation = Tween<double>(
      begin: 10.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: Interval(0.0, 0.7, curve: Curves.easeOut),
    ));
  }

  void _startAnimationSequence() {
    _mainController.forward();
    _rotationController.forward();

    Future.delayed(Duration(milliseconds: 3500), () {
      _navigateToHome();
    });
  }

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void dispose() {
    _mainController.dispose();
    _rotationController.dispose();
    _pulseController.dispose();
    _particleController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.secondary,
              AppColors.secondary.withBlue(40),
              AppColors.primary.withOpacity(0.3),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated background particles
            _buildAnimatedParticles(),
            
            // Main content
            Center(
              child: AnimatedBuilder(
                animation: _mainController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Animated logo with multiple effects
                            _buildAnimatedLogo(),
                            
                            SizedBox(height: AppSpacing.xl * 2),
                            
                            // Animated text with shimmer effect
                            _buildAnimatedText(),
                            
                            SizedBox(height: AppSpacing.lg),
                            
                            // Subtitle with fade effect
                            _buildSubtitle(),
                            
                            SizedBox(height: AppSpacing.xl * 2),
                            
                            // Loading indicator
                            _buildLoadingIndicator(),
                          ],
                        ),
                      ),
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

  Widget _buildAnimatedParticles() {
    return AnimatedBuilder(
      animation: _particleAnimation,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlePainter(
            progress: _particleAnimation.value,
            particleColor: AppColors.primary.withOpacity(0.3),
          ),
          child: Container(),
        );
      },
    );
  }

  Widget _buildAnimatedLogo() {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _rotationAnimation,
        _pulseAnimation,
        _blurAnimation,
      ]),
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer glow rings
                for (int i = 0; i < 3; i++)
                  Container(
                    width: 160 + (i * 20.0),
                    height: 160 + (i * 20.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.2 - (i * 0.05)),
                        width: 2,
                      ),
                    ),
                  ),
                
                // Main logo container
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.accent,
                        AppColors.primary.withBlue(200),
                        AppColors.primary,
                      ],
                      stops: [0.0, 0.33, 0.66, 1.0],
                      transform: GradientRotation(_rotationAnimation.value),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.6),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                      BoxShadow(
                        color: AppColors.accent.withOpacity(0.4),
                        blurRadius: 60,
                        spreadRadius: 15,
                      ),
                    ],
                  ),
                  child: Container(
                    margin: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.secondary,
                    ),
                    child: Center(
                      child: ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            colors: [
                              AppColors.white,
                              AppColors.accent.withOpacity(0.8),
                            ],
                          ).createShader(bounds);
                        },
                        child: Text(
                          'AA',
                          style: TextStyle(
                            fontSize: 56,
                            fontWeight: FontWeight.w900,
                            color: AppColors.white,
                            letterSpacing: -2,
                            shadows: [
                              Shadow(
                                color: AppColors.primary.withOpacity(0.5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Inner pulse effect
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Container(
                      width: 140 * _pulseAnimation.value,
                      height: 140 * _pulseAnimation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.accent.withOpacity(
                            1.0 - (_pulseAnimation.value - 1.0) / 0.15,
                          ),
                          width: 2,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedText() {
    return Stack(
      children: [
        // Shimmer effect overlay
        AnimatedBuilder(
          animation: _shimmerAnimation,
          builder: (context, child) {
            return ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.white.withOpacity(0.0),
                    AppColors.white.withOpacity(0.8),
                    AppColors.white.withOpacity(0.0),
                  ],
                  stops: [
                    (_shimmerAnimation.value - 0.3).clamp(0.0, 1.0),
                    _shimmerAnimation.value.clamp(0.0, 1.0),
                    (_shimmerAnimation.value + 0.3).clamp(0.0, 1.0),
                  ],
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcATop,
              child: child,
            );
          },
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w800,
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: [
                    AppColors.white,
                    AppColors.accent.withOpacity(0.9),
                    AppColors.white,
                  ],
                ).createShader(Rect.fromLTWH(0, 0, 300, 70)),
              letterSpacing: 1.5,
              shadows: [
                Shadow(
                  color: AppColors.primary.withOpacity(0.5),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Akash Anumolu',
                  speed: Duration(milliseconds: 120),
                  cursor: '|',
                ),
              ],
              isRepeatingAnimation: false,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.accent.withOpacity(0.1),
          ],
        ),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        'FULL STACK DEVELOPER',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.white.withOpacity(0.9),
          letterSpacing: 3,
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return AnimatedBuilder(
      animation: _mainController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: SizedBox(
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                backgroundColor: AppColors.primary.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                minHeight: 3,
              ),
            ),
          ),
        );
      },
    );
  }
}

// Custom painter for animated particles
class ParticlePainter extends CustomPainter {
  final double progress;
  final Color particleColor;

  ParticlePainter({
    required this.progress,
    required this.particleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = particleColor
      ..style = PaintingStyle.fill;

    final random = math.Random(42);
    
    for (int i = 0; i < 50; i++) {
      final x = random.nextDouble() * size.width;
      final baseY = random.nextDouble() * size.height;
      final speed = 0.5 + random.nextDouble() * 0.5;
      final y = (baseY + (progress * size.height * speed)) % size.height;
      final radius = 1.0 + random.nextDouble() * 2.0;
      
      final opacity = (1.0 - (y / size.height)).clamp(0.0, 1.0);
      paint.color = particleColor.withOpacity(opacity * 0.6);
      
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}