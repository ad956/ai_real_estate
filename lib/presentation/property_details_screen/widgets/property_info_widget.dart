import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PropertyInfoWidget extends StatelessWidget {
  final Property? property;

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
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: AppTheme.primaryDark,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  property?.propertyType ?? 'Property',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.orange, size: 4.w),
                  SizedBox(width: 1.w),
                  Text(
                    '4.5 (365 reviews)',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 2.h),
          _buildTitleSection(),
          SizedBox(height: 1.h),
          _buildLocationSection(),
          SizedBox(height: 3.h),
          Row(
            children: [
              Text(
                'About',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryDark,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                'Gallery',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                'Review',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Container(
            height: 2,
            width: 12.w,
            decoration: BoxDecoration(
              color: AppTheme.primaryDark,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          SizedBox(height: 3.h),
          _buildSpecificationsSection(),
          SizedBox(height: 3.h),
          _buildDescriptionSection(),
          SizedBox(height: 3.h),
          _buildListingAgent(),
          SizedBox(height: 3.h),
          _buildPriceSection(),
        ],
      ),
    );
  }

  Widget _buildPriceSection() {
    return Row(
      children: [
        Text(
          property?.formattedPrice ?? "₹0",
          style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
            color: AppTheme.lightTheme.primaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 2.w),
        if (property?.status.isNotEmpty == true)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(1.h),
            ),
            child: Text(
              property!.status,
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
      property?.title ?? "Property Title",
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
            "${property?.fullLocation ?? "Location"} - ${property?.pinCode ?? "000000"}",
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge() {
    final status = property?.status ?? "Available";
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
    return Row(
      children: [
        if (property?.bedrooms.isNotEmpty == true)
          _buildSpecItem(
            "${property!.bedrooms} Beds",
            Icons.bed,
          ),
        if (property?.bedrooms.isNotEmpty == true) SizedBox(width: 6.w),
        if (property?.bathrooms.isNotEmpty == true)
          _buildSpecItem(
            "${property!.bathrooms} Bath",
            Icons.bathtub,
          ),
        if (property?.bathrooms.isNotEmpty == true) SizedBox(width: 6.w),
        if (property?.areaSqft.isNotEmpty == true)
          _buildSpecItem(
            "${property!.areaSqft} sqft",
            Icons.square_foot,
          ),
      ],
    );
  }

  Widget _buildSpecItem(String label, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppTheme.primaryDark,
          size: 5.w,
        ),
        SizedBox(width: 1.w),
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          property?.description.isNotEmpty == true 
              ? property!.description 
              : 'No description available for this property.',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            height: 1.5,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'Read more',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.primaryDark,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildListingAgent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Listing Agent',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          children: [
            CircleAvatar(
              radius: 6.w,
              backgroundColor: Colors.grey[300],
              child: Icon(
                Icons.person,
                color: Colors.grey[600],
                size: 6.w,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property?.postedBy.isNotEmpty == true ? property!.postedBy : 'Property Owner',
                    style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Posted by ${property?.postedBy ?? 'Owner'}',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.primaryDark,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chat,
                color: Colors.white,
                size: 4.w,
              ),
            ),
            SizedBox(width: 2.w),
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.primaryDark,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.phone,
                color: Colors.white,
                size: 4.w,
              ),
            ),
          ],
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
