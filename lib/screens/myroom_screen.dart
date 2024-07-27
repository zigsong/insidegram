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
      backgroundColor: Colors.deepPurple.shade300,
      body: Container(
        padding: const EdgeInsets.only(top: 80, bottom: 120),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              'InsideGram',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 80,
                fontFamily: 'Inside-Out',
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Image(
                    image: AssetImage('assets/images/control_panel.png'),
                    width: 320,
                  ),
                  Positioned(
                    right: -40,
                    bottom: -120,
                    child: Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {}, child: const Text('추억 만나기')),
                        const Image(
                          image: AssetImage('assets/images/memory_grandma.png'),
                          width: 160,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
