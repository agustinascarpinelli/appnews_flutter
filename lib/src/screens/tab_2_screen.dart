import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_models.dart';
import 'package:news_app/src/theme/theme.dart';
import 'package:news_app/src/widgets/list_news.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';

class Tab2Screen extends StatelessWidget {
  const Tab2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const _CategoriesList(),
            !newsService.isLoading
                ? Expanded(
                    child: ListNews(
                    news: newsService.selectedCategoryArticle!,
                  ))
                : Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                            color: myTheme.primaryColor)))
          ],
        ),
      ),
    );
  }
}

class _CategoriesList extends StatelessWidget {
  const _CategoriesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final cName = categories[index].name;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryButton(
                  category: categories[index],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('${cName[0].toUpperCase()}${cName.substring(1)}')
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category_model category;
  const _CategoryButton({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categorySel = Provider.of<NewsService>(context).selectedCategory;
    return GestureDetector(
        onTap: () {
          final newsService = Provider.of<NewsService>(context, listen: false);
          newsService.selectedCategory = category.name;
        },
        child: Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Icon(
            category.icon,
            color: categorySel == category.name
                ? myTheme.primaryColor
                : Colors.black54,
          ),
        ));
  }
}
