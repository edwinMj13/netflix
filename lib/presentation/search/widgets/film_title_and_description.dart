import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../new_and_hot/screen_new_and_hot.dart';

class FilmTitleAndDescription extends StatelessWidget {
  const FilmTitleAndDescription({super.key,
  required this.title,
  required this.description});
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    print(title);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.abel().fontFamily),
        ),
         Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: Text(
            description,
            style: TextStyle(color: kGreyColor),
          ),
        ),
      ],),
    );
  }
}
