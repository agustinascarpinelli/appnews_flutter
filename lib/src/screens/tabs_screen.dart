import 'package:flutter/material.dart';
import 'package:news_app/src/screens/screens.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: const Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Context es un objeto que tiene la informacion de toda la estructura de nuestro arbol de widgets
    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
        selectedItemColor: Colors.deepOrange,
        onTap: (value) {
          navigationModel.actualPage = value;
        },
        currentIndex: navigationModel.actualPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.waving_hand), label: 'For you'),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Headers'),
        ]);
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);
    final newsService = Provider.of<NewsService>(context);
    return PageView(
      controller: navigationModel.pageController,
      //inhabilita la fisica del scroll
      physics: const NeverScrollableScrollPhysics(),
      children: const [Tab1Screen(), Tab2Screen()],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _actualPage = 0;
  final PageController _pageController = PageController();

  int get actualPage => _actualPage;
  set actualPage(int value) {
    _actualPage = value;
    //curves es la animacion
    _pageController.animateToPage(value,
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController {
    return _pageController;
  }
}
