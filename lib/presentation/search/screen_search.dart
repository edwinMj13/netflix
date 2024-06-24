import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/search/widgets/search_idle.dart';
import 'package:netflix/presentation/search/widgets/search_result.dart';
import 'package:netflix/web_services/api_call_methods.dart';

class ScreenSearch extends StatefulWidget {
  ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  final cuperController = TextEditingController();
  bool verifyValue=false;
  List resultsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoSearchTextField(
              controller: cuperController,
              prefixIcon: const Icon(
                CupertinoIcons.search,
                color: Colors.grey,
              ),
              suffixIcon: const Icon(
                CupertinoIcons.xmark_circle_fill,
                color: Colors.grey,
              ),
              style: const TextStyle(color: Colors.white),
              backgroundColor: Colors.grey.withOpacity(0.4),
              onChanged: (text) async {
                dynamic listDyn = await loadSearchResultsScreen(text);
                print(" ${cuperController.text} LISTDYN$listDyn");
                setState(() {
                  resultsList = listDyn;
                  verifyValue=true;
                });
                if(text.isEmpty){
                  verifyValue=false;
                }
                print("ResultsList$resultsList");
              },
            ),
            kHeight10,
            // Expanded(child: const SearchIdleWidget()),
            Expanded(
                child: verifyValue==false
                    ? FutureBuilder(
                        future: loadSearchIdleScreen(),
                        builder: (context, snapshot) {
                               print("SNAPSHOTIDLESEARCH${snapshot.data}");
                          if(snapshot.connectionState==ConnectionState.waiting){
                            return Center(child: CircularProgressIndicator());
                          }else{
                            return SearchIdleWidget(list: snapshot.data!);
                          }
                        })
                    : SearchResultWidget(
                        list: resultsList,
                      ))
          ],
        ),
      )),
    );
  }
}
