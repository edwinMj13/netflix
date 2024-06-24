import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/infrastructure/api_key.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:http/http.dart' as http;

String downloadsLink='/trending/all/day?api_key=';
String moviesLink='/discover/movie?api_key=';
String tvShowLink="/discover/tv?api_key=";
String searchString='/search/collection?query=';
String andApiKeyEqualto="&api_key=";
String upComingNewHot='/movie/upcoming?api_key=';
String everyonesWatching='/movie/popular?api_key=';
String releasedPastYear='$kBaseUrl/movie/now_playing?api_key=$apiKey';
String top10Shows='$kBaseUrl/tv/top_rated?api_key=$apiKey';
String trendingNow='$kBaseUrl$downloadsLink$apiKey';
String tenseDramas='$kBaseUrl/tv/on_the_air?api_key=$apiKey';
String topActors='$kBaseUrl/person/popular?api_key=$apiKey';

Future<Map<String,dynamic>> loadDownloadScreen() async {
  final response=await http.get(Uri.parse("$kBaseUrl$downloadsLink$apiKey"));
  final toJson=json.decode(response.body);
  final statusCode=response.statusCode;
  if(statusCode==200 || statusCode==201){
    return toJson;
  }else{
    throw Exception(statusCode);
  }
}

Future<List> loadSearchResultsScreen(String query) async {
   final response=await http.get(Uri.parse("$kBaseUrl$searchString$query$andApiKeyEqualto$apiKey"));
   final rs=json.decode(response.body);
 //  print(rs);
   print("rs[\"results\"]${rs["results"]}");
return rs["results"];
}
/*
 searchScreen({String query=""}) async {
   ValueNotifier<List> searchResults=ValueNotifier([]);
  List searchResults=[];
  final response=await http.get(Uri.parse("$kBaseUrl$searchString$query$andApiKeyEqualto$apiKey"));
  final rs=json.decode(response.body);
  searchResults=rs["results"];

  List idleList=[];
  final responseMovies=await http.get(Uri.parse("$kBaseUrl$moviesLink$apiKey"));
  final toJsonMov=jsonDecode(responseMovies.body);
  idleList=toJsonMov["results"];

  if(query==""){
    return idleList;
  }else{
    return searchResults;
  }
}
*/

Future<List> loadSearchIdleScreen() async {
  final responseMovies=await http.get(Uri.parse("$kBaseUrl$moviesLink$apiKey"));
  final toJsonMov=jsonDecode(responseMovies.body);
  print("MoviesTvShow${toJsonMov["results"]}");
return toJsonMov["results"];
}

Future<List> loadVideos()async{
  final response=await http.get(Uri.parse("https://mpf4a0e6a344b2a6d61b.free.beeceptor.com/datadata"));
  final fromJson=json.decode(response.body);
  print(fromJson["results"]);
  return fromJson["results"];
}
Future<List> loadUpComingNewHot()async{
  final response=await http.get(Uri.parse("$kBaseUrl$upComingNewHot$apiKey"));
  final fromJson=json.decode(response.body);
  print(fromJson["results"]);
  return fromJson["results"];
}

Future<List> loadEveryonesWatchingNewHot()async{
  final response=await http.get(Uri.parse("$kBaseUrl$everyonesWatching$apiKey"));
  final fromJson=json.decode(response.body);
  print(fromJson["results"]);
  return fromJson["results"];
}

Future<List> homePageContent(String url)async{
  final response=await http.get(Uri.parse(url));
  final fromJson=json.decode(response.body);
  print(fromJson["results"]);
  return fromJson["results"];
}