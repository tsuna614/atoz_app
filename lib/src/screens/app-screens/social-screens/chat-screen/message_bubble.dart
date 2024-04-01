import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  final String message;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment:
              isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              left: isCurrentUser ? 50 : 0,
              right: isCurrentUser ? 0 : 50,
            ),
            // padding: EdgeInsets.all(0),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isCurrentUser
                    ? Colors.blue
                    : Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.only(
                  topLeft: isCurrentUser ? Radius.circular(50) : Radius.zero,
                  topRight: isCurrentUser ? Radius.zero : Radius.circular(50),
                  bottomLeft: isCurrentUser ? Radius.circular(50) : Radius.zero,
                  bottomRight:
                      isCurrentUser ? Radius.zero : Radius.circular(50),
                ),
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: isCurrentUser ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
