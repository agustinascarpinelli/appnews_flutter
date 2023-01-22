import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class NewsService extends ChangeNotifier {
  String _baseurl = 'newsapi.org';
  String _apiKey = '415547c724fb4d6b9545965ef5ec0aa5';
  String _lng = 'ar';

  List<Article> headlines = [];
  String _selectedCategory='business';
  List<Category_model> categories = [
    Category_model(FontAwesomeIcons.building, 'business'),
    Category_model(FontAwesomeIcons.tv, 'entertainment'),
    Category_model(FontAwesomeIcons.headSideVirus, 'health'),
    Category_model(FontAwesomeIcons.football, 'sports'),
    Category_model(FontAwesomeIcons.vials, 'science'),
    Category_model(FontAwesomeIcons.memory, 'technology'),
    Category_model(FontAwesomeIcons.addressCard, 'general'),
  ];

  Map<String,List<Article>>categoryArticles={};
  bool _isLoading=true;



  NewsService() {
    getTopHeadlines();
    categories.forEach((item) {
      categoryArticles[item.name]=[];
     });
  }


String get selectedCategory{
  return _selectedCategory;
  }

bool get isLoading {
  return _isLoading;
}

set selectedCategory(String category){
_selectedCategory=category;
_isLoading=true;
getArticlesByCategory(category);
  notifyListeners();
}



  Future<String> getData(String category) async {
    final endpoint = '/v2/top-headlines';
    final url = Uri.https(_baseurl, endpoint, {
      'apiKey': _apiKey,
      'country': _lng,
      'category':category
    });

    final response = await http.get(url);

    return response.body;
  }

  getTopHeadlines() async {
    final data = await getData('');
    final newsResponse = newsResponseFromJson(data);
    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }


  getArticlesByCategory(String category)async{
    if(categoryArticles[category]!.length>0){
      _isLoading = false;
      return categoryArticles[category];
    }

    final data=await getData(category);
    final newsResponse=newsResponseFromJson(data);
    categoryArticles[category]!.addAll(newsResponse.articles);
    _isLoading = false;
    notifyListeners();

  }

 List<Article>? get selectedCategoryArticle=> this.categoryArticles[this.selectedCategory];

  
}
