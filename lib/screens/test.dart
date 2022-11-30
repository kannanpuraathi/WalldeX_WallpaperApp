import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class test extends StatelessWidget {
  const test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  waveDuration: const Duration(seconds: 2),
                  waveColor: Colors.white,
                  boxBackgroundColor: Colors.black,
                  textStyle: const TextStyle(fontFamily: 'Major',fontSize: 50,fontWeight: FontWeight.normal),
                ),
              ),
            ),

          ),
        ],
      ),
    );
  }
}
