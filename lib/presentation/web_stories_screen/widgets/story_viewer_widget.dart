import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/app_export.dart';

class StoryViewerWidget extends StatefulWidget {
  final List<WebStory> stories;
  final int initialIndex;
  final VoidCallback onClose;

  const StoryViewerWidget({
    Key? key,
    required this.stories,
    required this.initialIndex,
    required this.onClose,
  }) : super(key: key);

  @override
  State<StoryViewerWidget> createState() => _StoryViewerWidgetState();
}

class _StoryViewerWidgetState extends State<StoryViewerWidget>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _progressController;
  int _currentIndex = 0;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _progressController = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    );
    _startStoryProgress();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _startStoryProgress() {
    _progressController.reset();
    _progressController.forward().then((_) {
      if (!_isPaused && mounted) {
        _nextStory();
      }
    });
  }

  void _nextStory() {
    if (_currentIndex < widget.stories.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _startStoryProgress();
    } else {
      widget.onClose();
    }
  }

  void _previousStory() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _startStoryProgress();
    }
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });

    if (_isPaused) {
      _progressController.stop();
    } else {
      _progressController.forward();
    }
  }

  void _onTapLeft() {
    HapticFeedback.lightImpact();
    _previousStory();
  }

  void _onTapRight() {
    HapticFeedback.lightImpact();
    _nextStory();
  }

  void _onTapCenter() {
    HapticFeedback.selectionClick();
    _togglePause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            widget.onClose();
          }
        },
        child: Stack(
          children: [
            // Story Content
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
                _startStoryProgress();
              },
              itemCount: widget.stories.length,
              itemBuilder: (context, index) {
                final story = widget.stories[index];
                final imageUrl = story.details.isNotEmpty 
                    ? story.details.first.fullImageUrl
                    : 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400&h=600&fit=crop';
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: CustomImageWidget(
                    imageUrl: imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),

            // Touch Areas
            Row(
              children: [
                // Left tap area
                Expanded(
                  child: GestureDetector(
                    onTap: _onTapLeft,
                    child: Container(
                      color: Colors.transparent,
                      height: double.infinity,
                    ),
                  ),
                ),
                // Center tap area
                Expanded(
                  child: GestureDetector(
                    onTap: _onTapCenter,
                    child: Container(
                      color: Colors.transparent,
                      height: double.infinity,
                    ),
                  ),
                ),
                // Right tap area
                Expanded(
                  child: GestureDetector(
                    onTap: _onTapRight,
                    child: Container(
                      color: Colors.transparent,
                      height: double.infinity,
                    ),
                  ),
                ),
              ],
            ),

            // Top Controls
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  // Progress Indicators
                  Row(
                    children: List.generate(
                      widget.stories.length,
                      (index) => Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: AnimatedBuilder(
                            animation: _progressController,
                            builder: (context, child) {
                              double progress = 0.0;
                              if (index < _currentIndex) {
                                progress = 1.0;
                              } else if (index == _currentIndex) {
                                progress = _progressController.value;
                              }

                              return FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: progress,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Story Header
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.stories[_currentIndex].title,
                              style: AppTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Real Estate Story',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.8),
                                  ),
                            ),
                          ],
                        ),
                      ),

                      // Pause/Play Button
                      GestureDetector(
                        onTap: _togglePause,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: CustomIconWidget(
                            iconName: _isPaused ? 'play_arrow' : 'pause',
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),

                      SizedBox(width: 12),

                      // Close Button
                      GestureDetector(
                        onTap: widget.onClose,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: CustomIconWidget(
                            iconName: 'close',
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Bottom Actions
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 24,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Share Button
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      // Share functionality would be implemented here
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconWidget(
                            iconName: 'share',
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Share',
                            style: AppTheme.lightTheme.textTheme.labelMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Save Button
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      // Save functionality would be implemented here
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconWidget(
                            iconName: 'bookmark_border',
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Save',
                            style: AppTheme.lightTheme.textTheme.labelMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ),
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
