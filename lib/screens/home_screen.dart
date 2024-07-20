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
      BeadItem(
        title: '9. 핔닠',
      ),
      BeadItem(title: '10. 지각', color: Colors.red.shade300),
      BeadItem(title: '11. 바다', color: Colors.green.shade300),
      BeadItem(title: '12. 행복', color: Colors.blue.shade300),
      BeadItem(
        title: '13. 핔닠',
      ),
      BeadItem(title: '14. 지각', color: Colors.red.shade300),
      BeadItem(title: '15. 바다', color: Colors.green.shade300),
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
    const int rowCount = 5;

    final List<List<Widget>> transformedData = [];
    for (int i = 0; i < rowCount; i++) {
      List<Widget> rowData = [];
      for (int j = 0; j < columnCount; j++) {
        if ((i * columnCount + j) < beadItems.length) {
          rowData.add(beadItems[(i * columnCount) + j]);
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
                                builder: (context) => const NoteScreen()));
                      },
                      child: const Bead(title: '+', color: Colors.white),
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
                  child: GridView.count(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 24,
                      children: finalItems),
                ),
              ),
            ],
          )),
    );
  }
}
