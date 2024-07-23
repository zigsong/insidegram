import 'package:flutter/material.dart';
import 'package:insidegram/models/emotion_comment_model.dart';

Map<Emotion, Color> colorMap = {
  Emotion.joy: Colors.yellow.shade100,
  Emotion.sadness: Colors.blue.shade100,
  Emotion.fear: Colors.indigo.shade100,
};

class EmotionComment extends StatelessWidget {
  const EmotionComment({super.key, required this.emotion, required this.text});

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
