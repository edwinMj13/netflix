import 'package:flutter/material.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/search/widgets/title.dart';

const imageUrl =
    "https://images-cdn.ubuy.co.in/63ef0a397f1d781bea0a2464-star-wars-rogue-one-movie-poster.jpg";

class SearchResultWidget extends StatelessWidget {
   SearchResultWidget({super.key,required this.list});
   List list=[];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTextTitle(title: "Movies & TV"),
        kHeight10,
        Expanded(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1/1.4,
            children: List.generate(list.length, (index) {
             /* print("LIST$list");
              print("image ${list[index]}");*/
              return  MainCard(image:
              list[index]["poster_path"]!=null
                  ?"${list[index]["poster_path"]}"
                  :"/ub7cT4R0IBVx7DRwj0JarHHEc1g.jpg");
            }),
          ),
        )
      ],
    );
  }
}

class MainCard extends StatelessWidget {
   MainCard({super.key,required this.image,});
   String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(image:  DecorationImage(
            fit: BoxFit.cover,
              image: NetworkImage("$kimageStartUrl$image")),
          borderRadius: BorderRadius.circular(5.0)),
    );
  }
}
