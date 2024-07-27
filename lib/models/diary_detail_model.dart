import 'package:insidegram/models/emotion_comment_model.dart';

class DiaryDetailModel {
  final int diary_id;
  final String user_id, content;
  final String? memory_content, created_at;
  final Emotion? main_emotion;
  final List<EmotionCommentModel> reaction;

  DiaryDetailModel(this.diary_id, this.user_id, this.content, this.created_at,
      this.main_emotion, this.memory_content, this.reaction);

  DiaryDetailModel.fromJson(Map<String, dynamic> json)
      : diary_id = json['diary_id'],
        user_id = json['user_id'],
        content = json['content'],
        created_at = json['created_at'],
        main_emotion = _emotionFromString(json['main_emotion']),
        memory_content = json['memory_content'],
        reaction = _commentsFromReaction(json['reaction']);

  static Emotion _emotionFromString(String emotion) {
    switch (emotion) {
      case 'joy':
        return Emotion.joy;
      case 'sadness':
        return Emotion.sadness;
      case 'anxiety':
        return Emotion.anxiety;
      case 'anger':
        return Emotion.anger;
      default:
        throw Exception('Unknown emotion type');
    }
  }

  static _commentsFromReaction(dynamic reaction) {
    final List<EmotionCommentModel> result = [];
    for (var comment in reaction) {
      result.add(EmotionCommentModel.fromJson(comment));
    }
    return result;
  }
}
