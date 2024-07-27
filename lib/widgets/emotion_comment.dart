import 'package:flutter/material.dart';
import 'package:insidegram/models/emotion_comment_model.dart';

Map<Emotion, Color> colorMap = {
  Emotion.joy: Colors.amber,
  Emotion.sadness: Colors.blue,
  Emotion.fear: Colors.indigo,
  Emotion.anxiety: Colors.orange,
  Emotion.anger: Colors.red,
};

Map<Emotion, String> imageMap = {
  Emotion.joy: 'assets/images/joy_comment.png',
  Emotion.sadness: 'assets/images/sadness_comment.png',
  Emotion.fear: 'assets/images/fear_comment.png',
  Emotion.anxiety: 'assets/images/anxiety_comment.png',
  Emotion.anger: 'assets/images/anger_comment.png',
};

class EmotionComment extends StatelessWidget {
  const EmotionComment({super.key, required this.emotion, required this.text});

  final Emotion emotion;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            color: colorMap[emotion],
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                offset: const Offset(2, 2),
                color: Colors.black.withOpacity(0.1),
              )
            ],
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          left: -20,
          bottom: -20,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: Colors.white),
            padding: const EdgeInsets.all(6),
            child: SizedBox(
              width: 40,
              height: 40,
              child: Image(
                image: AssetImage(imageMap[emotion] ?? ''),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
