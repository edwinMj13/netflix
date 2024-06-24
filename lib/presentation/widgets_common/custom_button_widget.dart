import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';

class CustomButtonWidgetHome extends StatelessWidget {
  const CustomButtonWidgetHome({
    super.key,
    required this.title,
    required this.icon,
    this.iconSize=30,
    this.textSize=18,
    this.fontWeight=FontWeight.bold,
    this.textColor=Colors.white,
  });
  final String title;
  final IconData icon;
  final double iconSize;
  final double textSize;
  final FontWeight fontWeight;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon,size: iconSize,color: kWhiteColors,),
        Text(
          title,
          style: TextStyle(
              fontSize: textSize,
              color: textColor, fontWeight: fontWeight),
        )
      ],
    );
  }
}
