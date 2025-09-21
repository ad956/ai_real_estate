import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PropertyImageGalleryWidget extends StatefulWidget {
  final List<String> images;
  final String? videoUrl;

  const PropertyImageGalleryWidget({
    Key? key,
    required this.images,
    this.videoUrl,
  }) : super(key: key);

  @override
  State<PropertyImageGalleryWidget> createState() =>
      _PropertyImageGalleryWidgetState();
}

class _PropertyImageGalleryWidgetState
    extends State<PropertyImageGalleryWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allMedia = [...widget.images];
    if (widget.videoUrl != null) {
      allMedia.add(widget.videoUrl!);
    }

    return Container(
      height: 35.h,
      width: double.infinity,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: allMedia.length,
            itemBuilder: (context, index) {
              final mediaUrl = allMedia[index];
              final isVideo =
                  widget.videoUrl != null && mediaUrl == widget.videoUrl;

              return GestureDetector(
                onTap: () => _showFullScreenGallery(context, allMedia, index),
                child: Container(
                  width: double.infinity,
                  height: 35.h,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CustomImageWidget(
                        imageUrl: mediaUrl,
                        width: double.infinity,
                        height: 35.h,
                        fit: BoxFit.cover,
                      ),
                      if (isVideo)
                        Center(
                          child: Container(
                            width: 15.w,
                            height: 15.w,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.6),
                              shape: BoxShape.circle,
                            ),
                            child: CustomIconWidget(
                              iconName: 'play_arrow',
                              color: Colors.white,
                              size: 8.w,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 2.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                allMedia.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 0.5.w),
                  width: _currentIndex == index ? 3.w : 2.w,
                  height: 1.h,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(1.h),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 5.h,
            left: 4.w,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: CustomIconWidget(
                  iconName: 'arrow_back',
                  color: Colors.white,
                  size: 6.w,
                ),
              ),
            ),
          ),
          Positioned(
            top: 5.h,
            right: 4.w,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => _shareProperty(),
                  child: Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: CustomIconWidget(
                      iconName: 'share',
                      color: Colors.white,
                      size: 5.w,
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                GestureDetector(
                  onTap: () => _saveProperty(),
                  child: Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: CustomIconWidget(
                      iconName: 'favorite_border',
                      color: Colors.white,
                      size: 5.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFullScreenGallery(
    BuildContext context,
    List<String> media,
    int initialIndex,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenGalleryWidget(
          media: media,
          initialIndex: initialIndex,
          videoUrl: widget.videoUrl,
        ),
      ),
    );
  }

  void _shareProperty() {
    // Share functionality implementation
  }

  void _saveProperty() {
    // Save property functionality implementation
  }
}

class FullScreenGalleryWidget extends StatefulWidget {
  final List<String> media;
  final int initialIndex;
  final String? videoUrl;

  const FullScreenGalleryWidget({
    Key? key,
    required this.media,
    required this.initialIndex,
    this.videoUrl,
  }) : super(key: key);

  @override
  State<FullScreenGalleryWidget> createState() =>
      _FullScreenGalleryWidgetState();
}

class _FullScreenGalleryWidgetState extends State<FullScreenGalleryWidget> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.media.length,
            itemBuilder: (context, index) {
              final mediaUrl = widget.media[index];
              final isVideo =
                  widget.videoUrl != null && mediaUrl == widget.videoUrl;

              return InteractiveViewer(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CustomImageWidget(
                        imageUrl: mediaUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.contain,
                      ),
                      if (isVideo)
                        Center(
                          child: Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.6),
                              shape: BoxShape.circle,
                            ),
                            child: CustomIconWidget(
                              iconName: 'play_arrow',
                              color: Colors.white,
                              size: 12.w,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          SafeArea(
            child: Positioned(
              top: 2.h,
              left: 4.w,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: CustomIconWidget(
                    iconName: 'close',
                    color: Colors.white,
                    size: 6.w,
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Positioned(
              bottom: 4.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.media.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 1.w),
                    width: _currentIndex == index ? 4.w : 2.w,
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(1.h),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
