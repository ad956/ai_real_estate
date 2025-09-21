import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/property_image_gallery_widget.dart';
import './widgets/property_info_widget.dart';
import './widgets/recommended_properties_widget.dart';
import './widgets/whatsapp_contact_widget.dart';

class PropertyDetailsScreen extends StatefulWidget {
  const PropertyDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final shouldShowAppBar = _scrollController.offset > 25.h;
    if (shouldShowAppBar != _isAppBarVisible) {
      setState(() {
        _isAppBarVisible = shouldShowAppBar;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppTheme.backgroundGradientDark,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: _isAppBarVisible ? _buildAppBar() : null,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: PropertyImageGalleryWidget(
                    images: _propertyData["images"] as List<String>,
                    videoUrl: _propertyData["videoUrl"] as String?,
                  ),
                ),
                SliverToBoxAdapter(
                  child: PropertyInfoWidget(property: _propertyData),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 3.h)),
                SliverToBoxAdapter(child: RecommendedPropertiesWidget()),
                SliverToBoxAdapter(
                  child: SizedBox(height: 10.h), // Space for bottom bar
                ),
              ],
            ),
          ),
        ],
      ),
        bottomNavigationBar: WhatsAppContactWidget(property: _propertyData),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.lightTheme.colorScheme.surface.withValues(
        alpha: 0.95,
      ),
      elevation: 1,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightTheme.colorScheme.shadow,
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 5.w,
          ),
        ),
      ),
      title: Text(
        _propertyData["title"] as String? ?? "Property Details",
        style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      actions: [
        GestureDetector(
          onTap: () => _shareProperty(),
          child: Container(
            margin: EdgeInsets.all(2.w),
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.lightTheme.colorScheme.shadow,
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: CustomIconWidget(
              iconName: 'share',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 4.w,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => _saveProperty(),
          child: Container(
            margin: EdgeInsets.only(right: 4.w, top: 2.w, bottom: 2.w),
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.lightTheme.colorScheme.shadow,
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: CustomIconWidget(
              iconName: 'favorite_border',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 4.w,
            ),
          ),
        ),
      ],
    );
  }

  void _shareProperty() {
    // Share property functionality
  }

  void _saveProperty() {
    // Save property functionality
  }

  final Map<String, dynamic> _propertyData = {
    "id": 1,
    "title": "Luxury 3BHK Apartment with Sea View",
    "price": "₹1,25,00,000",
    "priceType": "All Inclusive",
    "location": "Marine Drive, Mumbai",
    "pinCode": "400020",
    "type": "Apartment",
    "status": "Available",
    "description":
        """This stunning 3BHK apartment offers breathtaking sea views from every room. Located in the heart of Marine Drive, this property combines luxury living with prime location advantages.

The apartment features modern amenities, spacious rooms, and premium finishes throughout. With easy access to business districts, shopping centers, and entertainment hubs, this is an ideal choice for families and professionals alike.

The building offers 24/7 security, power backup, and covered parking. The property is ready to move in and comes with all necessary approvals and clear titles.""",
    "images": [
      "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800&h=600&fit=crop",
      "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&h=600&fit=crop",
      "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800&h=600&fit=crop",
      "https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800&h=600&fit=crop",
      "https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800&h=600&fit=crop",
    ],
    "videoUrl":
        "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800&h=600&fit=crop",
    "specifications": {
      "bedrooms": 3,
      "bathrooms": 2,
      "area": "1450 sq ft",
      "parking": "2 Cars",
      "floor": "12th Floor",
      "facing": "West",
    },
    "amenities": [
      "Swimming Pool",
      "Gym",
      "24/7 Security",
      "Power Backup",
      "Elevator",
      "Garden",
      "Club House",
      "Children's Play Area",
      "Intercom",
      "Fire Safety",
    ],
    "agent": {
      "name": "Rajesh Kumar",
      "phone": "+91 98765 43210",
      "email": "rajesh@realestatepro.com",
      "experience": "8 years",
    },
  };
}
