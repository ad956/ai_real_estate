import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_export.dart';
import 'modern_property_card.dart';

class CategorySection extends StatelessWidget {
  final CategoryProperty category;
  final Function(Property) onPropertyTap;

  const CategorySection({
    Key? key,
    required this.category,
    required this.onPropertyTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Text(
            category.categoryName,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          height: 45.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 4.w),
            itemCount: category.properties.length,
            itemBuilder: (context, index) {
              final property = category.properties[index];
              return Container(
                width: 75.w,
                margin: EdgeInsets.only(right: 3.w),
                child: ModernPropertyCard(
                  property: property,
                  onTap: () => onPropertyTap(property),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}