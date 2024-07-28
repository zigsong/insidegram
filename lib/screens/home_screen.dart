import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:insidegram/models/diary_model.dart';
import 'package:insidegram/screens/detail_screen.dart';
import 'package:insidegram/screens/note_screen.dart';
import 'package:insidegram/widgets/bead_widget.dart';
import 'package:insidegram/widgets/emotion_comment.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final supabase = Supabase.instance.client;

  static const String baseUrl = "http://223.130.159.43:8000";
  late Future<List<DiaryModel>> _diaries;
  final List<DiaryModel> _diariesData = [];

  @override
  void initState() {
    super.initState();
    _diaries = fetchDiaries();
  }

  Future<List<DiaryModel>> fetchDiaries() async {
    final accessToken = supabase.auth.currentSession?.accessToken;

    if (accessToken == null) {
      return [];
    }

    final url = Uri.parse('$baseUrl/diary');
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

      for (var diary in result) {
        _diariesData.add(DiaryModel.fromJson(diary));
      }
      return _diariesData;
    }

    throw Error();
  }

  List<Widget> convertDiairiesIntoBeads(List<DiaryModel> data) {
    final List<Widget> result = [];

    for (var diary in data) {
      result.add(GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            /** NOTE: screen 전환 말고 모달로 띄우면 예쁠듯? */
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                diary_id: diary.diary_id,
                content: diary.content,
              ),
            ),
          );
        },
        child: Bead(
          color: colorMap[diary.main_emotion],
          created_at: diary.created_at,
        ),
      ));
    }

    const int columnCount = 3; // 열의 수
    const int rowCount = 5;

    final List<List<Widget>> transformedData = [];
    for (int i = 0; i < rowCount; i++) {
      List<Widget> rowData = [];
      for (int j = 0; j < columnCount; j++) {
        if ((i * columnCount + j) < result.length) {
          rowData.add(result[(i * columnCount) + j]);
        }
      }
      if (i % 2 == 1) {
        rowData = rowData.reversed.toList();
      }
      transformedData.add(rowData);
    }

    final List<Widget> finalItems = [];
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < columnCount; j++) {
        if (i < transformedData.length && j < transformedData[i].length) {
          finalItems.add(transformedData[i][j]);
        }
      }
    }

    return finalItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const NoteScreen()))
                            .then((val) {
                          if (val == 'Refetch') {
                            fetchDiaries();
                          }
                        });
                      },
                      child: const Bead(
                        content: '+',
                        color: Colors.white,
                      ),
                    ),
                    const Image(
                      image: AssetImage('assets/images/controller.png'),
                      width: 180,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/pipe_bg.png'))),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FutureBuilder(
                    future: _diaries,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        return GridView.count(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 12,
                            children: convertDiairiesIntoBeads(snapshot.data!));
                      } else {
                        return const Center(child: Text('No data'));
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 48,
              ),
            ],
          )),
    );
  }
}
