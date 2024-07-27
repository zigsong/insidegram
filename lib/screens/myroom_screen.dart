import 'package:flutter/material.dart';

class MyroomScreen extends StatefulWidget {
  const MyroomScreen({super.key});

  @override
  State<MyroomScreen> createState() => _MyroomScreenState();
}

class _MyroomScreenState extends State<MyroomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff54336F),
      body: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const SizedBox(
              height: 300,
              child: Center(
                child: Text(
                  '감정이 들어갈 자리',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const Image(
              image: AssetImage('assets/images/control_panel.png'),
            ),
            Container(
              decoration: const BoxDecoration(color: Color(0xfff0f0f0)),
              child: const Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Image(
                      image: AssetImage('assets/images/myroom_door.png'),
                      // width: 320,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Image(
                      image: AssetImage('assets/images/memory_grandma.png'),
                      width: 200,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image(
                      image: AssetImage('assets/images/memory_book.png'),
                      width: 200,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
