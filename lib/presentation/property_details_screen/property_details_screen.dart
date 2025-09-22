import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_export.dart';
import './widgets/property_image_gallery_widget.dart';
import './widgets/property_info_widget.dart';
import './widgets/recommended_properties_widget.dart';

class PropertyDetailsScreen extends StatefulWidget {
  const PropertyDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarVisible = false;
  Property? property;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (property == null) {
      property = ModalRoute.of(context)?.settings.arguments as Property?;
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final shouldShowAppBar = _scrollController.offset > 25.h;
    if (shouldShowAppBar != _isAppBarVisible) {
      setState(() {
        _isAppBarVisible = shouldShowAppBar;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: PropertyImageGalleryWidget(
                    images: property?.fullImageUrls ?? [],
                    videoUrl: property?.videos.isNotEmpty == true ? property!.videos.first : null,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: PropertyInfoWidget(property: property),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 3.h)),
                SliverToBoxAdapter(child: RecommendedPropertiesWidget()),
                SliverToBoxAdapter(
                  child: SizedBox(height: 10.h), // Space for bottom bar
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryDark,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 3.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              'Book Now',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }



  void _shareProperty() {
    // Share property functionality
  }

  void _saveProperty() {
    // Save property functionality
  }


}
