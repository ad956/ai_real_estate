import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ShimmerLoadingWidget extends StatefulWidget {
  const ShimmerLoadingWidget({Key? key}) : super(key: key);

  @override
  State<ShimmerLoadingWidget> createState() => _ShimmerLoadingWidgetState();
}

class _ShimmerLoadingWidgetState extends State<ShimmerLoadingWidget>
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
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat();
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                (_animation.value - 1).clamp(0.0, 1.0),
                _animation.value.clamp(0.0, 1.0),
                (_animation.value + 1).clamp(0.0, 1.0),
              ],
              colors: [
                AppTheme.lightTheme.colorScheme.surface,
                AppTheme.lightTheme.colorScheme.surface.withValues(alpha: 0.5),
                AppTheme.lightTheme.colorScheme.surface,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: double.infinity,
            height: 25.h,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface.withValues(
                alpha: 0.8,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}

class ShimmerGridWidget extends StatelessWidget {
  const ShimmerGridWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(4.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 3.w,
        childAspectRatio: 0.75,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return ShimmerLoadingWidget();
      },
    );
  }
}
