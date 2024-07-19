import 'package:flutter/material.dart';

enum Emotion { joy, fear }

Map<Emotion, Color> colorMap = {
  Emotion.joy: Colors.yellow.shade100,
  Emotion.fear: Colors.indigo.shade100,
};

class EmotionComment extends StatelessWidget {
  const EmotionComment({super.key, required this.emotion, required this.text});

  // NOTE: 감정들 enum으로 바꾸기
  final Emotion emotion;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colorMap[emotion],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(2, 2),
            color: Colors.black.withOpacity(0.1),
          )
        ],
      ),
      child: Text(text),
    );
  }
}
