import 'dart:async';

import 'package:flutter/material.dart';
import 'package:netflix/presentation/fastlaughs/widgets/video_list_item.dart';
import 'package:netflix/web_services/api_call_methods.dart';

class ScreenFastLaughs extends StatelessWidget {
  ScreenFastLaughs({super.key});

  @override
  build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: loadVideos(),
        builder: (ctx, snap) {
          if(snap.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(strokeWidth: 2,));
          }else{
            return PageView(
              scrollDirection: Axis.vertical,
              children: List.generate(snap.data!.length, (index) {
                print("snap.data![index] ${snap.data![index]}");
                return VideoListItem(
                  videoUrl: snap.data![index]["video"],
                  name: snap.data![index]["name"],
                  image: snap.data![index]["image"],
                );
              }),
            );
          }
        },
      )),
    );
  }
}
