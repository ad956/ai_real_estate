import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/app_export.dart';

class ModernPropertyCard extends StatelessWidget {
  final Property property;
  final VoidCallback onTap;

  const ModernPropertyCard({
    Key? key,
    required this.property,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
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
            _buildImageSection(),
            _buildContentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      child: Stack(
        children: [
          Container(
            height: 22.h,
            width: double.infinity,
            child: CustomImageWidget(
              imageUrl: property.primaryImage,
              width: double.infinity,
              height: 22.h,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 22.h,
            width: double.infinity,
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
          _buildStatusBadge(),
          _buildFavoriteButton(),
          _buildImageCounter(),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Positioned(
      top: 2.h,
      left: 3.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _getStatusGradient(),
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
          property.status,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Positioned(
      top: 2.h,
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
        child: CustomIconWidget(
          iconName: 'favorite_border',
          color: AppTheme.primaryDark,
          size: 18,
        ),
      ),
    );
  }

  Widget _buildImageCounter() {
    if (property.images.length <= 1) return SizedBox.shrink();
    
    return Positioned(
      bottom: 2.h,
      right: 3.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: 'photo_library',
              color: Colors.white,
              size: 14,
            ),
            SizedBox(width: 1.w),
            Text(
              '${property.images.length}',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: EdgeInsets.all(3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleAndPrice(),
          SizedBox(height: 1.h),
          _buildLocationRow(),
          SizedBox(height: 1.h),
          _buildSpecsRow(),
          SizedBox(height: 1.5.h),
          _buildActionRow(),
        ],
      ),
    );
  }

  Widget _buildTitleAndPrice() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            property.title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 3.5.w,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 2.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              property.formattedPrice,
              style: GoogleFonts.poppins(
                color: Color(0xFFFFD700),
                fontSize: 4.w,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            if (property.festiveOffer == 'yes')
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.orange.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: Text(
                  'OFFER',
                  style: GoogleFonts.poppins(
                    color: Colors.orange,
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationRow() {
    return Row(
      children: [
        CustomIconWidget(
          iconName: 'location_on',
          color: Colors.white.withValues(alpha: 0.8),
          size: 16,
        ),
        SizedBox(width: 1.w),
        Expanded(
          child: Text(
            property.fullLocation,
            style: GoogleFonts.poppins(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 3.w,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
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
            property.pinCode,
            style: GoogleFonts.poppins(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpecsRow() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              if (property.bedrooms.isNotEmpty) ...[
                _buildSpecItem(Icons.bed, '${property.bedrooms}'),
                SizedBox(width: 2.w),
              ],
              if (property.bathrooms.isNotEmpty) ...[
                _buildSpecItem(Icons.bathtub, '${property.bathrooms}'),
                SizedBox(width: 2.w),
              ],
              if (property.areaSqft.isNotEmpty)
                _buildSpecItem(Icons.square_foot, '${property.areaSqft}'),
            ],
          ),
        ),
        SizedBox(width: 2.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 0.5.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Text(
            property.propertyType.length > 8 ? property.propertyType.substring(0, 8) : property.propertyType,
            style: GoogleFonts.poppins(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 8,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpecItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white.withValues(alpha: 0.8),
          size: 16,
        ),
        SizedBox(width: 1.w),
        Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActionRow() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _launchWhatsApp(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1.2.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF25D366), Color(0xFF128C7E)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'chat',
                    color: Colors.white,
                    size: 14,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    'WhatsApp',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 2.w),
        GestureDetector(
          onTap: () => _launchPhoneDialer(),
          child: Container(
            padding: EdgeInsets.all(1.2.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: CustomIconWidget(
              iconName: 'phone',
              color: Colors.white,
              size: 14,
            ),
          ),
        ),
        SizedBox(width: 1.w),
        Container(
          padding: EdgeInsets.all(1.2.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: CustomIconWidget(
            iconName: 'share',
            color: Colors.white,
            size: 14,
          ),
        ),
      ],
    );
  }

  void _launchWhatsApp() async {
    final message = '''🏠 Property Details:

🏷️ Title: ${property.title}
💰 Price: ${property.formattedPrice}
📍 Location: ${property.fullLocation}
📮 Pin Code: ${property.pinCode.isNotEmpty ? property.pinCode : 'N/A'}
🏢 Type: ${property.propertyType}
📊 Status: ${property.status}
📝 Description: ${property.description.isNotEmpty ? property.description : 'N/A'}''';
    
    final url = 'https://wa.me/919586363303?text=${Uri.encodeComponent(message)}';
    
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      Logger.logError('Failed to launch WhatsApp', e);
    }
  }

  void _launchPhoneDialer() async {
    final url = 'tel:+919586363303';
    
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      Logger.logError('Failed to launch phone dialer', e);
    }
  }

  List<Color> _getStatusGradient() {
    switch (property.status.toLowerCase()) {
      case 'ready to move':
        return [Color(0xFF10B981), Color(0xFF059669)];
      case 'under construction':
        return [Color(0xFFF59E0B), Color(0xFFD97706)];
      case 'new launch':
        return [Color(0xFF8B5CF6), Color(0xFF7C3AED)];
      default:
        return [AppTheme.accentDark, AppTheme.primaryDark];
    }
  }
}