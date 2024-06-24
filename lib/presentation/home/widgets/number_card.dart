import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stroke_text/stroke_text.dart';

import '../../../core/constants.dart';
import '../screen_home.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({super.key,required this.index, required this.url});
  final String index,url;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            SizedBox(
              width: 40,
            ),
            Container(
              width: 150,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: kRadiusCircular20,
                image:DecorationImage(
                  fit: BoxFit.cover,
                    image: NetworkImage(url)),
              ),
            ),
          ],
        ),
        Positioned( left: 15,bottom: -15,
            child: StrokeText(
              text: index,
              textStyle: TextStyle(
                color: Colors.black,fontWeight: FontWeight.bold,
                  fontSize: 100),
              strokeColor:Colors.white,
                strokeWidth: 5,
            )),
      ],
    );
  }
}
