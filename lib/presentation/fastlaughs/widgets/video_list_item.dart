import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class VideoListItem extends StatefulWidget {
  String videoUrl;
  String name;
  String image;

  VideoListItem(
      {super.key,
      required this.videoUrl,
      required this.name,
      required this.image});

  @override
  State<VideoListItem> createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  late VideoPlayerController videoPlayerController;

// List videoUrl;
//   _VideoListItemState(this.videoUrl);
  @override
  void initState() {
    // TODO: implement initState
    print("VIDEOURL ${widget.videoUrl}");
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    videoPlayerController.initialize().then((value) => {
          setState(() {
            videoPlayerController.play();
            videoPlayerController.setVolume(1.0);
          })
        });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: videoPlayerController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(videoPlayerController))
              : const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left Side
                CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.volume_off,
                          color: kWhiteColors,
                          size: 30,
                        ))),
                // RightSide
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://resize.indiatvnews.com/en/centered/newbucket/1200_675/2021/12/2022-films-1640873820.jpg"),
                      ),
                    ),
                    const VideoActionsWidget(
                        icon: Icons.emoji_emotions, title: 'LOL'),
                    const VideoActionsWidget(icon: Icons.add, title: 'My List'),
                    GestureDetector(
                        onTap: () async {
                          final videoName = widget.videoUrl;
                          if(videoName.isNotEmpty){
                            await Share.share(videoName);
                          }

                        },
                        child: const VideoActionsWidget(
                            icon: Icons.share, title: 'Share')),
                    InkWell(
                      onTap: (){
                        Duration duration=Duration(seconds: videoPlayerController.value.duration.inSeconds);
                        if(videoPlayerController.value.isPlaying){
                          videoPlayerController.pause();
                          // final pos=videoPlayerController.value.duration.inSeconds;
                          // duration=Duration(seconds: pos);
                        }else{
                          // videoPlayerController.seekTo(Duration(seconds: duration.inSeconds.toInt()));
                          videoPlayerController.play();
                        }
                        print("videoPlayerController.toString() ${videoPlayerController.value.isPlaying}");
                        setState(() {

                        });
                      },
                        child: videoPlayerController.value.isPlaying
                            ? VideoActionsWidget(
                                icon: Icons.pause, title: 'Pause')
                            : VideoActionsWidget(
                                icon: Icons.play_arrow, title: 'Play'))
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class VideoActionsWidget extends StatelessWidget {
  final IconData icon;
  final String title;

  const VideoActionsWidget(
      {super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
          Text(
            title,
            style: TextStyle(color: kWhiteColors, fontSize: 16),
          )
        ],
      ),
    );
  }
}
