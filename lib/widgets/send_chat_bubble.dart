import 'package:chatting_app/constants.dart';
import 'package:flutter/material.dart';

class SendChatBubble extends StatelessWidget {
  const SendChatBubble({
    super.key,
    required this.message,
    required this.time,
  });
  final String message;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        margin: const EdgeInsets.only(top: 8, right: 80),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kAccentColor,
              kSecondryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(16),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(4),
          ),
        ),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.bottom,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    time,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.65),
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
