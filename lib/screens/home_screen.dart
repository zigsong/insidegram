import 'package:flutter/material.dart';
import 'package:insidegram/screens/detail_screen.dart';
import 'package:insidegram/screens/note_screen.dart';
import 'package:insidegram/widgets/bead_widget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    List<BeadItem> beadItemsData = [
      BeadItem(title: '피크닉'),
      BeadItem(title: '지각', color: Colors.red.shade300),
      BeadItem(title: '바다', color: Colors.green.shade300),
      BeadItem(title: '행복', color: Colors.blue.shade300),
    ];

    List<Widget> beadItems = beadItemsData.map((item) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            /** NOTE: screen 전환 말고 모달로 띄우면 예쁠듯? */
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                title: item.title,
              ),
            ),
          );
        },
        child: Bead(
          title: item.title,
          color: item.color,
        ),
      );
    }).toList();

    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NoteScreen()));
                  },
                  child: const Bead(title: '+', color: Colors.white)),
              Expanded(
                child: GridView.count(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [...beadItems, ...beadItems]),
              ),
            ],
          )),
    );
  }
}
