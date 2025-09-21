import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_export.dart';
import '../../services/api_service.dart';
import './widgets/empty_properties_state.dart';
import './widgets/error_properties_state.dart';
import './widgets/properties_shimmer_loader.dart';
import './widgets/modern_property_card.dart';
import './widgets/modern_search_bar.dart';
import './widgets/category_section.dart';
import '../../widgets/shared_bottom_navbar.dart';

class PropertiesScreen extends StatefulWidget {
  const PropertiesScreen({Key? key}) : super(key: key);

  @override
  State<PropertiesScreen> createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends State<PropertiesScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  // State variables
  bool _isLoading = true;
  bool _hasError = false;
  String _selectedCategory = 'All';
  String _searchQuery = '';
  List<Property> _allProperties = [];
  List<CategoryProperty> _categories = [];
  List<CategoryProperty> _filteredCategories = [];
  int _currentBottomNavIndex = 0;



  @override
  void initState() {
    super.initState();
    _initializeData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _initializeData() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final categoryData = await ApiService.getCategoryProperties();
      if (categoryData['success'] == true) {
        final categories = <CategoryProperty>[];
        final allProperties = <Property>[];

        for (var categoryJson in categoryData['data']) {
          final category = CategoryProperty.fromJson(categoryJson);
          categories.add(category);
          allProperties.addAll(category.properties);
        }

        setState(() {
          _categories = categories;
          _filteredCategories = categories;
          _allProperties = allProperties;
          _isLoading = false;
        });
      } else {
        throw Exception('API returned success: false');
      }
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



  void _onPropertyTap(Property property) {
    Navigator.pushNamed(
      context,
      '/property-details-screen',
      arguments: property,
    );
  }

  void _showNotificationsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppTheme.backgroundGradientDark,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          padding: EdgeInsets.all(6.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomIconWidget(
                iconName: 'notifications_off',
                color: Colors.white.withValues(alpha: 0.8),
                size: 48,
              ),
              SizedBox(height: 3.h),
              Text(
                'No Notifications',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                'You\'re all caught up! No new notifications at the moment.',
                style: GoogleFonts.poppins(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3.h),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppTheme.searchGradientDark,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    'Got it',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onBottomNavTap(int index) {
    if (index == _currentBottomNavIndex) return;

    switch (index) {
      case 0:
        // Already on Properties screen
        break;
      case 1:
        Navigator.pushReplacementNamed(context, AppRoutes.webStories);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, AppRoutes.blog);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, AppRoutes.emiCalculator);
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/profile-screen');
        break;
    }
  }



  void _filterProperties() {
    if (_searchQuery.isEmpty) {
      setState(() {
        _filteredCategories = _categories;
      });
      return;
    }

    final filtered = <CategoryProperty>[];
    for (final category in _categories) {
      final filteredProperties = category.properties.where((property) {
        final query = _searchQuery.toLowerCase();
        return property.title.toLowerCase().contains(query) ||
               property.location.toLowerCase().contains(query) ||
               property.city.toLowerCase().contains(query) ||
               property.fullLocation.toLowerCase().contains(query);
      }).toList();

      if (filteredProperties.isNotEmpty) {
        filtered.add(CategoryProperty(
          categoryId: category.categoryId,
          categoryName: category.categoryName,
          properties: filteredProperties,
        ));
      }
    }

    setState(() {
      _filteredCategories = filtered;
    });
  }

  Widget _buildCategoriesList() {
    if (_filteredCategories.isEmpty) {
      return EmptyPropertiesState(
        onRetry: _initializeData,
        message: _searchQuery.isNotEmpty ? 'No properties found for "$_searchQuery"' : 'No properties available',
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.only(bottom: 10.h),
      itemCount: _filteredCategories.length,
      itemBuilder: (context, index) {
        final category = _filteredCategories[index];
        return CategorySection(
          category: category,
          onPropertyTap: _onPropertyTap,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildCategoriesList()),
      ],
    );
  }

  Widget _buildLocationHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'location_on',
                color: AppTheme.primaryDark,
                size: 20,
              ),
              SizedBox(width: 1.w),
              Text(
                'Vadodara, India',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CustomIconWidget(
                iconName: 'keyboard_arrow_down',
                color: Colors.white,
                size: 20,
              ),
              Spacer(),
              GestureDetector(
                onTap: _showNotificationsDialog,
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.1),
                        Colors.white.withValues(alpha: 0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: CustomIconWidget(
                    iconName: 'notifications_outlined',
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),
          ModernSearchBar(
            controller: _searchController,
            onChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
              _filterProperties();
            },
            onClear: () {
              _searchController.clear();
              setState(() {
                _searchQuery = '';
              });
              _filterProperties();
            },
            onTap: () {},
            onFilterTap: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppTheme.backgroundGradientDark,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: RefreshIndicator(
              onRefresh: _onRefresh,
              color: Colors.white,
              backgroundColor: AppTheme.primaryDark,
              child: Column(
                children: [
                  SafeArea(child: _buildLocationHeader()),
                  Expanded(child: _buildContent()),
                ],
              ),
            ),
            bottomNavigationBar: SharedBottomNavbar(
              currentIndex: _currentBottomNavIndex,
              onTap: _onBottomNavTap,
            ),
          )),
    );
  }
}
