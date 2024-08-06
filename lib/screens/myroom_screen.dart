import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:insidegram/models/emotion_comment_model.dart';
import 'package:insidegram/screens/login_screen.dart';
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

  static const String baseUrl = "http://insidegram.n-e.kr";
  late Future<Emotion> _main_emotion;
  late Future<String> _memoryText;

  @override
  void initState() {
    super.initState();
    _main_emotion = fetchMainEmotion();
    _memoryText = fetchMemory();
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

  Future<String> fetchMemory() async {
    final accessToken = supabase.auth.currentSession?.accessToken;

    if (accessToken == null) {
      return '';
    }

    final url = Uri.parse('$baseUrl/memory');
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

      return result['memory_content'];
    }

    throw Error();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff54336F),
      body: Stack(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  try {
                    supabase.auth.signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                  } catch (err) {
                    print('로그아웃 에러: $err');
                  }
                },
              ),
            ],
          ),
          Center(
              child: FutureBuilder(
            future: _main_emotion,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return Transform.translate(
                  offset: const Offset(0, 64),
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
                              color: Colors.white, fontWeight: FontWeight.w600),
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
          )),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Image(
                  image: AssetImage('assets/images/control_panel.png'),
                ),
                Container(
                  decoration: const BoxDecoration(color: Color(0xfff0f0f0)),
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Image(
                              image:
                                  AssetImage('assets/images/myroom_door.png'),
                              // width: 320,
                            ),
                          ),
                          const Positioned(
                            left: 0,
                            bottom: 0,
                            child: Image(
                              image: AssetImage(
                                  'assets/images/memory_grandma.png'),
                              width: 180,
                            ),
                          ),
                          const Positioned(
                            right: 0,
                            bottom: 0,
                            child: Image(
                              image:
                                  AssetImage('assets/images/memory_book.png'),
                              width: 220,
                            ),
                          ),
                          Positioned.fill(
                              child: Align(
                            alignment: Alignment.center,
                            child: FutureBuilder(
                              future: _memoryText,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasData) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _memoryText = fetchMemory();
                                      });
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                                child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20,
                                                        vertical: 28),
                                                    child: Wrap(
                                                      children: [
                                                        const Text(
                                                            '2023년 3월 3일에 작성한 일기\n'),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Text(snapshot.data!),
                                                      ],
                                                    )));
                                          });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.black,
                                        backgroundColor:
                                            const Color(0xffE3D6D7),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 12)),
                                    child: const Text(
                                        '홍홍홍.. 옛날에 이런일이 있었다지.\n추억을 한 번 보겠니? 📮'),
                                  );
                                } else {
                                  return const Center();
                                }
                              },
                            ),
                          )),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
