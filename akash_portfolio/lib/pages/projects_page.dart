import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/section_title.dart';

class ProjectsPage extends StatefulWidget {
  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  String selectedFilter = 'All';
  
  final List<String> filters = ['All', 'Web', 'Mobile', 'IoT', 'Machine Learning'];
  
  final List<Map<String, dynamic>> projects = [
    {
      'title': 'IoT Battery Monitoring System',
      'category': 'IoT',
      'description': 'Real-time battery monitoring system with Grafana dashboards',
      'image': Icons.battery_charging_full,
      'technologies': ['Golang', 'Prometheus', 'Grafana', 'MongoDB'],
      'color': Colors.green,
      'year': '2025',
      'details': 'Developed backend in Golang with Prometheus metrics & Grafana visualization for real-time IoT battery tracking, scalable to 300+ devices.',
    },
    {
      'title': 'Online Auction System',
      'category': 'Web',
      'description': 'Real-time bidding platform with secure authentication',
      'image': Icons.gavel,
      'technologies': ['React', 'Node.js', 'MongoDB', 'Socket.io'],
      'color': Colors.blue,
      'year': '2024',
      'details': 'Built MERN stack app supporting real-time bidding, authentication, and scalable auction services.',
    },
    {
      'title': 'GypLife Business Website',
      'category': 'Mobile',
      'description': 'Cross-platform responsive business website',
      'image': Icons.business_center,
      'technologies': ['Flutter', 'Dart', 'GoDaddy'],
      'color': Colors.purple,
      'year': '2024',
      'details': 'Developed responsive website (gyplife.com) using Flutter, enabling cross-platform accessibility.',
      'liveUrl': 'https://gyplife.com',
    },
    {
      'title': 'Task Manager Application',
      'category': 'Web',
      'description': 'Efficient task management with CRUD operations',
      'image': Icons.task_alt,
      'technologies': ['Golang', 'MongoDB', 'REST API'],
      'color': Colors.orange,
      'year': '2024',
      'details': 'Designed task management app with Golang backend + MongoDB, enabling CRUD APIs and efficient task tracking.',
    },
    {
      'title': 'Rainfall Prediction System',
      'category': 'Machine Learning',
      'description': 'ML-based weather prediction system',
      'image': Icons.cloud,
      'technologies': ['Python', 'Random Forest', 'LSTM', 'TensorFlow'],
      'color': Colors.cyan,
      'year': '2024',
      'details': 'Implemented ML models (Random Forest, LSTM) in Python for rainfall prediction, achieving high accuracy.',
    },
  ];

  List<Map<String, dynamic>> get filteredProjects {
    if (selectedFilter == 'All') {
      return projects;
    }
    return projects.where((project) => project['category'] == selectedFilter).toList();
  }

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
            SectionTitle(title: 'Featured Projects'),
            SizedBox(height: AppSpacing.xl),
            // Filter Chips
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  final isSelected = filter == selectedFilter;
                  
                  return Padding(
                    padding: EdgeInsets.only(right: AppSpacing.md),
                    child: FilterChip(
                      label: Text(
                        filter,
                        style: TextStyle(
                          color: isSelected ? AppColors.white : AppColors.text,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedFilter = filter;
                        });
                      },
                      backgroundColor: AppColors.white,
                      selectedColor: AppColors.primary,
                      checkmarkColor: AppColors.white,
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected ? AppColors.primary : AppColors.textLight.withOpacity(0.3),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: AppSpacing.xl),
            // Projects Grid
            StaggeredGrid.count(
              crossAxisCount: size.width < 600 ? 1 : (size.width < 900 ? 2 : 3),
              mainAxisSpacing: AppSpacing.lg,
              crossAxisSpacing: AppSpacing.lg,
              children: filteredProjects.map((project) {
                return _buildProjectCard(project, context);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: project['color'].withOpacity(0.1),
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
            Navigator.pushNamed(
              context,
              '/project-detail',
              arguments: project,
            );
          },
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: project['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        project['image'],
                        color: project['color'],
                        size: 30,
                      ),
                    ),
                    SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project['title'],
                            style: AppTextStyles.heading3.copyWith(fontSize: 18),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            project['year'],
                            style: AppTextStyles.body.copyWith(
                              color: project['color'],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.md),
                Text(
                  project['description'],
                  style: AppTextStyles.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppSpacing.lg),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: project['technologies'].take(3).map<Widget>((tech) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: project['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        tech,
                        style: TextStyle(
                          color: project['color'],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (project['technologies'].length > 3) ...[
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    '+${project['technologies'].length - 3} more',
                    style: TextStyle(
                      color: project['color'],
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
                SizedBox(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (project.containsKey('liveUrl'))
                      TextButton.icon(
                        onPressed: () {
                          // Launch URL
                        },
                        icon: Icon(Icons.launch, size: 16),
                        label: Text('Live Demo'),
                        style: TextButton.styleFrom(
                          foregroundColor: project['color'],
                        ),
                      )
                    else
                      SizedBox.shrink(),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/project-detail',
                          arguments: project,
                        );
                      },
                      icon: Icon(Icons.arrow_forward, size: 16),
                      label: Text('View Details'),
                      style: TextButton.styleFrom(
                        foregroundColor: project['color'],
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
}