import 'package:chatting_app/constants.dart';
import 'package:flutter/material.dart';

class RecieveChatBubble extends StatelessWidget {
  const RecieveChatBubble({
    super.key,
    required this.message,
  });
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
        margin: const EdgeInsets.only(top: 16),
        decoration: const BoxDecoration(
          color: kSecondryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          
        ),
        child: Text(message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
