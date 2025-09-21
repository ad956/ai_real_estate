import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class PropertiesShimmerLoader extends StatefulWidget {
  const PropertiesShimmerLoader({Key? key}) : super(key: key);

  @override
  State<PropertiesShimmerLoader> createState() =>
      _PropertiesShimmerLoaderState();
}

class _PropertiesShimmerLoaderState extends State<PropertiesShimmerLoader>
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

  Widget _buildShimmerContainer({
    required double width,
    required double height,
    BorderRadius? borderRadius,
  }) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.outline.withValues(
              alpha: _animation.value * 0.3,
            ),
            borderRadius: borderRadius ?? BorderRadius.circular(8),
          ),
        );
      },
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.shadow.withValues(
              alpha: 0.1,
            ),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image shimmer
          _buildShimmerContainer(
            width: double.infinity,
            height: 25.h,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),

          // Content shimmer
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title shimmer
                Row(
                  children: [
                    Expanded(
                      child: _buildShimmerContainer(
                        width: double.infinity,
                        height: 2.h,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    _buildShimmerContainer(width: 15.w, height: 2.h),
                  ],
                ),

                SizedBox(height: 1.h),

                // Price shimmer
                _buildShimmerContainer(width: 30.w, height: 2.5.h),

                SizedBox(height: 1.h),

                // Location shimmer
                Row(
                  children: [
                    _buildShimmerContainer(width: 4.w, height: 2.h),
                    SizedBox(width: 1.w),
                    Expanded(
                      child: _buildShimmerContainer(
                        width: double.infinity,
                        height: 2.h,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    _buildShimmerContainer(width: 12.w, height: 2.h),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Category chips shimmer
        Container(
          height: 6.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 3.w),
                child: _buildShimmerContainer(
                  width: 20.w,
                  height: 4.h,
                  borderRadius: BorderRadius.circular(25),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 2.h),

        // Property cards shimmer
        Expanded(
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) => _buildShimmerCard(),
          ),
        ),
      ],
    );
  }
}
