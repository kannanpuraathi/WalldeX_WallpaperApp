import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        height: 150,
        width: 300,
        alignment: Alignment.centerLeft,
        child: Text(
          'WalldeX',
          style: GoogleFonts.majorMonoDisplay(
              fontSize: 40, fontWeight: FontWeight.normal,color: Theme.of(context).primaryColor),
        ));
  }
}