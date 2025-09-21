import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RecommendedPropertiesWidget extends StatelessWidget {
  const RecommendedPropertiesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Similar Properties",
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, '/properties-screen'),
                  child: Text(
                    "View All",
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.lightTheme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          Container(
            height: 32.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              itemCount: _recommendedProperties.length,
              itemBuilder: (context, index) {
                final property = _recommendedProperties[index];
                return _buildPropertyCard(context, property);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyCard(
    BuildContext context,
    Map<String, dynamic> property,
  ) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/property-details-screen'),
      child: Container(
        width: 70.w,
        margin: EdgeInsets.only(right: 4.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(3.w),
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.colorScheme.shadow,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPropertyImage(property),
            _buildPropertyInfo(property),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyImage(Map<String, dynamic> property) {
    return Container(
      height: 18.h,
      width: double.infinity,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(3.w)),
            child: CustomImageWidget(
              imageUrl: property["image"] as String,
              width: double.infinity,
              height: 18.h,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 2.w,
            right: 2.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
              decoration: BoxDecoration(
                color: _getStatusColor(
                  property["status"] as String,
                ).withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(1.w),
              ),
              child: Text(
                property["status"] as String,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 8.sp,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 2.w,
            left: 2.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(1.w),
              ),
              child: Text(
                property["type"] as String,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 8.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyInfo(Map<String, dynamic> property) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              property["price"] as String,
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.lightTheme.primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              property["title"] as String,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 0.5.h),
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'location_on',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 3.w,
                ),
                SizedBox(width: 1.w),
                Expanded(
                  child: Text(
                    property["location"] as String,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                _buildSpecIcon(
                  'bed',
                  (property["specifications"]
                              as Map<String, dynamic>)["bedrooms"]
                          ?.toString() ??
                      "0",
                ),
                SizedBox(width: 3.w),
                _buildSpecIcon(
                  'bathtub',
                  (property["specifications"]
                              as Map<String, dynamic>)["bathrooms"]
                          ?.toString() ??
                      "0",
                ),
                SizedBox(width: 3.w),
                _buildSpecIcon(
                  'square_foot',
                  (property["specifications"] as Map<String, dynamic>)["area"]
                          ?.toString() ??
                      "0",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecIcon(String iconName, String value) {
    return Row(
      children: [
        CustomIconWidget(
          iconName: iconName,
          color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          size: 3.w,
        ),
        SizedBox(width: 0.5.w),
        Text(
          value,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            fontSize: 8.sp,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return AppTheme.getSuccessColor(true);
      case 'sold':
        return AppTheme.lightTheme.colorScheme.error;
      case 'pending':
        return AppTheme.getWarningColor(true);
      default:
        return AppTheme.lightTheme.colorScheme.onSurfaceVariant;
    }
  }

  final List<Map<String, dynamic>> _recommendedProperties = const [
    {
      "id": 1,
      "title": "Modern Apartment in Downtown",
      "price": "₹85,00,000",
      "location": "Bandra West, Mumbai",
      "pinCode": "400050",
      "type": "Apartment",
      "status": "Available",
      "image":
          "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800&h=600&fit=crop",
      "specifications": {
        "bedrooms": 3,
        "bathrooms": 2,
        "area": "1200 sq ft",
        "parking": "1 Car",
        "floor": "5th Floor",
      },
    },
    {
      "id": 2,
      "title": "Luxury Villa with Garden",
      "price": "₹2,50,00,000",
      "location": "Juhu, Mumbai",
      "pinCode": "400049",
      "type": "Villa",
      "status": "Available",
      "image":
          "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800&h=600&fit=crop",
      "specifications": {
        "bedrooms": 4,
        "bathrooms": 3,
        "area": "2500 sq ft",
        "parking": "2 Cars",
        "floor": "Ground Floor",
      },
    },
    {
      "id": 3,
      "title": "Cozy Studio Near Metro",
      "price": "₹45,00,000",
      "location": "Andheri East, Mumbai",
      "pinCode": "400069",
      "type": "Studio",
      "status": "Pending",
      "image":
          "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&h=600&fit=crop",
      "specifications": {
        "bedrooms": 1,
        "bathrooms": 1,
        "area": "450 sq ft",
        "parking": "No Parking",
        "floor": "3rd Floor",
      },
    },
    {
      "id": 4,
      "title": "Spacious Family Home",
      "price": "₹1,75,00,000",
      "location": "Powai, Mumbai",
      "pinCode": "400076",
      "type": "House",
      "status": "Available",
      "image":
          "https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=800&h=600&fit=crop",
      "specifications": {
        "bedrooms": 3,
        "bathrooms": 2,
        "area": "1800 sq ft",
        "parking": "2 Cars",
        "floor": "Ground Floor",
      },
    },
  ];
}
