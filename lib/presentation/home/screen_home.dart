import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/widgets_common/custom_button_widget.dart';
import 'package:netflix/presentation/home/widgets/home_background_card.dart';
import 'package:netflix/presentation/home/widgets/number_card.dart';
import 'package:netflix/presentation/search/widgets/search_result.dart';
import 'package:netflix/presentation/widgets_common/main_card.dart';
import 'package:netflix/presentation/widgets_common/main_title.dart';
import 'package:netflix/web_services/api_call_methods.dart';

import '../search/widgets/main_card.dart';

const imgHome =
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTO8hOou-MjWJQTrPor8Ht8doeSTT_ppjtANg&s";
const imgMainHome =
    'https://i.ebayimg.com/images/g/zSsAAOSwejtjv4RH/s-l960.jpg';
ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(5.0),
      child: ValueListenableBuilder(
          valueListenable: scrollNotifier,
          builder: (ctx, index, _) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                final ScrollDirection direction = notification.direction;
                print(direction);
                if (direction == ScrollDirection.reverse) {
                  scrollNotifier.value = false;
                } else if (direction == ScrollDirection.forward) {
                  scrollNotifier.value = true;
                }
                return true;
              },
              child: Stack(
                children: [
                  ListView(
                    children:  [
                      HomeBackgroundCard(),
                       MainTitleCard(
                        title: "Released in the past year", url: releasedPastYear, type: 'poster_path',
                      ),
                      kHeight10,
                      MainTitleCard(
                        title: 'Trending Now', url: trendingNow, type: 'poster_path',
                      ),
                      kHeight10,
                      TopTenCard(
                        title: "Top 10 Tv Shows In India Today",
                        url:top10Shows,
                        type: 'poster_path',
                      ),
                      kHeight10,
                      MainTitleCard(
                        title: 'Tense Dramas', url: tenseDramas,
                        type:"poster_path",
                      ),
                      kHeight10,
                      MainTitleCard(
                        title: 'Top Actors',
                        url:topActors,
                          type:"profile_path",
                      ),
                    ],
                  ),
                  scrollNotifier.value == true
                      ? AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                          height: 100,
                          width: double.infinity,
                          color: Colors.black.withOpacity(0.2),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/appicon.png",
                                    height: 70,
                                    width: 70,
                                  ),
                                  const Spacer(),
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
                                  kWidth10
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Tv Shows",
                                    style: kHomeMainCardTextStyle,
                                  ),
                                  Text("Movies", style: kHomeMainCardTextStyle),
                                  Text("Categories",
                                      style: kHomeMainCardTextStyle),
                                ],
                              )
                            ],
                          ),
                        )
                      : kHeight10,
                ],
              ),
            );
          }),
    ));
  }
}

class TopTenCard extends StatelessWidget {
  final String title,type,url;

   TopTenCard({super.key, required this.title, required this.type, required this.url});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: homePageContent(url),
      builder:(ctx,snap){
        if(snap.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }else{
         return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainTitle(title: title),
              LimitedBox(
                maxHeight: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    String rank = (index + 1).toString();
                    return NumberCard(
                      index: rank,
                      url:"$kimageStartUrl${snap.data?[index]["poster_path"]}"
                    );
                  },
                  itemCount: 10,
                ),
              ),
            ],
          );
        }
      } ,
    );
  }
}
