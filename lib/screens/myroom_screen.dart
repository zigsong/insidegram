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
        child: const Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              'InsideGram',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 80,
                fontFamily: 'Inside-Out',
              ),
            ),
            SizedBox(
              height: 160,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 8),
            //       child: Image(
            //         image: AssetImage('assets/images/joy_simple.png'),
            //         width: 60,
            //       ),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 8),
            //       child: Image(
            //         image: AssetImage('assets/images/annoy_simple.png'),
            //         width: 60,
            //       ),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 8),
            //       child: Image(
            //         image: AssetImage('assets/images/anger_simple.png'),
            //         width: 60,
            //       ),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 8),
            //       child: Image(
            //         image: AssetImage('assets/images/fear_simple.png'),
            //         width: 60,
            //       ),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 8),
            //       child: Image(
            //         image: AssetImage('assets/images/sadness_simple.png'),
            //         width: 60,
            //       ),
            //     ),
            //   ],
            // ),
            Center(
              child: Image(
                image: AssetImage('assets/images/control_panel.png'),
                width: 320,
              ),
            )
          ],
        ),
      ),
    );
  }
}
