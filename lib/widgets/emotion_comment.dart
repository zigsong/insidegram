import 'package:flutter/material.dart';
import 'package:insidegram/models/emotion_comment_model.dart';

Map<Emotion, Color> colorMap = {
  Emotion.joy: Colors.amber,
  Emotion.sadness: const Color(0xff194CCC),
  Emotion.fear: Colors.indigo,
  Emotion.anxiety: const Color(0xffFF8229),
  Emotion.anger: const Color(0xffD22B2A),
};

Map<Emotion, String> imageMap = {
  Emotion.joy: 'assets/images/joy_comment.png',
  Emotion.sadness: 'assets/images/sadness_comment.png',
  Emotion.fear: 'assets/images/fear_comment.png',
  Emotion.anxiety: 'assets/images/anxiety_comment.png',
  Emotion.anger: 'assets/images/anger_comment.png',
};

Map<Emotion, String> messageMap = {
  Emotion.joy: '인생은 정말 너무 재미있어!',
  Emotion.sadness: '너무 슬퍼서 아무것도 할 수 없어',
  Emotion.fear: '이불 밖은 위험해!',
  Emotion.anxiety: '다음엔 어떻게 해야하지?',
  Emotion.anger: '으아아아, 정말 왜그러는거야!',
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
