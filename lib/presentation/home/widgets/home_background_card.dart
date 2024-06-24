import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../screen_home.dart';
import '../../widgets_common/custom_button_widget.dart';

class HomeBackgroundCard extends StatelessWidget {
  const HomeBackgroundCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: size.height * 0.75,
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(imgMainHome)),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CustomButtonWidgetHome(
                  title: 'My List',
                  icon: Icons.add,
                ),
                _playButtonHome(),
                const CustomButtonWidgetHome(
                    title: "Info", icon: Icons.info)
              ],
            ),
          ),
        )
      ],
    );
  }
}
TextButton _playButtonHome() {
  return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: kWhiteColors,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      onPressed: () {},
      icon: const Icon(
        Icons.play_arrow,
        size: 25,
        color: kBlackColor,
      ),
      label: const Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Text(
          "Play",
          style: TextStyle(color: kBlackColor,fontWeight: FontWeight.bold,fontSize: 18),
        ),
      ));
}
