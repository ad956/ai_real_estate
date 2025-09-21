import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/custom_image_widget.dart';

class PropertyCard extends StatelessWidget {
  final Map<String, dynamic> property;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const PropertyCard({
    Key? key,
    required this.property,
    required this.onTap,
    this.onLongPress,
  }) : super(key: key);

  Future<void> _shareOnWhatsApp() async {
    final propertyTitle = property['title'] ?? 'Property';
    final propertyPrice = property['price'] ?? 'Price on request';
    final propertyLocation = property['location'] ?? 'Location not specified';
    final propertyType = property['type'] ?? 'Property';

    final message =
        '''
🏠 *${propertyTitle}*

💰 Price: ${propertyPrice}
📍 Location: ${propertyLocation}
🏢 Type: ${propertyType}

I'm interested in this property. Could you please provide more details?

Sent from RealEstate Pro App
''';

    final whatsappUrl = 'https://wa.me/?text=${Uri.encodeComponent(message)}';

    try {
      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(
          Uri.parse(whatsappUrl),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      // Fallback - copy to clipboard
      await Clipboard.setData(ClipboardData(text: message));
    }
  }

  void _showQuickActions(BuildContext context) {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
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
            SizedBox(height: 2.h),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'share',
                color: AppTheme.lightTheme.primaryColor,
                size: 24,
              ),
              title: Text(
                'Share on WhatsApp',
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
              onTap: () {
                Navigator.pop(context);
                _shareOnWhatsApp();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'favorite_border',
                color: AppTheme.lightTheme.primaryColor,
                size: 24,
              ),
              title: Text(
                'Save to Favorites',
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
              onTap: () {
                Navigator.pop(context);
                HapticFeedback.lightImpact();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added to favorites'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        property['image'] ??
        'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400&h=300&fit=crop';
    final title = property['title'] ?? 'Property Title';
    final price = property['price'] ?? '₹0';
    final location = property['location'] ?? 'Location';
    final status = property['status'] ?? 'Available';
    final pinCode = property['pinCode'] ?? '000000';
    final type = property['type'] ?? 'Residential';

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      onLongPress: () => _showQuickActions(context),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppTheme.cardGradientDark,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
            BoxShadow(
              color: AppTheme.primaryDark.withValues(alpha: 0.2),
              blurRadius: 30,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              child: Stack(
                children: [
                  CustomImageWidget(
                    imageUrl: imageUrl,
                    width: double.infinity,
                    height: 25.h,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    height: 25.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.3),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 2.h,
                    right: 3.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 0.8.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: status.toLowerCase() == 'ready to move'
                              ? [Color(0xFF10B981), Color(0xFF059669)]
                              : status.toLowerCase() == 'under construction'
                              ? [Color(0xFFF59E0B), Color(0xFFD97706)]
                              : status.toLowerCase() == 'new launch'
                              ? [Color(0xFF8B5CF6), Color(0xFF7C3AED)]
                              : [AppTheme.accentDark, AppTheme.primaryDark],
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        status,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 2.h,
                    right: 3.w,
                    child: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconWidget(
                            iconName: 'chat',
                            color: Color(0xFF25D366),
                            size: 14,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            'WhatsApp',
                            style: GoogleFonts.inter(
                              color: Color(0xFF25D366),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Property Details
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 1.5.h),

                  // Price and Type Row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          price,
                          style: GoogleFonts.inter(
                            color: Color(0xFFFFD700), // Gold color for price
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 0.5.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          type.length > 15
                              ? type.substring(0, 12) + '...'
                              : type,
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 1.5.h),

                  // Location and Pin Code
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'location_on',
                        color: Colors.white.withValues(alpha: 0.8),
                        size: 16,
                      ),
                      SizedBox(width: 1.w),
                      Expanded(
                        child: Text(
                          location,
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 0.5.h,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withValues(alpha: 0.2),
                              Colors.white.withValues(alpha: 0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          pinCode,
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
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
    );
  }
}
