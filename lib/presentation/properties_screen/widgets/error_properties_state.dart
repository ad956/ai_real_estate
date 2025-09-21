import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ErrorPropertiesState extends StatelessWidget {
  final VoidCallback onRetry;
  final String errorMessage;

  const ErrorPropertiesState({
    Key? key,
    required this.onRetry,
    this.errorMessage = 'Something went wrong',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error illustration
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.error.withValues(
                  alpha: 0.1,
                ),
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                iconName: 'error_outline',
                color: AppTheme.lightTheme.colorScheme.error,
                size: 60,
              ),
            ),

            SizedBox(height: 4.h),

            // Error message
            Text(
              errorMessage,
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 2.h),

            Text(
              'Please check your internet connection and try again.',
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
              label: Text('Try Again'),
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
