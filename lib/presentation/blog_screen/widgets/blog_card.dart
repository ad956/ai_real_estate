import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class BlogCard extends StatelessWidget {
  final Map<String, dynamic> blog;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const BlogCard({
    Key? key,
    required this.blog,
    required this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
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
            // Featured Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: CustomImageWidget(
                imageUrl: blog["featuredImage"] as String? ?? "",
                width: double.infinity,
                height: 25.h,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Tag
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.primaryColor.withValues(
                        alpha: 0.1,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      blog["category"] as String? ?? "General",
                      style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                        color: AppTheme.lightTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: 1.h),

                  // Headline
                  Text(
                    blog["headline"] as String? ?? "No Title",
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 1.h),

                  // Excerpt
                  Text(
                    blog["excerpt"] as String? ?? "No description available",
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 2.h),

                  // Publication Date and Read Time
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'schedule',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 16,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        blog["publishedDate"] as String? ?? "Unknown",
                        style: AppTheme.lightTheme.textTheme.labelSmall
                            ?.copyWith(
                              color: AppTheme
                                  .lightTheme
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                      Spacer(),
                      Text(
                        "${blog["readTime"] ?? 5} min read",
                        style: AppTheme.lightTheme.textTheme.labelSmall
                            ?.copyWith(
                              color: AppTheme
                                  .lightTheme
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
