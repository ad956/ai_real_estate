import 'package:flutter/material.dart';
import 'floating_whatsapp_button.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget child;
  final bool showWhatsAppButton;

  const ScreenWrapper({
    Key? key,
    required this.child,
    this.showWhatsAppButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (showWhatsAppButton) FloatingWhatsAppButton(),
      ],
    );
  }
}