import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:insidegram/models/emotion_comment_model.dart';
import 'package:insidegram/widgets/emotion_comment.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  String inputText = '';
  List<EmotionCommentModel> emotionComments = [];

  final supabase = Supabase.instance.client;
  static const String baseUrl = "http://223.130.159.43:8000";

  Future<dynamic> postNote() async {
    final accessToken = supabase.auth.currentSession?.accessToken;

    if (accessToken == null) {
      return;
    }

    final url = Uri.parse('$baseUrl/diary');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
        body: json.encode({'content': inputText}));

    if (response.statusCode == 200) {
      final result = jsonDecode(utf8.decode(response.bodyBytes));

      for (var comment in result['reaction']) {
        emotionComments.add(EmotionCommentModel.fromJson(comment));
      }

      setState(() {
        inputText = '';
      });

      return;
    }

    throw Error();
  }

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
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: "감정일기를 작성해보세요",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 20)),
                  onChanged: (text) {
                    setState(() {
                      inputText = text;
                    });
                  },
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: emotionComments
                        .map((comment) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: EmotionComment(
                                  emotion: comment.emotion_type,
                                  text: comment.content),
                            ))
                        .toList(),
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 60,
              // )
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
            onPressed: () {
              postNote();
              Navigator.pop(context, 'Ok');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
