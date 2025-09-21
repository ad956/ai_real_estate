import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class StoryThumbnailWidget extends StatelessWidget {
  final Map<String, dynamic> story;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const StoryThumbnailWidget({
    Key? key,
    required this.story,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isRead = story['isRead'] ?? false;
    final String duration = story['duration'] ?? '0:30';
    final String title = story['title'] ?? 'Untitled Story';
    final String imageUrl = story['imageUrl'] ?? '';

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.colorScheme.shadow.withValues(
                alpha: 0.1,
              ),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Background Image
              Container(
                width: double.infinity,
                height: 25.h,
                child: CustomImageWidget(
                  imageUrl: imageUrl,
                  width: double.infinity,
                  height: 25.h,
                  fit: BoxFit.cover,
                ),
              ),

              // Gradient Overlay
              Container(
                width: double.infinity,
                height: 25.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                  ),
                ),
              ),

              // Read Indicator
              if (isRead)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.surface.withValues(
                        alpha: 0.9,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CustomIconWidget(
                      iconName: 'check',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 16,
                    ),
                  ),
                ),

              // Duration Badge
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    duration,
                    style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              // Title
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
