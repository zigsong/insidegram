import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String content;

  const DetailScreen({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      )),
      body: Center(child: Text(content)),
    );
  }
}
