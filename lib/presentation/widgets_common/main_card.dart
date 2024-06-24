
import 'package:flutter/material.dart';
import 'package:netflix/core/strings.dart';

import '../../core/constants.dart';

class MainCards extends StatelessWidget {
  String image='https://images-cdn.ubuy.co.in/63ef0a397f1d781bea0a2464-star-wars-rogue-one-movie-poster.jpg';

   MainCards({
    super.key, required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: kRadiusCircular20,
        image:DecorationImage(image: NetworkImage(image)),
      ),
    );
  }
}
