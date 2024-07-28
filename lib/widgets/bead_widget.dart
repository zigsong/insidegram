import 'package:flutter/material.dart';

class Bead extends StatelessWidget {
  const Bead({super.key, this.content, this.color, this.created_at});

  final String? content;
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
        gradient: RadialGradient(
          colors: [
            Colors.white,
            color ?? Colors.yellow.shade300,
          ],
        ),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(2, 2),
            color: Colors.black.withOpacity(0.1),
          )
        ],
      ),
      child: Builder(
        builder: (context) {
          if (content != null) {
            return const Center(
                child: Image(
              image: AssetImage('assets/images/add.png'),
              width: 16,
            ));
          } else {
            return const Text('');
          }
        },
      ),
    );
  }
}
