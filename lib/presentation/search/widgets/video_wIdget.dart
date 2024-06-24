import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';

class VideoWIdget extends StatelessWidget {
  const VideoWIdget({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.network(
            image,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 10,
          bottom: 0,
          child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.black.withOpacity(0.5),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.volume_off,
                    color: kWhiteColors,
                    size: 25,
                  ))),
        ),
      ],
    );
  }
}
