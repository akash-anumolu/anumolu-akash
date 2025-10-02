import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/section_title.dart';

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  String selectedCategory = 'All';
  
  final List<String> categories = ['All', 'Development', 'IoT', 'Flutter', 'Career'];
  
  final List<Map<String, dynamic>> blogPosts = [
    {
      'title': 'Building Scalable IoT Systems with Golang',
      'category': 'IoT',
      'date': 'March 15, 2025',
      'readTime': '8 min read',
      'excerpt': 'Learn how to design and implement scalable IoT systems using Golang, with real-world examples from production deployments.',
      'image': Icons.memory,
      'tags': ['Golang', 'IoT', 'Architecture'],
      'color': Colors.green,
    },
    {
      'title': 'Flutter vs React: A Developer\'s Perspective',
      'category': 'Development',
      'date': 'March 10, 2025',
      'readTime': '6 min read',
      'excerpt': 'An in-depth comparison of Flutter and React from a developer who has worked extensively with both frameworks.',
      'image': Icons.compare_arrows,
      'tags': ['Flutter', 'React', 'Mobile Development'],
      'color': Colors.blue,
    },
    {
      'title': 'Optimizing API Performance: My Journey',
      'category': 'Development',
      'date': 'March 5, 2025',
      'readTime': '10 min read',
      'excerpt': 'How I achieved a 25% reduction in API latency through various optimization techniques in Golang.',
      'image': Icons.speed,
      'tags': ['API', 'Performance', 'Golang'],
      'color': Colors.orange,
    },
    {
      'title': 'Getting Started with Grafana Dashboards',
      'category': 'IoT',
      'date': 'February 28, 2025',
      'readTime': '7 min read',
      'excerpt': 'A comprehensive guide to creating beautiful and informative dashboards with Grafana for IoT monitoring.',
      'image': Icons.dashboard,
      'tags': ['Grafana', 'Monitoring', 'Visualization'],
      'color': Colors.purple,
    },
    {
      'title': 'My Journey from Student to Full Stack Developer',
      'category': 'Career',
      'date': 'February 20, 2025',
      'readTime': '5 min read',
      'excerpt': 'Sharing my experience transitioning from a computer science student to a professional full stack developer.',
      'image': Icons.school,
      'tags': ['Career', 'Growth', 'Learning'],
      'color': Colors.red,
    },
  ];

  List<Map<String, dynamic>> get filteredPosts {
    if (selectedCategory == 'All') {
      return blogPosts;
    }
    return blogPosts.where((post) => post['category'] == selectedCategory).toList();
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
            SectionTitle(title: 'Blog & Insights'),
            SizedBox(height: AppSpacing.lg),
            Text(
              'Sharing knowledge and experiences from my development journey',
              style: AppTextStyles.body.copyWith(
                fontSize: 18,
                color: AppColors.textLight,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.xl),
            // Category Filter
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category == selectedCategory;
                  
                  return Padding(
                    padding: EdgeInsets.only(right: AppSpacing.md),
                    child: FilterChip(
                      label: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? AppColors.white : AppColors.text,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedCategory = category;
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
            // Blog Posts Grid
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: size.width < 800 ? 1 : 2,
                crossAxisSpacing: AppSpacing.xl,
                mainAxisSpacing: AppSpacing.xl,
                childAspectRatio: size.width < 800 ? 1.5 : 1.3,
              ),
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                return _buildBlogCard(filteredPosts[index]);
              },
            ),
            if (filteredPosts.isEmpty)
              Container(
                height: 200,
                child: Center(
                  child: Text(
                    'No posts found in this category',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textLight,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlogCard(Map<String, dynamic> post) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: post['color'].withOpacity(0.1),
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
            _showBlogPost(post);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Blog Header with Image
              Container(
                height: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      post['color'].withOpacity(0.8),
                      post['color'].withOpacity(0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Icon(
                    post['image'],
                    size: 60,
                    color: AppColors.white,
                  ),
                ),
              ),
              // Blog Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: post['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          post['category'],
                          style: TextStyle(
                            color: post['color'],
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSpacing.sm),
                      Text(
                        post['title'],
                        style: AppTextStyles.heading3.copyWith(fontSize: 18),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          post['excerpt'],
                          style: AppTextStyles.body,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: AppSpacing.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 14,
                                color: AppColors.textLight,
                              ),
                              SizedBox(width: AppSpacing.xs),
                              Text(
                                post['date'],
                                style: TextStyle(
                                  color: AppColors.textLight,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.timer,
                                size: 14,
                                color: AppColors.textLight,
                              ),
                              SizedBox(width: AppSpacing.xs),
                              Text(
                                post['readTime'],
                                style: TextStyle(
                                  color: AppColors.textLight,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBlogPost(Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: AppSpacing.sm),
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.textLight.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(AppSpacing.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              post['color'].withOpacity(0.8),
                              post['color'].withOpacity(0.6),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Icon(
                            post['image'],
                            size: 80,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSpacing.xl),
                      Text(
                        post['title'],
                        style: AppTextStyles.heading2,
                      ),
                      SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: post['color'].withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              post['category'],
                              style: TextStyle(
                                color: post['color'],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: AppSpacing.md),
                          Icon(Icons.calendar_today, size: 16, color: AppColors.textLight),
                          SizedBox(width: AppSpacing.xs),
                          Text(post['date'], style: AppTextStyles.body),
                          SizedBox(width: AppSpacing.md),
                          Icon(Icons.timer, size: 16, color: AppColors.textLight),
                          SizedBox(width: AppSpacing.xs),
                          Text(post['readTime'], style: AppTextStyles.body),
                        ],
                      ),
                      SizedBox(height: AppSpacing.xl),
                      Text(
                        post['excerpt'],
                        style: AppTextStyles.body.copyWith(
                          fontSize: 18,
                          height: 1.8,
                        ),
                      ),
                      SizedBox(height: AppSpacing.xl),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\n'
                        'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
                        'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                        style: AppTextStyles.body.copyWith(
                          fontSize: 16,
                          height: 1.8,
                        ),
                      ),
                      SizedBox(height: AppSpacing.xl),
                      Wrap(
                        spacing: AppSpacing.sm,
                        children: post['tags'].map<Widget>((tag) {
                          return Chip(
                            label: Text(tag),
                            backgroundColor: post['color'].withOpacity(0.1),
                            labelStyle: TextStyle(
                              color: post['color'],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}