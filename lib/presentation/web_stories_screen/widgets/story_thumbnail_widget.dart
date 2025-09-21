import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_export.dart';

class StoryThumbnailWidget extends StatelessWidget {
  final WebStory story;
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
    final String imageUrl = story.details.isNotEmpty 
        ? story.details.first.fullImageUrl
        : 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400&h=600&fit=crop';

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Background Image
              Container(
                width: double.infinity,
                height: 30.h,
                child: CustomImageWidget(
                  imageUrl: imageUrl,
                  width: double.infinity,
                  height: 30.h,
                  fit: BoxFit.cover,
                ),
              ),

              // Gradient Overlay
              Container(
                width: double.infinity,
                height: 30.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.8),
                    ],
                  ),
                ),
              ),

              // Play Icon
              Positioned(
                top: 3.h,
                right: 3.w,
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: AppTheme.primaryDark,
                    size: 4.w,
                  ),
                ),
              ),

              // Views Badge
              Positioned(
                top: 3.h,
                left: 3.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppTheme.accentDark, AppTheme.primaryDark],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.accentDark.withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    '${story.views} views',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // Title
              Positioned(
                bottom: 3.h,
                left: 3.w,
                right: 3.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      story.title,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.white.withValues(alpha: 0.8),
                          size: 3.w,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          '2 min read',
                          style: GoogleFonts.poppins(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
