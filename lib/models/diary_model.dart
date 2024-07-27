import 'package:insidegram/models/emotion_comment_model.dart';

class DiaryModel {
  final int diary_id;
  final String content, created_at;
  final String? memory_content;
  final Emotion? main_emotion;

  DiaryModel(this.diary_id, this.content, this.created_at, this.main_emotion,
      this.memory_content);

  DiaryModel.fromJson(Map<String, dynamic> json)
      : diary_id = json['diary_id'],
        content = json['content'],
        created_at = json['created_at'],
        main_emotion = json['main_emotion'] ?? Emotion.joy,
        memory_content = json['memory_content'];
}
