import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/downloads/downloads_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/search/widgets/search_idle.dart';
import 'package:netflix/presentation/widgets_common/app_bar_widget.dart';
import 'package:netflix/web_services/api_call_methods.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({super.key});

  List moviesLink = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBarWidget(
              title: "Downloads",
            )),
        body: ListView.separated(
          padding: const EdgeInsets.all(10.0),
            itemBuilder: (ctx,index)=> FutureBuilder(
                future: loadDownloadScreen(),
              builder: (ctx,snap) {
            //      print("SNAAAAAAAAAAAAAPPPPPPPPPPPPPP${snap.data?["results"]}");
                if(snap.connectionState==ConnectionState.waiting) {
                  return const Align(
                    alignment: Alignment.center,
                      child: CircularProgressIndicator());
                }else{
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _SmartDownloads(),
                      Section2(
                        moviesLink: snap.data?["results"]),
                      const Section3(),
                    ],);
                }
              },
            ),
            separatorBuilder: (ctx,index)=>SizedBox(height: 20,),
            itemCount: 1));
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        kWidth10,
        Icon(
          Icons.settings,
          color: kWhiteColors,
        ),
        kWidth10,
        Text("Smart Downloads")
      ],
    );
  }
}

class Section2 extends StatelessWidget {
  List moviesLink;
  Section2({super.key,required this.moviesLink});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
/*    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<DownloadsBloc>(context).add(const DownloadsEvent.getDownloadsImage());
    });*/
  //  print("MOOOOVVVVVVVIIESLIINK$moviesLink");
    return Column(
      children: [
        const Text(
          "Introducing Downloads For You",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: kWhiteColors, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        kHeight10,
        const Text(
          "We will download a personalised section \nof movies and shows for you, so there is \nalways something on your \ndevice.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        SizedBox(
          height: size.width,
          width: size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: size.width * .34,
                  backgroundColor: Colors.grey.withOpacity(0.5),
                ),
              ),
              DownloadsImageWidget(
                moviesLink: "$kimageStartUrl${moviesLink[0]["backdrop_path"]}",
                margin: const EdgeInsets.only(left: 140, bottom: 15),
                angle: 20,
                size: Size(size.width * .38, size.width * .43),
              ),
              DownloadsImageWidget(
                  moviesLink: "$kimageStartUrl${moviesLink[1]["backdrop_path"]}",
                  margin: EdgeInsets.only(right: 140, bottom: 15),
                  angle: -20,
                  size: Size(size.width * .38, size.width * .43)),
              DownloadsImageWidget(
                  moviesLink: "$kimageStartUrl${moviesLink[2]["backdrop_path"]}",
                  margin: EdgeInsets.only(right: 0,top: 20),
                  size: Size(size.width * .38, size.width * .53)),
            ],
          ),
        ),
      ],
    );
  }
}

class Section3 extends StatelessWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            color: kButtonColorBlue,
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Text(
              "Setup",
              style: TextStyle(
                  color: kWhiteColors,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        MaterialButton(
          color: kButtonColorWhite,
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Text(
            "See what you can download",
            style: TextStyle(
                color: kBlackColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget(
      {super.key,
      required this.moviesLink,
      this.angle = 0,
      required this.margin,
      required this.size});

  final String moviesLink;
  final double angle;
  final EdgeInsets margin;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * pi / 180,
      child: Container(
        margin: margin,
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(moviesLink))),
      ),
    );
  }
}
