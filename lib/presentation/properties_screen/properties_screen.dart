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
import '../../widgets/floating_whatsapp_button.dart';

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

  // Filter variables
  String _selectedPropertyType = 'All';
  String _selectedPriceRange = 'All';
  String _selectedLocation = 'All';
  String _selectedBedrooms = 'All';

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
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
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

  void _showFilterDialog() {
    // Create local copies of filter states
    String tempPropertyType = _selectedPropertyType;
    String tempPriceRange = _selectedPriceRange;
    String tempLocation = _selectedLocation;
    String tempBedrooms = _selectedBedrooms;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: 70.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppTheme.backgroundGradientDark,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(4.w),
                child: Row(
                  children: [
                    Text(
                      'Filters',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFilterSection(
                          'Property Type',
                          ['All', 'Apartment', 'Villa', 'Commercial'],
                          tempPropertyType, (value) {
                        setModalState(() => tempPropertyType = value);
                      }),
                      SizedBox(height: 3.h),
                      _buildFilterSection(
                          'Price Range',
                          [
                            'All',
                            'Under 50L',
                            '50L - 1Cr',
                            '1Cr - 2Cr',
                            'Above 2Cr'
                          ],
                          tempPriceRange, (value) {
                        setModalState(() => tempPriceRange = value);
                      }),
                      SizedBox(height: 3.h),
                      _buildFilterSection(
                          'Location',
                          ['All', 'Alkapuri', 'Gotri', 'Fatehgunj', 'Akota'],
                          tempLocation, (value) {
                        setModalState(() => tempLocation = value);
                      }),
                      SizedBox(height: 3.h),
                      _buildFilterSection(
                          'Bedrooms',
                          ['All', '1', '2', '3', '4', '5+'],
                          tempBedrooms, (value) {
                        setModalState(() => tempBedrooms = value);
                      }),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(4.w),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setModalState(() {
                            tempPropertyType = 'All';
                            tempPriceRange = 'All';
                            tempLocation = 'All';
                            tempBedrooms = 'All';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Clear All'),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedPropertyType = tempPropertyType;
                            _selectedPriceRange = tempPriceRange;
                            _selectedLocation = tempLocation;
                            _selectedBedrooms = tempBedrooms;
                          });
                          _filterProperties();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryDark,
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Apply Filters'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, List<String> options,
      String selected, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: options.map((option) {
            final isSelected = selected == option;
            return GestureDetector(
              onTap: () => onChanged(option),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primaryDark
                      : Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.primaryDark
                        : Colors.white.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  option,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
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
    }
  }

  void _filterProperties() {
    final filtered = <CategoryProperty>[];

    for (final category in _categories) {
      final filteredProperties = category.properties.where((property) {
        // Search query filter
        bool matchesSearch = true;
        if (_searchQuery.isNotEmpty) {
          final query = _searchQuery.toLowerCase();
          matchesSearch = property.title.toLowerCase().contains(query) ||
              property.location.toLowerCase().contains(query) ||
              property.city.toLowerCase().contains(query) ||
              property.description.toLowerCase().contains(query) ||
              property.propertyType.toLowerCase().contains(query) ||
              property.fullLocation.toLowerCase().contains(query);
        }

        // Property type filter
        bool matchesType = _selectedPropertyType == 'All' ||
            property.propertyType
                .toLowerCase()
                .contains(_selectedPropertyType.toLowerCase());

        // Price range filter
        bool matchesPrice =
            _selectedPriceRange == 'All' || _matchesPriceRange(property.price);

        // Location filter
        bool matchesLocation = _selectedLocation == 'All' ||
            property.location
                .toLowerCase()
                .contains(_selectedLocation.toLowerCase()) ||
            property.city
                .toLowerCase()
                .contains(_selectedLocation.toLowerCase());

        // Bedrooms filter
        bool matchesBedrooms = _selectedBedrooms == 'All' ||
            property.bedrooms == _selectedBedrooms ||
            (_selectedBedrooms == '5+' &&
                int.tryParse(property.bedrooms) != null &&
                int.parse(property.bedrooms) >= 5);

        return matchesSearch &&
            matchesType &&
            matchesPrice &&
            matchesLocation &&
            matchesBedrooms;
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

  bool _matchesPriceRange(String price) {
    if (price.isEmpty) return true;
    final priceNum = _extractPriceNumber(price);
    switch (_selectedPriceRange) {
      case 'Under 50L':
        return priceNum < 50;
      case '50L - 1Cr':
        return priceNum >= 50 && priceNum < 100;
      case '1Cr - 2Cr':
        return priceNum >= 100 && priceNum < 200;
      case 'Above 2Cr':
        return priceNum >= 200;
      default:
        return true;
    }
  }

  double _extractPriceNumber(String price) {
    if (price.isEmpty) return 0;

    final cleanPrice =
        price.replaceAll('₹', '').replaceAll(',', '').toLowerCase().trim();

    if (cleanPrice.contains('cr') || cleanPrice.contains('crore')) {
      final numStr = cleanPrice
          .replaceAll('cr', '')
          .replaceAll('crore', '')
          .replaceAll('₹', '')
          .trim();
      return (double.tryParse(numStr) ?? 0) * 100;
    } else if (cleanPrice.contains('lakh') ||
        cleanPrice.contains('l ') ||
        cleanPrice.endsWith('l')) {
      final numStr = cleanPrice
          .replaceAll('lakh', '')
          .replaceAll('lakhs', '')
          .replaceAll('l', '')
          .replaceAll('₹', '')
          .trim();
      return double.tryParse(numStr) ?? 0;
    } else {
      // Try to parse as direct number
      final numStr = cleanPrice.replaceAll('₹', '').trim();
      final num = double.tryParse(numStr) ?? 0;
      // If number is very large, assume it's in actual rupees, convert to lakhs
      if (num > 10000000) {
        return num / 100000; // Convert to lakhs
      }
      return num;
    }
  }

  Widget _buildCategoriesList() {
    if (_filteredCategories.isEmpty) {
      return EmptyPropertiesState(
        onRetry: _initializeData,
        message: _searchQuery.isNotEmpty
            ? 'No properties found for "$_searchQuery"'
            : 'No properties available',
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
              Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.1),
                      Colors.white.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/app_logo.png',
                    width: 12.w,
                    height: 12.w,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'location_on',
                          color: AppTheme.primaryDark,
                          size: 16,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          'Vadodara, India',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        CustomIconWidget(
                          iconName: 'keyboard_arrow_down',
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
            onFilterTap: _showFilterDialog,
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
          child: Stack(
            children: [
              Scaffold(
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
              ),
              FloatingWhatsAppButton(),
            ],
          )),
    );
  }
}
