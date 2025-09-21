import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class BlogSkeletonLoader extends StatefulWidget {
  const BlogSkeletonLoader({Key? key}) : super(key: key);

  @override
  State<BlogSkeletonLoader> createState() => _BlogSkeletonLoaderState();
}

class _BlogSkeletonLoaderState extends State<BlogSkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
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
              // Image skeleton
              Container(
                width: double.infinity,
                height: 25.h,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.outline.withValues(
                    alpha: _animation.value * 0.3,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category skeleton
                    Container(
                      width: 20.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: _animation.value * 0.3),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),

                    SizedBox(height: 1.h),

                    // Title skeleton
                    Container(
                      width: 80.w,
                      height: 2.5.h,
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: _animation.value * 0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    SizedBox(height: 0.5.h),

                    Container(
                      width: 60.w,
                      height: 2.5.h,
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: _animation.value * 0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    SizedBox(height: 1.h),

                    // Description skeleton
                    Container(
                      width: double.infinity,
                      height: 2.h,
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: _animation.value * 0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    SizedBox(height: 0.5.h),

                    Container(
                      width: 70.w,
                      height: 2.h,
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: _animation.value * 0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    SizedBox(height: 2.h),

                    // Date and read time skeleton
                    Row(
                      children: [
                        Container(
                          width: 25.w,
                          height: 1.5.h,
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.outline
                                .withValues(alpha: _animation.value * 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 15.w,
                          height: 1.5.h,
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.outline
                                .withValues(alpha: _animation.value * 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
