import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';

import './widgets/blog_card.dart';
import './widgets/blog_category_chip.dart';
import './widgets/blog_empty_state.dart';
import './widgets/blog_search_bar.dart';
import './widgets/blog_skeleton_loader.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final Dio _dio = Dio();

  List<Map<String, dynamic>> _allBlogs = [];
  List<Map<String, dynamic>> _filteredBlogs = [];
  List<String> _categories = [];
  String _selectedCategory = "All";
  bool _isLoading = true;
  bool _isLoadingMore = false;
  String _searchQuery = "";
  int _currentPage = 1;
  bool _hasMoreData = true;

  // Mock data for fallback
  final List<Map<String, dynamic>> _mockBlogs = [
    {
      "id": 1,
      "headline": "Top 10 Real Estate Investment Tips for 2024",
      "excerpt":
          "Discover the most effective strategies for real estate investment in today's market. Learn from industry experts about location analysis, market timing, and portfolio diversification.",
      "category": "Investment Tips",
      "featuredImage":
          "https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=800&h=600&fit=crop",
      "publishedDate": "15 Sep 2024",
      "readTime": 8,
      "author": "Sarah Johnson",
      "content":
          "Real estate investment continues to be one of the most reliable ways to build wealth...",
    },
    {
      "id": 2,
      "headline": "Understanding Property Valuation Methods",
      "excerpt":
          "Learn the three main approaches to property valuation: sales comparison, cost approach, and income capitalization. Essential knowledge for buyers and investors.",
      "category": "Market Analysis",
      "featuredImage":
          "https://images.unsplash.com/photo-1554469384-e58fac16e23a?w=800&h=600&fit=crop",
      "publishedDate": "12 Sep 2024",
      "readTime": 6,
      "author": "Michael Chen",
      "content":
          "Property valuation is a critical skill for anyone involved in real estate...",
    },
    {
      "id": 3,
      "headline": "First-Time Home Buyer's Complete Guide",
      "excerpt":
          "Everything you need to know about buying your first home, from pre-approval to closing. Navigate the complex process with confidence and avoid common pitfalls.",
      "category": "Buying Guides",
      "featuredImage":
          "https://images.unsplash.com/photo-1582407947304-fd86f028f716?w=800&h=600&fit=crop",
      "publishedDate": "10 Sep 2024",
      "readTime": 12,
      "author": "Emily Rodriguez",
      "content":
          "Buying your first home is an exciting milestone, but it can also be overwhelming...",
    },
    {
      "id": 4,
      "headline": "New Property Tax Regulations Explained",
      "excerpt":
          "Stay updated with the latest changes in property tax laws. Understand how these regulations affect property owners and potential tax-saving strategies.",
      "category": "Legal Updates",
      "featuredImage":
          "https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=800&h=600&fit=crop",
      "publishedDate": "08 Sep 2024",
      "readTime": 7,
      "author": "David Kumar",
      "content":
          "Recent changes in property tax regulations have significant implications...",
    },
    {
      "id": 5,
      "headline": "Smart Home Technology Trends in Real Estate",
      "excerpt":
          "Explore how smart home features are influencing property values and buyer preferences. From security systems to energy efficiency, technology is reshaping homes.",
      "category": "Market Analysis",
      "featuredImage":
          "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800&h=600&fit=crop",
      "publishedDate": "05 Sep 2024",
      "readTime": 9,
      "author": "Lisa Thompson",
      "content":
          "Smart home technology is no longer a luxury but an expectation...",
    },
    {
      "id": 6,
      "headline": "Commercial Real Estate Investment Strategies",
      "excerpt":
          "Dive into commercial real estate opportunities. Learn about office buildings, retail spaces, and industrial properties as investment vehicles.",
      "category": "Investment Tips",
      "featuredImage":
          "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&h=600&fit=crop",
      "publishedDate": "03 Sep 2024",
      "readTime": 11,
      "author": "Robert Wilson",
      "content":
          "Commercial real estate offers unique opportunities for investors...",
    },
    {
      "id": 7,
      "headline": "Mortgage Rate Predictions for Next Quarter",
      "excerpt":
          "Expert analysis on mortgage rate trends and what they mean for buyers and refinancers. Make informed decisions with our market insights.",
      "category": "Market Analysis",
      "featuredImage":
          "https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=800&h=600&fit=crop",
      "publishedDate": "01 Sep 2024",
      "readTime": 5,
      "author": "Jennifer Lee",
      "content":
          "Mortgage rates continue to be a key factor in real estate decisions...",
    },
    {
      "id": 8,
      "headline": "Property Insurance: What You Need to Know",
      "excerpt":
          "Comprehensive guide to property insurance options. Protect your investment with the right coverage and understand policy details that matter most.",
      "category": "Legal Updates",
      "featuredImage":
          "https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=800&h=600&fit=crop",
      "publishedDate": "28 Aug 2024",
      "readTime": 8,
      "author": "Mark Anderson",
      "content":
          "Property insurance is essential protection for real estate owners...",
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeData() {
    _loadBlogData();
    _extractCategories();
  }

  Future<void> _loadBlogData() async {
    setState(() => _isLoading = true);

    try {
      // Simulate API call with Dio
      await Future.delayed(Duration(milliseconds: 1500));

      // Use mock data as fallback
      _allBlogs = List.from(_mockBlogs);
      _filteredBlogs = List.from(_allBlogs);
    } catch (e) {
      // Fallback to mock data on error
      _allBlogs = List.from(_mockBlogs);
      _filteredBlogs = List.from(_allBlogs);
    }

    setState(() => _isLoading = false);
  }

  void _extractCategories() {
    final Set<String> categorySet = {"All"};
    for (final blog in _mockBlogs) {
      final category = blog["category"] as String?;
      if (category != null && category.isNotEmpty) {
        categorySet.add(category);
      }
    }
    _categories = categorySet.toList();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreBlogs();
    }
  }

  Future<void> _loadMoreBlogs() async {
    if (_isLoadingMore || !_hasMoreData) return;

    setState(() => _isLoadingMore = true);

    try {
      await Future.delayed(Duration(milliseconds: 1000));
      // Simulate no more data after first load
      _hasMoreData = false;
    } catch (e) {
      // Handle error
    }

    setState(() => _isLoadingMore = false);
  }

  void _filterBlogs() {
    List<Map<String, dynamic>> filtered = List.from(_allBlogs);

    // Filter by category
    if (_selectedCategory != "All") {
      filtered = filtered
          .where((blog) => (blog["category"] as String?) == _selectedCategory)
          .toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((blog) {
        final headline = (blog["headline"] as String? ?? "").toLowerCase();
        final excerpt = (blog["excerpt"] as String? ?? "").toLowerCase();
        final category = (blog["category"] as String? ?? "").toLowerCase();
        final query = _searchQuery.toLowerCase();

        return headline.contains(query) ||
            excerpt.contains(query) ||
            category.contains(query);
      }).toList();
    }

    setState(() => _filteredBlogs = filtered);
  }

  void _onCategorySelected(String category) {
    setState(() => _selectedCategory = category);
    _filterBlogs();
  }

  void _onSearchChanged(String query) {
    setState(() => _searchQuery = query);
    _filterBlogs();
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() => _searchQuery = "");
    _filterBlogs();
  }

  Future<void> _onRefresh() async {
    await _loadBlogData();
  }

  void _onBlogTap(Map<String, dynamic> blog) {
    // Navigate to blog detail screen
    Navigator.pushNamed(context, '/blog-detail', arguments: blog);
  }

  void _onBlogLongPress(Map<String, dynamic> blog) {
    _showBlogOptions(blog);
  }

  void _showBlogOptions(Map<String, dynamic> blog) {
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
                color: AppTheme.lightTheme.colorScheme.onSurface,
                size: 24,
              ),
              title: Text(
                "Share Article",
                style: AppTheme.lightTheme.textTheme.bodyLarge,
              ),
              onTap: () {
                Navigator.pop(context);
                _shareArticle(blog);
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'bookmark_border',
                color: AppTheme.lightTheme.colorScheme.onSurface,
                size: 24,
              ),
              title: Text(
                "Save to Favorites",
                style: AppTheme.lightTheme.textTheme.bodyLarge,
              ),
              onTap: () {
                Navigator.pop(context);
                _saveToFavorites(blog);
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  void _shareArticle(Map<String, dynamic> blog) {
    // Implement sharing functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Article shared successfully!"),
        backgroundColor: AppTheme.lightTheme.primaryColor,
      ),
    );
  }

  void _saveToFavorites(Map<String, dynamic> blog) {
    // Implement save to favorites functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Article saved to favorites!"),
        backgroundColor: AppTheme.lightTheme.primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              "Real Estate Blog",
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,

          ),
          body: RefreshIndicator(
            onRefresh: _onRefresh,
            color: AppTheme.lightTheme.primaryColor,
            child: Column(
              children: [
                BlogSearchBar(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  onClear: _clearSearch,
                  onTap: () {},
                  onFilterTap: () {},
                ),
                SizedBox(height: 2.h),
                Container(
                  height: 6.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      return BlogCategoryChip(
                        category: category,
                        isSelected: _selectedCategory == category,
                        onTap: () => _onCategorySelected(category),
                      );
                    },
                  ),
                ),
                SizedBox(height: 1.h),
                Expanded(
                  child: _isLoading
                      ? ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) => BlogSkeletonLoader(),
                        )
                      : _filteredBlogs.isEmpty
                      ? BlogEmptyState(
                          title: _searchQuery.isNotEmpty
                              ? "No articles found"
                              : "No articles available",
                          subtitle: _searchQuery.isNotEmpty
                              ? "Try adjusting your search terms or browse different categories"
                              : "Check back later for new real estate insights and tips",
                          actionText: _searchQuery.isNotEmpty
                              ? "Clear Search"
                              : null,
                          onAction: _searchQuery.isNotEmpty
                              ? _clearSearch
                              : null,
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount:
                              _filteredBlogs.length + (_isLoadingMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index >= _filteredBlogs.length) {
                              return Padding(
                                padding: EdgeInsets.all(4.w),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppTheme.lightTheme.primaryColor,
                                  ),
                                ),
                              );
                            }
                            final blog = _filteredBlogs[index];
                            return BlogCard(
                              blog: blog,
                              onTap: () => _onBlogTap(blog),
                              onLongPress: () => _onBlogLongPress(blog),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SharedBottomNavbar(
            currentIndex: 2,
            onTap: (index) {
              switch (index) {
                case 0:
                  Navigator.pushReplacementNamed(context, AppRoutes.properties);
                  break;
                case 1:
                  Navigator.pushReplacementNamed(context, AppRoutes.webStories);
                  break;
                case 2:
                  // Already on Blog screen
                  break;
                case 3:
                  Navigator.pushReplacementNamed(context, AppRoutes.emiCalculator);
                  break;
              }
            },
          ),
        ),
      ),
    );
  }
}
