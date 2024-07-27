enum Emotion { joy, sadness, anxiety, fear, anger }

class EmotionCommentModel {
  final Emotion emotion_type;
  final String content;

  EmotionCommentModel(this.emotion_type, this.content);

  EmotionCommentModel.fromJson(Map<String, dynamic> json)
      : emotion_type = _emotionFromString(json['emotion_type']),
        content = json['content'];

  static Emotion _emotionFromString(String emotion) {
    switch (emotion) {
      case 'joy':
        return Emotion.joy;
      case 'sadness':
        return Emotion.sadness;
      case 'anxiety':
        return Emotion.anxiety;
      default:
        throw Exception('Unknown emotion type');
    }
  }
}
