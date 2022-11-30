import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final IconData icoon;
  final Color bgcolor;
  final Color iconcolor;

  const RoundButton(
      {Key? key,
        required this.icoon,
        required this.bgcolor,
        required this.iconcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Icon(
          icoon,
          size: 30,
          color: iconcolor,
        ),
      ),
    );
  }
}