import 'package:flutter/material.dart';
import 'package:news_app/src/screens/tabs_screen.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService()),

        //Lazy por defecto esta en true, la instancia del provider se crea cuando se la necesita. Si lo ponemos en false,apenas se crea ell widget AppState, se manda a llamar, la inicializacion del provider
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: const TabsScreen(),
      theme: myTheme,
    );
  }
}
