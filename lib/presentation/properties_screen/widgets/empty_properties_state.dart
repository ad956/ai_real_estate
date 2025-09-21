import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmptyPropertiesState extends StatelessWidget {
  final VoidCallback onRetry;
  final String message;

  const EmptyPropertiesState({
    Key? key,
    required this.onRetry,
    this.message = 'No properties found',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty state illustration
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                iconName: 'home_work',
                color: AppTheme.lightTheme.primaryColor,
                size: 60,
              ),
            ),

            SizedBox(height: 4.h),

            // Message
            Text(
              message,
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 2.h),

            Text(
              'Try adjusting your filters or check back later for new listings.',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 4.h),

            // Retry button
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: CustomIconWidget(
                iconName: 'refresh',
                color: AppTheme.lightTheme.colorScheme.onPrimary,
                size: 20,
              ),
              label: Text('Reset Filters'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
