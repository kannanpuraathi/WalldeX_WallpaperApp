import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'home_screen.dart';
import 'onboard_screen.dart';

class SplashScreen extends StatelessWidget {
  int? initScreen;
  SplashScreen({Key? key,required this.initScreen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: SizedBox(
                child: Center(
                  child: TextLiquidFill(
                    text: 'WalldeX',
                    waveDuration: const Duration(seconds: 3),
                    waveColor: Colors.white,
                    boxBackgroundColor: Colors.black,
                    textStyle: const TextStyle(fontFamily: 'Major',fontSize: 50,fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      nextScreen: initScreen != null?const HomeScreen() : const OnBoard(),
      duration: 5000,
      splashIconSize: 250,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
      animationDuration: Duration(seconds: 1),
      curve: Curves.easeInCirc,
    );
  }
}