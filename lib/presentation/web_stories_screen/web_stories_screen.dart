import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
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
  List<Map<String, dynamic>> _stories = [];
  List<Map<String, dynamic>> _filteredStories = [];

  final List<String> _categories = [
    'All',
    'Market Updates',
    'Property Tours',
    'Investment Tips',
    'New Launches',
    'Price Trends',
  ];

  // Mock data for web stories
  final List<Map<String, dynamic>> _mockStories = [
    {
      "id": 1,
      "title": "Luxury Apartments in Mumbai - New Launch",
      "category": "New Launches",
      "duration": "1:45",
      "imageUrl":
          "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=400&h=600&fit=crop",
      "isRead": false,
      "createdAt": "2025-01-20T10:30:00Z",
    },
    {
      "id": 2,
      "title": "Real Estate Market Trends 2025",
      "category": "Market Updates",
      "duration": "2:15",
      "imageUrl":
          "https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400&h=600&fit=crop",
      "isRead": true,
      "createdAt": "2025-01-19T15:20:00Z",
    },
    {
      "id": 3,
      "title": "Smart Investment Strategies for Properties",
      "category": "Investment Tips",
      "duration": "3:00",
      "imageUrl":
          "https://images.unsplash.com/photo-1554469384-e58fac16e23a?w=400&h=600&fit=crop",
      "isRead": false,
      "createdAt": "2025-01-19T09:45:00Z",
    },
    {
      "id": 4,
      "title": "Virtual Tour: 3BHK Premium Villa",
      "category": "Property Tours",
      "duration": "4:30",
      "imageUrl":
          "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=400&h=600&fit=crop",
      "isRead": false,
      "createdAt": "2025-01-18T14:10:00Z",
    },
    {
      "id": 5,
      "title": "Price Analysis: Bangalore vs Mumbai",
      "category": "Price Trends",
      "duration": "2:45",
      "imageUrl":
          "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=400&h=600&fit=crop",
      "isRead": true,
      "createdAt": "2025-01-18T11:30:00Z",
    },
    {
      "id": 6,
      "title": "Commercial Spaces: Office Investment Guide",
      "category": "Investment Tips",
      "duration": "3:20",
      "imageUrl":
          "https://images.unsplash.com/photo-1497366216548-37526070297c?w=400&h=600&fit=crop",
      "isRead": false,
      "createdAt": "2025-01-17T16:45:00Z",
    },
    {
      "id": 7,
      "title": "Upcoming Projects in Pune",
      "category": "New Launches",
      "duration": "2:00",
      "imageUrl":
          "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=400&h=600&fit=crop",
      "isRead": false,
      "createdAt": "2025-01-17T08:20:00Z",
    },
    {
      "id": 8,
      "title": "Market Outlook: Q1 2025 Predictions",
      "category": "Market Updates",
      "duration": "1:55",
      "imageUrl":
          "https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=400&h=600&fit=crop",
      "isRead": false,
      "createdAt": "2025-01-16T13:15:00Z",
    },
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

    // Simulate API call delay
    await Future.delayed(Duration(milliseconds: 1500));

    setState(() {
      _stories = List.from(_mockStories);
      _filteredStories = List.from(_stories);
      _isLoading = false;
    });
  }

  void _filterStoriesByCategory(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == 'All') {
        _filteredStories = List.from(_stories);
      } else {
        _filteredStories = _stories
            .where((story) => (story['category'] as String) == category)
            .toList();
      }
    });
  }

  void _openStoryViewer(int index) {
    HapticFeedback.mediumImpact();

    // Mark story as read
    setState(() {
      _filteredStories[index]['isRead'] = true;
      // Update in main stories list as well
      final storyId = _filteredStories[index]['id'];
      final mainIndex = _stories.indexWhere((story) => story['id'] == storyId);
      if (mainIndex != -1) {
        _stories[mainIndex]['isRead'] = true;
      }
    });

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

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Web Stories',
          style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              // Search functionality would be implemented here
            },
            icon: CustomIconWidget(
              iconName: 'search',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 24,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Chips
          CategoryChipsWidget(
            categories: _categories,
            selectedCategory: _selectedCategory,
            onCategorySelected: _filterStoriesByCategory,
          ),

          SizedBox(height: 2.h),

          // Stories Grid
          Expanded(
            child: _isLoading
                ? ShimmerGridWidget()
                : RefreshIndicator(
                    onRefresh: _onRefresh,
                    color: AppTheme.lightTheme.colorScheme.primary,
                    child: _filteredStories.isEmpty
                        ? _buildEmptyState()
                        : GridView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 3.w,
                                  mainAxisSpacing: 3.w,
                                  childAspectRatio: 0.75,
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
