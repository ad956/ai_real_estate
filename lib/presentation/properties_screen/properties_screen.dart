import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/empty_properties_state.dart';
import './widgets/error_properties_state.dart';
import './widgets/properties_shimmer_loader.dart';
import './widgets/property_card.dart';
import './widgets/property_category_chip.dart';

class PropertiesScreen extends StatefulWidget {
  const PropertiesScreen({Key? key}) : super(key: key);

  @override
  State<PropertiesScreen> createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends State<PropertiesScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final RefreshIndicator _refreshIndicatorKey = RefreshIndicator(
    onRefresh: () async {},
    child: Container(),
  );

  // State variables
  bool _isLoading = true;
  bool _hasError = false;
  String _selectedCategory = 'Property Offer in Vadodara For September 2025';
  List<Map<String, dynamic>> _properties = [];
  List<Map<String, dynamic>> _filteredProperties = [];
  List<String> _categories = [];
  int _currentBottomNavIndex = 1; // Properties tab active

  // Exact categories from reference image
  final List<String> _mockCategories = [
    'Property Offer in Vadodara For September 2025',
    'Recommended Properties',
    'Ready to Move',
    'Under Construction',
    'New Launch',
  ];

  // Updated mock properties with Vadodara location and specific status
  final List<Map<String, dynamic>> _mockProperties = [
    {
      "id": 1,
      "title": "Luxury 3BHK Apartment in Prime Location",
      "price": "₹85,00,000",
      "location": "Alkapuri, Vadodara",
      "status": "Ready to Move",
      "pinCode": "390007",
      "type": "Ready to Move",
      "image":
          "https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400&h=300&fit=crop",
      "bedrooms": 3,
      "bathrooms": 2,
      "area": "1850 sq ft",
      "description":
          "Spacious 3BHK apartment with modern amenities in prime Alkapuri location.",
    },
    {
      "id": 2,
      "title": "Modern Commercial Office Space",
      "price": "₹1,20,00,000",
      "location": "Productivity Road, Vadodara",
      "status": "New Launch",
      "pinCode": "390020",
      "type": "New Launch",
      "image":
          "https://images.unsplash.com/photo-1497366216548-37526070297c?w=400&h=300&fit=crop",
      "area": "2500 sq ft",
      "description":
          "Premium office space with modern infrastructure and excellent connectivity.",
    },
    {
      "id": 3,
      "title": "Independent Villa with Garden",
      "price": "₹2,50,00,000",
      "location": "Race Course Circle, Vadodara",
      "status": "Under Construction",
      "pinCode": "390007",
      "type": "Under Construction",
      "image":
          "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=400&h=300&fit=crop",
      "bedrooms": 4,
      "bathrooms": 3,
      "area": "3200 sq ft",
      "description":
          "Beautiful villa with private garden, expected completion by December 2025.",
    },
    {
      "id": 4,
      "title": "Affordable 2BHK Flat",
      "price": "₹45,00,000",
      "location": "Manjalpur, Vadodara",
      "status": "Ready to Move",
      "pinCode": "390011",
      "type": "Ready to Move",
      "image":
          "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=400&h=300&fit=crop",
      "bedrooms": 2,
      "bathrooms": 2,
      "area": "1200 sq ft",
      "description":
          "Well-designed apartment with all basic amenities and good connectivity.",
    },
    {
      "id": 5,
      "title": "Premium Property in Vadodara",
      "price": "₹75,00,000",
      "location": "Sayajigunj, Vadodara",
      "status": "Available",
      "pinCode": "390005",
      "type": "Property Offer in Vadodara For September 2025",
      "image":
          "https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400&h=300&fit=crop",
      "area": "1800 sq ft",
      "description":
          "Special September offer on prime property with excellent location benefits.",
    },
    {
      "id": 6,
      "title": "Recommended Luxury Apartment",
      "price": "₹95,00,000",
      "location": "Fatehgunj, Vadodara",
      "status": "Available",
      "pinCode": "390002",
      "type": "Recommended Properties",
      "image":
          "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=400&h=300&fit=crop",
      "bedrooms": 3,
      "bathrooms": 3,
      "area": "2200 sq ft",
      "description":
          "Highly recommended property with premium amenities and strategic location.",
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeData() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      // Simulate API call delay
      await Future.delayed(Duration(milliseconds: 1500));

      setState(() {
        _categories = _mockCategories;
        _properties = _mockProperties;
        _filteredProperties = _properties;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  void _onScroll() {
    // Implement infinite scroll logic here if needed
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Load more properties
    }
  }

  Future<void> _onRefresh() async {
    HapticFeedback.mediumImpact();
    _initializeData();
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == 'Property Offer in Vadodara For September 2025') {
        _filteredProperties = _properties; // Show all for main category
      } else {
        _filteredProperties = _properties
            .where(
              (property) =>
                  (property['type'] as String).toLowerCase() ==
                  category.toLowerCase(),
            )
            .toList();
      }
    });
    HapticFeedback.selectionClick();
  }

  void _onPropertyTap(Map<String, dynamic> property) {
    Navigator.pushNamed(
      context,
      '/property-details-screen',
      arguments: property,
    );
  }

  void _onEMICalculatorTap() {
    Navigator.pushNamed(context, '/emi-calculator-screen');
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentBottomNavIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/web-stories-screen');
        break;
      case 1:
        // Already on Properties screen
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/blog-screen');
        break;
    }
  }

  Widget _buildCategoryChips() {
    return Container(
      height: 6.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return PropertyCategoryChip(
            category: category,
            isSelected: _selectedCategory == category,
            onTap: () => _onCategorySelected(category),
          );
        },
      ),
    );
  }

  Widget _buildPropertiesList() {
    if (_filteredProperties.isEmpty) {
      return EmptyPropertiesState(
        onRetry: () => _onCategorySelected('All'),
        message: _selectedCategory == 'All'
            ? 'No properties available'
            : 'No ${_selectedCategory.toLowerCase()} properties found',
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.only(bottom: 10.h),
      itemCount: _filteredProperties.length,
      itemBuilder: (context, index) {
        final property = _filteredProperties[index];
        return PropertyCard(
          property: property,
          onTap: () => _onPropertyTap(property),
        );
      },
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return PropertiesShimmerLoader();
    }

    if (_hasError) {
      return ErrorPropertiesState(
        onRetry: _initializeData,
        errorMessage: 'Failed to load properties',
      );
    }

    return Column(
      children: [
        _buildCategoryChips(),
        SizedBox(height: 2.h),
        Expanded(child: _buildPropertiesList()),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppTheme.searchGradientDark,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryDark.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          CustomIconWidget(iconName: 'search', color: Colors.white, size: 20),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              'Search properties in Vadodara...',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: CustomIconWidget(
              iconName: 'tune',
              color: Colors.white,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppTheme.backgroundGradientDark,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            color: Colors.white,
            backgroundColor: AppTheme.primaryDark,
            child: Column(
              children: [
                // Custom App Bar
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  child: Row(
                    children: [
                      Text(
                        'Properties',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          HapticFeedback.lightImpact();
                        },
                        icon: CustomIconWidget(
                          iconName: 'notifications_outlined',
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),

                // Search Bar
                _buildSearchBar(),

                // Content
                Expanded(child: _buildContent()),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.primaryDark, AppTheme.secondaryDark],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: Offset(0, -10),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentBottomNavIndex,
          onTap: _onBottomNavTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withValues(alpha: 0.6),
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'auto_stories',
                color: _currentBottomNavIndex == 0
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.6),
                size: 24,
              ),
              label: 'Stories',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'home',
                color: _currentBottomNavIndex == 1
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.6),
                size: 24,
              ),
              label: 'Properties',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'article',
                color: _currentBottomNavIndex == 2
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.6),
                size: 24,
              ),
              label: 'Blog',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'person_outline',
                color: _currentBottomNavIndex == 3
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.6),
                size: 24,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
