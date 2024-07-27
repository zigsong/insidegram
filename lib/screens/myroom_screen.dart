import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:insidegram/models/emotion_comment_model.dart';
import 'package:insidegram/widgets/emotion_comment.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

class MyroomScreen extends StatefulWidget {
  const MyroomScreen({super.key});

  @override
  State<MyroomScreen> createState() => _MyroomScreenState();
}

class _MyroomScreenState extends State<MyroomScreen> {
  final supabase = Supabase.instance.client;

  static const String baseUrl = "http://223.130.159.43:8000";
  late Future<Emotion> _main_emotion;

  @override
  void initState() {
    super.initState();
    _main_emotion = fetchMainEmotion();
  }

  Emotion _emotionFromString(String emotion) {
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

  Future<Emotion> fetchMainEmotion() async {
    final accessToken = supabase.auth.currentSession?.accessToken;

    if (accessToken == null) {
      return Emotion.joy;
    }

    final url = Uri.parse('$baseUrl/main_emotion');
    final response = await http.get(
      url,
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json',
        'Authorization': accessToken,
      },
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(utf8.decode(response.bodyBytes));

      return _emotionFromString(result['main_emotion']);
    }

    throw Error();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff54336F),
      body: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 300,
              child: Center(
                child: FutureBuilder(
                  future: _main_emotion,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      return Transform.translate(
                        offset: const Offset(0, 56),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: colorMap[snapshot.data!]),
                              child: Text(
                                messageMap[snapshot.data!] ?? '',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Image(
                              image: AssetImage(imageMap[snapshot.data!] ?? ''),
                              width: 240,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: Text('No data'));
                    }
                  },
                ),
              ),
            ),
            const Image(
              image: AssetImage('assets/images/control_panel.png'),
            ),
            Container(
              decoration: const BoxDecoration(color: Color(0xfff0f0f0)),
              child: const Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Image(
                      image: AssetImage('assets/images/myroom_door.png'),
                      // width: 320,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Image(
                      image: AssetImage('assets/images/memory_grandma.png'),
                      width: 200,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image(
                      image: AssetImage('assets/images/memory_book.png'),
                      width: 200,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
