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
      BeadItem(title: '1. 핔닠'),
      BeadItem(title: '2. 지각', color: Colors.red.shade300),
      BeadItem(title: '3. 바다', color: Colors.green.shade300),
      BeadItem(title: '4. 행복', color: Colors.blue.shade300),
      BeadItem(title: '5. 핔닠'),
      BeadItem(title: '6. 지각', color: Colors.red.shade300),
      BeadItem(title: '7. 바다', color: Colors.green.shade300),
      BeadItem(title: '8. 행복', color: Colors.blue.shade300),
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

    const int columnCount = 3; // 열의 수
    final int rowCount = (beadItems.length / columnCount).ceil(); // 행의 수

    final List<List<Widget>> transformedData = [];
    for (int i = 0; i < columnCount; i++) {
      List<Widget> columnData = [];
      for (int j = 0; j < rowCount; j++) {
        if ((i * columnCount + j) < beadItems.length) {
          columnData.add(beadItems[(i * columnCount) + j]);
        }
      }
      if (i % 2 == 1) {
        columnData = columnData.reversed.toList();
      }
      transformedData.add(columnData);
    }

    final List<Widget> finalData = [];
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < columnCount; j++) {
        if (i < transformedData.length && j < transformedData[i].length) {
          finalData.add(transformedData[i][j]);
        }
      }
    }

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
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NoteScreen()));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Bead(title: '+', color: Colors.white),
                  )),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.grey.shade300,
                  child: GridView.count(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: finalData),
                ),
              ),
            ],
          )),
    );
  }
}
