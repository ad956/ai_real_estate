import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class WhatsAppContactWidget extends StatelessWidget {
  final Map<String, dynamic> property;

  const WhatsAppContactWidget({Key? key, required this.property})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.shadow,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => _contactViaWhatsApp(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF25D366), // WhatsApp green
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 3.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  elevation: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: 'chat',
                      color: Colors.white,
                      size: 5.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      "Contact via WhatsApp",
                      style: AppTheme.lightTheme.textTheme.titleMedium
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 3.w),
            GestureDetector(
              onTap: () => _callAgent(),
              child: Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.primaryColor,
                  borderRadius: BorderRadius.circular(3.w),
                ),
                child: CustomIconWidget(
                  iconName: 'phone',
                  color: Colors.white,
                  size: 6.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _contactViaWhatsApp() {
    final propertyTitle = property["title"] as String? ?? "Property";
    final propertyPrice = property["price"] as String? ?? "Price not available";
    final propertyLocation =
        property["location"] as String? ?? "Location not available";
    final propertyType =
        property["type"] as String? ?? "Property type not available";

    final message =
        """
Hi! I'm interested in this property:

🏠 *${propertyTitle}*
💰 Price: ${propertyPrice}
📍 Location: ${propertyLocation}
🏢 Type: ${propertyType}

Could you please provide more details and arrange a viewing?

Thank you!
""";

    // In a real app, this would open WhatsApp with the pre-filled message
    // For now, we'll show a toast with the message
    Fluttertoast.showToast(
      msg: "WhatsApp message prepared: ${message.substring(0, 50)}...",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Color(0xFF25D366),
      textColor: Colors.white,
    );
  }

  void _callAgent() {
    // In a real app, this would initiate a phone call
    Fluttertoast.showToast(
      msg: "Calling agent: +91 98765 43210",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.lightTheme.primaryColor,
      textColor: Colors.white,
    );
  }
}
