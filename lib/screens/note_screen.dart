import 'package:flutter/material.dart';
import 'package:insidegram/widgets/emotion_comment.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      backgroundColor: Colors.grey.shade50,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const EmotionComment(
                  emotion: Emotion.joy,
                  text: '좋은 사람들과의 피크닉은 언제나 우리를 즐겁게 하지! 너무 즐거웠겠다!'),
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16),
                    padding: const EdgeInsets.all(0)),
                onPressed: () => showConfirmDialog(context),
                child: const Text('완료'),
              ),
              Container(
                height: 300,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                      color: Colors.black.withOpacity(0.1),
                    )
                  ],
                ),
                child: const TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: "감정일기를 작성해보세요",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 20)),
                ),
              ),
              Container(
                height: 24,
                width: 24,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                      color: Colors.black.withOpacity(0.1),
                    )
                  ],
                ),
              ),
              const EmotionComment(
                  emotion: Emotion.fear, text: '호수에 빠지고 그러진 않았겠지? 언제나 조심해야해'),
              const SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> showConfirmDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('일기 등록'),
        content: const Text('완료 후에는 수정이 불가합니다.\n정말 완료하시겠습니까?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Ok'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
