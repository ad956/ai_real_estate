import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sizer/sizer.dart';

class FloatingWhatsAppButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      right: 20,
      child: FloatingActionButton(
        onPressed: _launchWhatsApp,
        backgroundColor: Color(0xFF25D366),
        child: SvgPicture.asset(
          'assets/images/whatsapp.svg',
          width: 32,
          height: 32,
          color: Colors.white,
        ),
      ),
    );
  }

  void _launchWhatsApp() async {
    const phoneNumber = '+919586363303';
    const message = 'Hi';
    final url = 'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';
    
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }
}