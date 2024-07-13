import 'package:flutter/material.dart';
import 'package:insidegram/widgets/bead_widget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Widget> beadItems = [
    const Bead(
      title: '피크닉',
    ),
    Bead(
      title: '지각',
      color: Colors.red.shade300,
    ),
    Bead(
      title: '바다',
      color: Colors.green.shade300,
    ),
    Bead(
      title: '행복',
      color: Colors.blue.shade300,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Container(
          padding: const EdgeInsets.all(20),
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [...beadItems, ...beadItems, ...beadItems],
          )),
    );
  }
}
