import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/search/widgets/title.dart';

const moviesList =
    "https://resize.indiatvnews.com/en/centered/newbucket/1200_675/2021/12/2022-films-1640873820.jpg";

class SearchIdleWidget extends StatelessWidget {
  List list;

  SearchIdleWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTextTitle(title: "Top Searches",),
        kHeight10,
        Expanded(
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return TopSearchItemTile(name: list[index]["original_title"],
                    image: list[index]["poster_path"] != null
                ?"${list[index]["poster_path"]}"
                        :"/ub7cT4R0IBVx7DRwj0JarHHEc1g.jpg");
              },
              separatorBuilder: (ctx, index) {
                return kHeight20;
              },
              itemCount: list.length),
        )
      ],
    );
  }
}

class TopSearchItemTile extends StatelessWidget {
  TopSearchItemTile({super.key, required this.name, required this.image});

  final String name;
  final image;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Row(
      children: [
        Container(
          width: screenWidth * 0.35,
          height: 80,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(
                  "$kimageStartUrl$image"))),
        ),
        Expanded(child: Text(name, style: TextStyle(color: kWhiteColors,
            fontWeight: FontWeight.bold,
            fontSize: 16),)),
        const CircleAvatar(
          backgroundColor: kWhiteColors,
          radius: 25,
          child: CircleAvatar(
            backgroundColor: kBlackColor,
            radius: 23,
            child: Icon(Icons.play_arrow, color: kWhiteColors,),
          ),
        )

      ],
    );
  }
}
