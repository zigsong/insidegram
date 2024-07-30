import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insidegram/screens/page_view.dart';
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
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xff6401B5),
              Color(0xff2C004F),
            ])),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                width: 300,
              ),
            ),
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
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const InsidegramPageView()));
                        }
                      });
                    } on PlatformException catch (err) {
                      print('로그인 에러: $err');
                    }
                  }),
            ),
          ],
        )),
      ),
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
