
import 'package:news_app/Models/categories_news_model.dart';
import 'package:news_app/Models/news_channel_healines_model.dart';
import 'package:news_app/News_Repositry/News_repositry.dart';

class NewsViewModel{

  final _rep =NewsRepositry();

  Future<NewschanelsHeadlinesModel> fetchNewschannelheadlinesApi(String channelName) async{
    final response = await _rep.fetchNewschannelheadlinesApi(channelName);
    return response;
  }

  Future<CtegoriesNewsModel> fetchcategoriesNewsApi(String categorey) async{
    final response = await _rep.fetchcategoriesNewsApi(categorey);
    return response;
  }
}