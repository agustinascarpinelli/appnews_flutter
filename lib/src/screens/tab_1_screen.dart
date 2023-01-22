import 'package:flutter/material.dart';
import 'package:news_app/src/services/services.dart';
import 'package:news_app/src/theme/theme.dart';
import 'package:provider/provider.dart';

import '../widgets/list_news.dart';

class Tab1Screen extends StatefulWidget {
  const Tab1Screen({Key? key}) : super(key: key);

  @override
  State<Tab1Screen> createState() => _Tab1ScreenState();
}
//Mantiene el estado del scroll
class _Tab1ScreenState extends State<Tab1Screen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
        body: newsService.headlines.isEmpty
            ? Center(
                child: CircularProgressIndicator(color: myTheme.primaryColor),
              )
            : ListNews(news: newsService.headlines));
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
