
import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:news_app/Models/categories_news_model.dart';
import 'package:news_app/Models/news_channel_healines_model.dart';
class NewsRepositry{

Future<NewschanelsHeadlinesModel> fetchNewschannelheadlinesApi(String channelName) async{
  String url = 'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=418e1f3e4c5e4decbb00b253edae757a';

  final response = await http.get(Uri.parse(url));
  print(response.body);

  if(response.statusCode == 200){
    final  body = jsonDecode(response.body);
    return NewschanelsHeadlinesModel.fromJson(body);
  }
  throw Exception('Error');
}


Future<CtegoriesNewsModel> fetchcategoriesNewsApi( String categorey) async{
  String url = 'https://newsapi.org/v2/everything?q=${categorey}&apiKey=418e1f3e4c5e4decbb00b253edae757a';

  final response = await http.get(Uri.parse(url));
  print(response.body);

  if(response.statusCode == 200){
    final  body = jsonDecode(response.body);
    return CtegoriesNewsModel.fromJson(body);
  }
  throw Exception('Error');
}

}