import 'package:flutter/material.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/search/widgets/search_result.dart';
import 'package:netflix/web_services/api_call_methods.dart';

import '../../widgets_common/main_card.dart';
import '../../widgets_common/main_title.dart';

class MainTitleCard extends StatelessWidget {
  final String title;
  final String type;
  final String url;
    const MainTitleCard({
    super.key,
    required this.title,
    required this.url, required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: homePageContent(url),
      builder:(ctx,snap){
        String data="";
        if(snap.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(strokeWidth: 2,));
        }else{
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainTitle(title: title),
                LimitedBox(
                  maxHeight: 200,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      //    print("snap.data![index][\"profile_path\"]${snap.data![index][type]}");
                      if(snap.data!=null) {
                         data = snap.data![index][type];
                      }
                      return MainCards(image: data.isNotEmpty
                          ? "$kimageStartUrl${snap.data![index][type]}"
                          : '$kimageStartUrl/2zmTngn1tYC1AvfnrFLhxeD82hz.jpg');
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                    itemCount: 10,
                  ),
                ),
              ],
            );
          }
        }
      ,
    );
  }
}
