import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_export.dart';

class PropertyTypeSelector extends StatelessWidget {
  final String type;
  final bool isSelected;
  final VoidCallback onTap;

  const PropertyTypeSelector({
    Key? key,
    required this.type,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'house':
        return Icons.home;
      case 'villa':
        return Icons.villa;
      case 'apartment':
        return Icons.apartment;
      case 'bungalow':
        return Icons.house_siding;
      default:
        return Icons.home;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 18.w,
        padding: EdgeInsets.symmetric(vertical: 2.h),
        decoration: BoxDecoration(
          color: isSelected 
            ? AppTheme.primaryDark 
            : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected 
              ? AppTheme.primaryDark 
              : Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              _getIconForType(type),
              color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.8),
              size: 6.w,
            ),
            SizedBox(height: 1.h),
            Text(
              type,
              style: GoogleFonts.poppins(
                color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.8),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}