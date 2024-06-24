import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../search/widgets/film_title_and_description.dart';
import '../../search/widgets/video_wIdget.dart';
import '../../widgets_common/custom_button_widget.dart';
import '../screen_new_and_hot.dart';

class EveryOnesWatchingWidget extends StatelessWidget {
   EveryOnesWatchingWidget({
    super.key, required this.title, required this.description, required this.image,
  });
  String title,description,image;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        FilmTitleAndDescription(
            title: title, description: description),
        kHeight10,
        VideoWIdget(image:image),
        kHeight10,
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(""),
            Row(
              children: [
                CustomButtonWidgetHome(
                  icon: Icons.share,
                  title: "Send",
                  iconSize: 25,
                  textSize: 15,
                  fontWeight: FontWeight.normal,
                ),
                kWidth10,
                CustomButtonWidgetHome(
                    title: "Add",
                    icon: Icons.add,
                    iconSize: 25,
                    textSize: 15,
                    fontWeight: FontWeight.normal),
                kWidth10,
                CustomButtonWidgetHome(
                    title: "Play",
                    icon: Icons.play_arrow,
                    iconSize: 25,
                    textSize: 15,
                    fontWeight: FontWeight.normal),
                kWidth10,
              ],
            )
          ],
        ),
        kHeight50
      ],
    );
  }
}
