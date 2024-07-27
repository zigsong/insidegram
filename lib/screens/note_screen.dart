import 'dart:async';
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

  Future<List<EmotionCommentModel>>? _emotionComments;
  final List<EmotionCommentModel> _emotionCommentsData = [];

  final supabase = Supabase.instance.client;
  static const String baseUrl = "http://223.130.159.43:8000";

  Future<List<EmotionCommentModel>> postNote() async {
    final accessToken = supabase.auth.currentSession?.accessToken;

    if (accessToken == null) {
      return [];
    }

    final url = Uri.parse('$baseUrl/diary');
    final response = await http.post(url,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
        body: json.encode({'content': inputText}));

    if (response.statusCode == 200) {
      final result = jsonDecode(utf8.decode(response.bodyBytes));

      print(result);
      for (var comment in result['reaction']) {
        _emotionCommentsData.add(EmotionCommentModel.fromJson(comment));
      }

      setState(() {
        inputText = '';
      });

      return _emotionCommentsData;
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
        margin: const EdgeInsets.only(bottom: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
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
            if (_emotionComments == null)
              ElevatedButton(
                onPressed: () => showConfirmDialog(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo.shade300,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                child: const Text('완료'),
              ),
            if (_emotionComments != null)
              FutureBuilder(
                future: _emotionComments,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    return Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          EmotionComments(emotionComments: snapshot.data!),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: Text('No data'));
                  }
                },
              ),
            // const SizedBox(
            //   height: 60,
            // )
          ],
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
              setState(() {
                _emotionComments = postNote();
              });
              Navigator.pop(context, 'Ok');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class EmotionComments extends StatelessWidget {
  const EmotionComments({
    super.key,
    required this.emotionComments,
  });

  final List<EmotionCommentModel> emotionComments;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: emotionComments
            .map((comment) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: EmotionComment(
                  emotion: comment.emotion_type,
                  text: comment.content,
                )))
            .toList(),
      ),
    );
  }
}
