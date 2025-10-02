import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../utils/constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/section_title.dart';

class ServicesPage extends StatefulWidget {
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final List<Map<String, dynamic>> services = [
    {
      'title': 'Full Stack Development',
      'icon': Icons.code,
      'color': Colors.blue,
      'description': 'End-to-end web application development with modern technologies',
      'features': [
        'Custom web applications',
        'API development & integration',
        'Database design & optimization',
        'Microservices architecture',
        'Performance optimization',
      ],
      'technologies': ['Golang', 'React', 'Node.js', 'MongoDB', 'PostgreSQL'],
    },
    {
      'title': 'Mobile Development',
      'icon': Icons.phone_android,
      'color': Colors.green,
      'description': 'Cross-platform mobile apps with native performance',
      'features': [
        'Cross-platform Flutter apps',
        'Native performance optimization',
        'UI/UX implementation',
        'App Store deployment',
        'Push notifications & analytics',
      ],
      'technologies': ['Flutter', 'Dart', 'Firebase', 'REST APIs'],
    },
    {
      'title': 'IoT Solutions',
      'icon': Icons.memory,
      'color': Colors.orange,
      'description': 'Scalable IoT systems with real-time monitoring',
      'features': [
        'Real-time monitoring systems',
        'Data visualization dashboards',
        'Scalable architectures',
        'Device management',
        'Predictive analytics',
      ],
      'technologies': ['Golang', 'Prometheus', 'Grafana', 'MQTT', 'Docker'],
    },
    {
      'title': 'Cloud & DevOps',
      'icon': Icons.cloud,
      'color': Colors.purple,
      'description': 'Cloud deployment and DevOps automation',
      'features': [
        'AWS deployment',
        'Docker containerization',
        'CI/CD pipelines',
        'Infrastructure as Code',
        'Monitoring & logging',
      ],
      'technologies': ['AWS', 'Docker', 'Kubernetes', 'Jenkins', 'Git'],
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
            SectionTitle(title: 'Services & Expertise'),
            SizedBox(height: AppSpacing.lg),
            Text(
              'Delivering high-quality solutions tailored to your needs',
              style: AppTextStyles.body.copyWith(
                fontSize: 18,
                color: AppColors.textLight,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.xxl),
            AnimationLimiter(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size.width < 800 ? 1 : 2,
                  crossAxisSpacing: AppSpacing.xl,
                  mainAxisSpacing: AppSpacing.xl,
                  childAspectRatio: size.width < 800 ? 1.2 : 1,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: Duration(milliseconds: 600),
                    columnCount: 2,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: _buildServiceCard(services[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: AppSpacing.xxl),
            _buildCTASection(),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: service['color'].withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            _showServiceDialog(service);
          },
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: service['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        service['icon'],
                        color: service['color'],
                        size: 30,
                      ),
                    ),
                    SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Text(
                        service['title'],
                        style: AppTextStyles.heading3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.lg),
                Text(
                  service['description'],
                  style: AppTextStyles.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppSpacing.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Key Features:',
                        style: AppTextStyles.body.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: AppSpacing.sm),
                      ...service['features'].take(3).map<Widget>((feature) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: AppSpacing.xs),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check,
                                size: 16,
                                color: service['color'],
                              ),
                              SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Text(
                                  feature,
                                  style: AppTextStyles.body.copyWith(
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      if (service['features'].length > 3)
                        Padding(
                          padding: EdgeInsets.only(top: AppSpacing.xs),
                          child: Text(
                            '+${service['features'].length - 3} more',
                            style: TextStyle(
                              color: service['color'],
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: AppSpacing.lg),
                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      _showServiceDialog(service);
                    },
                    icon: Icon(Icons.arrow_forward),
                    label: Text('Learn More'),
                    style: TextButton.styleFrom(
                      foregroundColor: service['color'],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCTASection() {
    return Container(
      padding: EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.accent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'Ready to Start Your Project?',
            style: AppTextStyles.heading2.copyWith(
              color: AppColors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.lg),
          Text(
            'Let\'s discuss how I can help bring your ideas to life',
            style: AppTextStyles.body.copyWith(
              color: AppColors.white,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.xl),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/contact');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.primary,
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Get In Touch', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(width: AppSpacing.sm),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showServiceDialog(Map<String, dynamic> service) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(AppSpacing.xl),
            constraints: BoxConstraints(maxWidth: 600),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: service['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        service['icon'],
                        color: service['color'],
                        size: 25,
                      ),
                    ),
                    SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Text(
                        service['title'],
                        style: AppTextStyles.heading3,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.lg),
                Text(
                  service['description'],
                  style: AppTextStyles.body.copyWith(fontSize: 16),
                ),
                SizedBox(height: AppSpacing.lg),
                Text(
                  'Features:',
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                ...service['features'].map<Widget>((feature) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: AppSpacing.sm),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 18,
                          color: service['color'],
                        ),
                        SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            feature,
                            style: AppTextStyles.body,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                SizedBox(height: AppSpacing.lg),
                Text(
                  'Technologies:',
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: service['technologies'].map<Widget>((tech) {
                    return Chip(
                      label: Text(
                        tech,
                        style: TextStyle(color: service['color']),
                      ),
                      backgroundColor: service['color'].withOpacity(0.1),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}