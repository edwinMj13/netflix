import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/new_and_hot/widgets/everyones_watching_widget.dart';
import 'package:netflix/presentation/widgets_common/custom_button_widget.dart';
import 'package:netflix/presentation/new_and_hot/widgets/coming_soon_widget.dart';
import 'package:netflix/presentation/search/widgets/film_title_and_description.dart';
import 'package:netflix/presentation/search/widgets/video_wIdget.dart';
import 'package:netflix/web_services/api_call_methods.dart';

import '../../core/constants.dart';

const newandHotTempImageComing =
    "https://media.themoviedb.org/t/p/w355_and_h200_multi_faces/xtAQ7j9Yd0j4Rjbvx1hW0ENpXjf.jpg";
const newandHotTempImageEveryones =
    'https://rukminim2.flixcart.com/image/850/1000/l1tmf0w0/poster/k/7/t/small-poster-friends-tv-series-wall-poster-300-gsm-matte-paper-original-imagdazf3zfun2x2.jpeg?q=90&crop=false';
const filmDetailsComingSoon =
    "Landing the led in the school musical is a dream come "
    "true for Jodi, untill the pressure sends her "
    "confidence -- and her relationship -- into a tailspin";
const filmDetailsEveryonesWatching =
    "This hit sitcon follows the merry misadventures of six 20-something pals as they navigate the pitfalls of work, life and love in 1990's Manhattan";
final List<String> months = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December'
];
class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(90),
            child: AppBar(
              title: const Text(
                "New & Hot",
                style: TextStyle(
                    fontSize: 30,
                    color: kWhiteColors,
                    fontWeight: FontWeight.w900),
              ),
              actions: <Widget>[
                const Icon(
                  Icons.cast,
                  color: Colors.white,
                  size: 30,
                ),
                kWidth10,
                Container(
                  width: 30,
                  height: 30,
                  color: Colors.blue,
                ),
                kWidth10,
              ],
              bottom: TabBar(
                padding: EdgeInsets.only(bottom: 10.0),
                labelColor: kBlackColor,
                unselectedLabelColor: kWhiteColors,
                isScrollable: true,
                dividerColor: Colors.transparent,
                tabAlignment: TabAlignment.start,
                labelStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                indicator: BoxDecoration(
                    color: kWhiteColors, borderRadius: kRadiusCircular30),
                tabs: const [
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15),
                      child: Text("🍿 Coming soon"),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 15),
                      child: Text("👀 Everyone's Watching"),
                    ),
                  ),
                ],
              ),
            )),
        body: TabBarView(children: [
          _buildComingSoon(),
          _buildEveryonesWatching(),
        ]),
      ),
    );
  }

  _buildEveryonesWatching() {
    return FutureBuilder(
      future: loadEveryonesWatchingNewHot(),
      builder:(ctx,snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(strokeWidth: 2,));
        } else {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return  EveryOnesWatchingWidget(title:snap.data![index]["title"],
                description:snap.data![index]["overview"],
                image:"$kimageStartUrl${snap.data![index]["backdrop_path"]}",);
            },
            itemCount: snap.data?.length,
          );
        }
      }
    );
  }

  _buildComingSoon() {
    return FutureBuilder(
      future: loadUpComingNewHot(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              String dateString = snap.data![index]["release_date"];
              DateFormat format=DateFormat('yyyy-MM-dd');
              DateTime dateTime = format.parse(dateString);

              int dayString=dateTime.day;
              String monthString=months[dateTime.month-1];
              String pre=monthString.substring(0,3);
              print("DateTimeDateTime$pre");
              return ComingSoonWidget(
                image: "$kimageStartUrl${snap.data![index]["backdrop_path"]}",
                title: "${snap.data![index]["title"]}",
                date: dayString,
                month: monthString,
                description: "${snap.data![index]["overview"]}",
              );
            },
            itemCount: snap.data?.length,
          );
        }
      },
    );
  }
}
