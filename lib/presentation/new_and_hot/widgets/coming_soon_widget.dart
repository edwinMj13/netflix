import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/presentation/search/widgets/film_title_and_description.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../widgets_common/custom_button_widget.dart';
import '../../search/widgets/video_wIdget.dart';
import '../screen_new_and_hot.dart';

class ComingSoonWidget extends StatelessWidget {
  const ComingSoonWidget({
    super.key, required  this.image, required this.title, required this.date, required this.description, required  this.month,
  });
  final String image,  title,  description,month;
  final int date;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         SizedBox(
          width: 70,
          height: 550,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                month.substring(0,3),
                style: const TextStyle(
                    color: kGreyColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Text(
                date.toString(),
                style: const TextStyle(
                    letterSpacing: 5,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 0.0,
            maxHeight: double.infinity,
          ),
          child: Container(
            width: size.width - 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                VideoWIdget(image: image,),
                kHeight20,
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Coming on Friday"),
                    Spacer(),
                    Row(
                      children: [
                        CustomButtonWidgetHome(
                          title: "Remind Me",
                          icon: Icons.notifications_none,
                          iconSize: 25,
                          textSize: 12,
                          fontWeight: FontWeight.normal,
                          textColor: Colors.grey,
                        ),
                        kWidth20,
                        CustomButtonWidgetHome(
                          title: "Info",
                          icon: Icons.info_outline,
                          iconSize: 25,
                          fontWeight: FontWeight.normal,
                          textSize: 12,
                          textColor: Colors.grey,
                        ),
                      ],
                    ),
                    kWidth20,
                  ],
                ),
                kHeight10,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      fit: BoxFit.cover,
                      "assets/appicon.png",
                      height: 20,
                      width: 25,
                    ),
                    const Text(
                      "FILM",
                      style: TextStyle(color: Colors.blue, fontSize: 13),
                    ),
                  ],
                ),
                 FilmTitleAndDescription(title: title, description: description),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

