import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insidegram/screens/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Transform.rotate(
                  angle: -0.25,
                  child: const Image(
                    image: AssetImage('assets/images/joy_simple.png'),
                    width: 80,
                  ),
                ),
              ),
              const SizedBox(width: 60),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Transform.rotate(
                  angle: 0.3,
                  child: const Image(
                    image: AssetImage('assets/images/anger_simple.png'),
                    width: 80,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: loginButton(
                context: context,
                text: '카카오 로그인',
                textColor: Colors.black,
                buttonColor: Colors.yellow,
                svgPath: 'assets/images/kakao.svg',
                width: 20,
                height: 20,
                onPressed: () async {
                  try {
                    await supabase.auth.signInWithOAuth(
                      OAuthProvider.kakao,
                      authScreenLaunchMode: LaunchMode.externalApplication,
                    );
                    supabase.auth.onAuthStateChange.listen((data) {
                      final AuthChangeEvent event = data.event;
                      if (event == AuthChangeEvent.signedIn) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const Homescreen()));
                      }
                    });
                  } on PlatformException catch (err) {
                    print('에러: $err');
                  }
                }),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Transform.rotate(
                  angle: -0.3,
                  child: const Image(
                    image: AssetImage('assets/images/annoy_simple.png'),
                    width: 80,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Image(
                  image: AssetImage('assets/images/fear_simple.png'),
                  width: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Transform.rotate(
                  angle: 0.3,
                  child: const Image(
                    image: AssetImage('assets/images/sadness_simple.png'),
                    width: 80,
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}

Widget loginButton({
  required BuildContext context,
  required String text,
  required VoidCallback onPressed,
  String? svgPath,
  int? width,
  int? height,
  Color? textColor,
  Color? buttonColor,
  BorderSide? side,
}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.8,
    height: MediaQuery.of(context).size.height * 0.06,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        backgroundColor: buttonColor,
        side: side,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Container(
              child: svgPath != null
                  ? SvgPicture.asset(
                      svgPath,
                      width: width?.toDouble(),
                      height: height?.toDouble(),
                    )
                  : Container()),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center, // 텍스트 가운데 정렬
              style: TextStyle(color: textColor),
            ),
          ),
        ],
      ),
    ),
  );
}
