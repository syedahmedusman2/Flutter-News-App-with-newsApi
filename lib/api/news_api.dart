import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/key/key.dart';
import 'package:newsapp/screens/dropdown.dart';
import 'package:newsapp/screens/homepage.dart';
Future<List<NewsApiModel>> getNews(link)async{
  Uri uri = Uri.parse(
    // 'https://newsapi.org/v2/everything?q=keyword&apiKey=$key2'
    // 'https://newsapi.org/v2/everything?q=keyword&sortBy=$sortoption&apiKey=$key2'
    // 'https://newsapi.org/v2/top-headlines?category=business&language=en&apiKey=f507c969eaee41ffb23d10668b679090'
    // 'https://newsapi.org/v2/everything?country=us&apiKey=f507c969eaee41ffb23d10668b679090'
    // 'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=f507c969eaee41ffb23d10668b679090'
    // 'http://api.mediastack.com/v2/news?access_key=$key2'
    // http://api.mediastack.com/v2/news?access_key=f507c969eaee41ffb23d10668b679090
    // 'https://newsapi.org/v2/top-headlines?country=us&country=pk&apiKey=f507c969eaee41ffb23d10668b679090'
    // 'https://newsapi.org/v2/top-headlines?category=business&language=en&apiKey=f507c969eaee41ffb23d10668b679090'
    // 'https://newsapi.org/v2/top-headlines?category=general&apiKey=f507c969eaee41ffb23d10668b679090'
    link
    
  );
  final response = await http.get(uri);
  if(response.statusCode == 200 || response.statusCode ==201){
    // print(response.body);
    Map<String, dynamic> map = jsonDecode(response.body);
    List _articalsList = map['articles'];

    List<NewsApiModel> newsList = _articalsList.map(
    (jsonData)=> NewsApiModel.fromJson(jsonData)).toList();
    return newsList;
  }else{
    print("error");
    return [];
  }
}