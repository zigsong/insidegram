import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:insidegram/models/diary_detail_model.dart';
import 'package:insidegram/screens/note_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  final String content;
  final int diary_id;

  const DetailScreen({
    super.key,
    required this.diary_id,
    required this.content,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final supabase = Supabase.instance.client;

  static const String baseUrl = "http://223.130.159.43:8000";
  late Future<DiaryDetailModel?> _diary;

  @override
  void initState() {
    super.initState();
    _diary = fetchDiary();
  }

  Future<DiaryDetailModel?> fetchDiary() async {
    final accessToken = supabase.auth.currentSession?.accessToken;

    if (accessToken == null) {
      return null;
    }

    final url = Uri.parse('$baseUrl/diary/${widget.diary_id}');
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

      return DiaryDetailModel.fromJson(result);
    }

    throw Error();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xff54336F),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context, 'Refetch');
            },
          )),
      backgroundColor: const Color(0xff54336F),
      body: FutureBuilder(
        future: _diary,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 300,
                  padding: const EdgeInsets.all(24),
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
                  child: Text(snapshot.data!.content),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        EmotionComments(
                            emotionComments: snapshot.data!.reaction),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
