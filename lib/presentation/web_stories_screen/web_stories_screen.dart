import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../services/api_service.dart';
import '../../widgets/shared_bottom_navbar.dart';
import './widgets/category_chips_widget.dart';
import './widgets/shimmer_loading_widget.dart';
import './widgets/story_thumbnail_widget.dart';
import './widgets/story_viewer_widget.dart';

class WebStoriesScreen extends StatefulWidget {
  const WebStoriesScreen({Key? key}) : super(key: key);

  @override
  State<WebStoriesScreen> createState() => _WebStoriesScreenState();
}

class _WebStoriesScreenState extends State<WebStoriesScreen>
    with AutomaticKeepAliveClientMixin {
  bool _isLoading = true;
  String _selectedCategory = 'All';
  List<WebStory> _stories = [];
  List<WebStory> _filteredStories = [];
  int _currentBottomNavIndex = 1;

  final List<String> _categories = [
    'All',
    'Market Updates',
    'Property Tours',
    'Investment Tips',
    'New Launches',
    'Price Trends',
  ];



  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadStories();
  }

  Future<void> _loadStories() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await ApiService.getWebStories();
      if (data['success'] == true) {
        final stories = (data['webstories'] as List)
            .map((storyJson) => WebStory.fromJson(storyJson))
            .toList();
        
        setState(() {
          _stories = stories;
          _filteredStories = List.from(_stories);
          _isLoading = false;
        });
      } else {
        throw Exception('API returned success: false');
      }
    } catch (e) {
      setState(() {
        _stories = [];
        _filteredStories = [];
        _isLoading = false;
      });
    }
  }

  void _filterStoriesByCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _filteredStories = List.from(_stories);
    });
  }

  void _openStoryViewer(int index) {
    HapticFeedback.mediumImpact();

    // Mark story as read - implementation would go here

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            StoryViewerWidget(
              stories: _filteredStories,
              initialIndex: index,
              onClose: () => Navigator.of(context).pop(),
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: Duration(milliseconds: 300),
        reverseTransitionDuration: Duration(milliseconds: 200),
      ),
    );
  }

  void _showStoryActions(int index) {
    HapticFeedback.lightImpact();

    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'share',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              title: Text(
                'Share Story',
                style: AppTheme.lightTheme.textTheme.titleMedium,
              ),
              onTap: () {
                Navigator.pop(context);
                // Share functionality would be implemented here
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'bookmark_border',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              title: Text(
                'Save for Later',
                style: AppTheme.lightTheme.textTheme.titleMedium,
              ),
              onTap: () {
                Navigator.pop(context);
                // Save functionality would be implemented here
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    HapticFeedback.lightImpact();
    await _loadStories();
  }

  void _onBottomNavTap(int index) {
    if (index == _currentBottomNavIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRoutes.properties);
        break;
      case 1:
        // Already on Stories screen
        break;
      case 2:
        Navigator.pushReplacementNamed(context, AppRoutes.blog);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, AppRoutes.emiCalculator);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.pushReplacementNamed(context, AppRoutes.properties);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppTheme.backgroundGradientDark,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'Web Stories',
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {},
                icon: CustomIconWidget(
                  iconName: 'search',
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              CategoryChipsWidget(
                categories: _categories,
                selectedCategory: _selectedCategory,
                onCategorySelected: _filterStoriesByCategory,
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: _isLoading
                    ? ShimmerGridWidget()
                    : RefreshIndicator(
                        onRefresh: _onRefresh,
                        color: AppTheme.lightTheme.colorScheme.primary,
                        child: _filteredStories.isEmpty
                            ? _buildEmptyState()
                            : GridView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 4.w,
                                      mainAxisSpacing: 4.w,
                                      childAspectRatio: 0.65,
                                    ),
                                itemCount: _filteredStories.length,
                                itemBuilder: (context, index) {
                                  return StoryThumbnailWidget(
                                    story: _filteredStories[index],
                                    onTap: () => _openStoryViewer(index),
                                    onLongPress: () => _showStoryActions(index),
                                  );
                                },
                              ),
                      ),
              ),
            ],
          ),
          bottomNavigationBar: SharedBottomNavbar(
            currentIndex: _currentBottomNavIndex,
            onTap: _onBottomNavTap,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'video_library',
            color: AppTheme.lightTheme.colorScheme.outline,
            size: 64,
          ),
          SizedBox(height: 2.h),
          Text(
            'No stories found',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Try selecting a different category',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
