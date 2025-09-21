import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void _contactViaWhatsApp() async {
    final propertyTitle = property["title"] as String? ?? "Property";
    final propertyPrice = property["price"] as String? ?? "Price not available";
    final propertyLocation = property["location"] as String? ?? "Location not available";
    final propertyType = property["type"] as String? ?? "Property type not available";

    final message = Uri.encodeComponent(
        "Hi! I'm interested in this property:\n\n🏠 *${propertyTitle}*\n💰 Price: ${propertyPrice}\n📍 Location: ${propertyLocation}\n🏢 Type: ${propertyType}\n\nCould you please provide more details and arrange a viewing?\n\nThank you!");

    final whatsappUrl = "https://api.whatsapp.com/send/?phone=919586363303&text=${message}&type=phone_number&app_absent=0";

    try {
      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(Uri.parse(whatsappUrl), mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch WhatsApp';
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Could not open WhatsApp",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void _callAgent() async {
    final phoneUrl = "tel:+919586363303";

    try {
      if (await canLaunchUrl(Uri.parse(phoneUrl))) {
        await launchUrl(Uri.parse(phoneUrl));
      } else {
        throw 'Could not launch phone dialer';
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Could not make call",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
