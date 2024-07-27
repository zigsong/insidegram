import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Bead extends StatelessWidget {
  const Bead({super.key, required this.content, this.color, this.created_at});

  final String content;
  final Color? color;
  final String? created_at;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 118,
      height: 118,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color ?? Colors.yellow.shade300,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(2, 2),
            color: Colors.black.withOpacity(0.1),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            created_at != null
                ? DateFormat('MMdd').format(DateTime.parse(created_at ?? ''))
                : content,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
