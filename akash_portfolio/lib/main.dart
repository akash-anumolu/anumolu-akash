import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'pages/splash_page.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/skills_page.dart';
import 'pages/experience_page.dart';
import 'pages/projects_page.dart';
import 'pages/project_detail_page.dart';
import 'pages/services_page.dart';
import 'pages/education_page.dart';
import 'pages/blog_page.dart';
import 'pages/contact_page.dart';
import 'providers/theme_provider.dart';
import 'utils/constants.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Akash Anumolu - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
      ),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/home': (context) => HomePage(),
        '/about': (context) => AboutPage(),
        '/skills': (context) => SkillsPage(),
        '/experience': (context) => ExperiencePage(),
        '/projects': (context) => ProjectsPage(),
        '/project-detail': (context) => ProjectDetailPage(),
        '/services': (context) => ServicesPage(),
        '/education': (context) => EducationPage(),
        '/blog': (context) => BlogPage(),
        '/contact': (context) => ContactPage(),
      },
    );
  }
}