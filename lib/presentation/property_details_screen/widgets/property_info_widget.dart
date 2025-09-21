import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PropertyInfoWidget extends StatelessWidget {
  final Map<String, dynamic> property;

  const PropertyInfoWidget({Key? key, required this.property})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPriceSection(),
          SizedBox(height: 2.h),
          _buildTitleSection(),
          SizedBox(height: 1.h),
          _buildLocationSection(),
          SizedBox(height: 2.h),
          _buildStatusBadge(),
          SizedBox(height: 3.h),
          _buildSpecificationsSection(),
          SizedBox(height: 3.h),
          _buildDescriptionSection(),
          SizedBox(height: 3.h),
          _buildAmenitiesSection(),
        ],
      ),
    );
  }

  Widget _buildPriceSection() {
    return Row(
      children: [
        Text(
          property["price"] as String? ?? "₹0",
          style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
            color: AppTheme.lightTheme.primaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 2.w),
        if (property["priceType"] != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(1.h),
            ),
            child: Text(
              property["priceType"] as String,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTitleSection() {
    return Text(
      property["title"] as String? ?? "Property Title",
      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildLocationSection() {
    return Row(
      children: [
        CustomIconWidget(
          iconName: 'location_on',
          color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          size: 4.w,
        ),
        SizedBox(width: 1.w),
        Expanded(
          child: Text(
            "${property["location"] as String? ?? "Location"} - ${property["pinCode"] as String? ?? "000000"}",
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge() {
    final status = property["status"] as String? ?? "Available";
    Color statusColor;

    switch (status.toLowerCase()) {
      case 'available':
        statusColor = AppTheme.getSuccessColor(true);
        break;
      case 'sold':
        statusColor = AppTheme.lightTheme.colorScheme.error;
        break;
      case 'pending':
        statusColor = AppTheme.getWarningColor(true);
        break;
      default:
        statusColor = AppTheme.lightTheme.colorScheme.onSurfaceVariant;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(2.h),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Text(
        status,
        style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
          color: statusColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSpecificationsSection() {
    final specs = property["specifications"] as Map<String, dynamic>? ?? {};

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Property Details",
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.5.h),
        Wrap(
          spacing: 4.w,
          runSpacing: 2.h,
          children: [
            _buildSpecItem(
              "Bedrooms",
              specs["bedrooms"]?.toString() ?? "N/A",
              'bed',
            ),
            _buildSpecItem(
              "Bathrooms",
              specs["bathrooms"]?.toString() ?? "N/A",
              'bathtub',
            ),
            _buildSpecItem(
              "Area",
              specs["area"]?.toString() ?? "N/A",
              'square_foot',
            ),
            _buildSpecItem(
              "Type",
              property["type"]?.toString() ?? "N/A",
              'home',
            ),
            _buildSpecItem(
              "Parking",
              specs["parking"]?.toString() ?? "N/A",
              'local_parking',
            ),
            _buildSpecItem(
              "Floor",
              specs["floor"]?.toString() ?? "N/A",
              'layers',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSpecItem(String label, String value, String iconName) {
    return Container(
      width: 40.w,
      child: Row(
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: CustomIconWidget(
              iconName: iconName,
              color: AppTheme.lightTheme.primaryColor,
              size: 4.w,
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  value,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    final description = property["description"] as String? ?? "";

    if (description.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.5.h),
        Text(
          description,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildAmenitiesSection() {
    final amenities = (property["amenities"] as List?)?.cast<String>() ?? [];

    if (amenities.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Amenities",
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.5.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: amenities
              .map((amenity) => _buildAmenityChip(amenity))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildAmenityChip(String amenity) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(2.h),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        amenity,
        style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
