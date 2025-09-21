import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/property_details_screen/property_details_screen.dart';
import '../presentation/emi_calculator_screen/emi_calculator_screen.dart';
import '../presentation/web_stories_screen/web_stories_screen.dart';
import '../presentation/properties_screen/properties_screen.dart';
import '../presentation/blog_screen/blog_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String splash = '/splash-screen';
  static const String properties = '/properties-screen';
  static const String propertyDetails = '/property-details-screen';
  static const String emiCalculator = '/emi-calculator-screen';
  static const String webStories = '/web-stories-screen';
  static const String blog = '/blog-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    splash: (context) => const SplashScreen(),
    properties: (context) => const PropertiesScreen(),
    propertyDetails: (context) => const PropertyDetailsScreen(),
    emiCalculator: (context) => const EmiCalculatorScreen(),
    webStories: (context) => const WebStoriesScreen(),
    blog: (context) => const BlogScreen(),
  };
}
