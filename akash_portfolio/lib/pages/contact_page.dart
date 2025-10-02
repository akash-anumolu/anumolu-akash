import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/section_title.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedProjectType = 'Web Development';
  bool _isLoading = false;

  final List<String> projectTypes = [
    'Web Development',
    'Mobile Development',
    'IoT Solutions',
    'Consultation',
    'Other',
  ];

  final List<Map<String, dynamic>> contactInfo = [
    {
      'icon': Icons.email,
      'title': 'Email',
      'value': 'anumoluakash@gmail.com',
      'color': Colors.blue,
    },
    {
      'icon': Icons.phone,
      'title': 'Phone',
      'value': '+91-9100226642',
      'color': Colors.green,
    },
    {
      'icon': Icons.location_on,
      'title': 'Location',
      'value': 'Guntur, Andhra Pradesh',
      'color': Colors.orange,
    },
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Message sent successfully!'),
          backgroundColor: AppColors.success,
        ),
      );

      // Clear form
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
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
            SectionTitle(title: 'Get In Touch'),
            SizedBox(height: AppSpacing.lg),
            Text(
              'Let\'s discuss your project and how I can help',
              style: AppTextStyles.body.copyWith(
                fontSize: 18,
                color: AppColors.textLight,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.xxl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Contact Form
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(AppSpacing.xl),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Send Me a Message',
                            style: AppTextStyles.heading3,
                          ),
                          SizedBox(height: AppSpacing.xl),
                          // Name Field
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Your Name',
                              prefixIcon: Icon(Icons.person, color: AppColors.primary),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: AppColors.primary, width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: AppSpacing.lg),
                          // Email Field
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              prefixIcon: Icon(Icons.email, color: AppColors.primary),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: AppColors.primary, width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: AppSpacing.lg),
                          // Project Type Dropdown
                          DropdownButtonFormField<String>(
                            value: _selectedProjectType,
                            decoration: InputDecoration(
                              labelText: 'Project Type',
                              prefixIcon: Icon(Icons.category, color: AppColors.primary),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: AppColors.primary, width: 2),
                              ),
                            ),
                            items: projectTypes.map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedProjectType = value!;
                              });
                            },
                          ),
                          SizedBox(height: AppSpacing.lg),
                          // Message Field
                          TextFormField(
                            controller: _messageController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              labelText: 'Your Message',
                              prefixIcon: Icon(Icons.message, color: AppColors.primary),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: AppColors.primary, width: 2),
                              ),
                              alignLabelWithHint: true,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your message';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: AppSpacing.xl),
                          // Submit Button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: _isLoading
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.send, color: AppColors.white),
                                        SizedBox(width: AppSpacing.sm),
                                        Text(
                                          'Send Message',
                                          style: AppTextStyles.button,
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
                SizedBox(width: AppSpacing.xl),
                // Contact Information
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      // Contact Cards
                      ...contactInfo.map((info) {
                        return Container(
                          margin: EdgeInsets.only(bottom: AppSpacing.lg),
                          padding: EdgeInsets.all(AppSpacing.lg),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: info['color'].withOpacity(0.1),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: info['color'].withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  info['icon'],
                                  color: info['color'],
                                  size: 25,
                                ),
                              ),
                              SizedBox(height: AppSpacing.md),
                              Text(
                                info['title'],
                                style: AppTextStyles.heading3.copyWith(fontSize: 18),
                              ),
                              SizedBox(height: AppSpacing.sm),
                              Text(
                                info['value'],
                                style: AppTextStyles.body,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      // Social Links
                      Container(
                        padding: EdgeInsets.all(AppSpacing.lg),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.1),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Connect on Social',
                              style: AppTextStyles.heading3.copyWith(fontSize: 18),
                            ),
                            SizedBox(height: AppSpacing.lg),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildSocialButton(
                                  icon: Icons.code,
                                  url: 'https://github.com/akash-anumolu',
                                  color: Colors.black,
                                ),
                                _buildSocialButton(
                                  icon: Icons.work,
                                  url: 'https://www.linkedin.com/in/akash-anumolu-a54b42227/',
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.xxl),
            // Footer
            Container(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.textLight.withOpacity(0.2),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    '© 2025 Akash Anumolu. All rights reserved.',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textLight,
                    ),
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/home'),
                        child: Text('Home'),
                      ),
                      Text(' • ', style: TextStyle(color: AppColors.textLight)),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/about'),
                        child: Text('About'),
                      ),
                      Text(' • ', style: TextStyle(color: AppColors.textLight)),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/projects'),
                        child: Text('Projects'),
                      ),
                      Text(' • ', style: TextStyle(color: AppColors.textLight)),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/blog'),
                        child: Text('Blog'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String url,
    required Color color,
  }) {
    return IconButton(
      onPressed: () async {
        if (await canLaunch(url)) {
          await launch(url);
        }
      },
      icon: Icon(icon, color: color, size: 30),
      splashRadius: 25,
    );
  }
}