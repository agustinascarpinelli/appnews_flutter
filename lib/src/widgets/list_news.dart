import 'package:flutter/material.dart';
import 'package:news_app/src/models/models.dart';
import 'package:news_app/src/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ListNews extends StatelessWidget {
  final List<Article> news;
  const ListNews({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (BuildContext context, int index) {
        return _New(index: index, article: news[index]);
      },
    );
  }
}

class _New extends StatelessWidget {
  final Article article;
  final int index;
  const _New({super.key, required this.index, required this.article});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBar(
          article: article,
          index: index,
        ),
        _NewTitle(
          article: article,
        ),
        _NewImage(article: article),
        _NewBody(
          article: article,
        ),
         _Buttons(article: article),
        const SizedBox(
          height: 10,
        ),
        const Divider()
      ],
    );
  }
}

class _Buttons extends StatelessWidget {
  final Article article;
  const _Buttons({
    Key? key, required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RawMaterialButton(
          onPressed: () {},
          fillColor: myTheme.primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          constraints: const BoxConstraints(maxWidth: 30, maxHeight: 30),
          child: const Center(child: Icon(Icons.star_border)),
        ),
        RawMaterialButton(
          onPressed: ()async {
            final Uri uri=Uri.parse(article.url);
               if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    AlertDialog(title: Text('Cannot launch url ${article.url}'));
                  }
          },
          fillColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          constraints: const BoxConstraints(maxWidth: 30, maxHeight: 30),
          child: const Center(
              child: Text(
            '+',
            style: TextStyle(fontSize: 20),
          )),
        )
      ],
    );
  }
}

class _NewBody extends StatelessWidget {
  final Article article;
  const _NewBody({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text((article.description != null) ? article.description! : ''),
    );
  }
}

class _NewImage extends StatelessWidget {
  final Article article;
  const _NewImage({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
            child: article.urlToImage != null
                ? FadeInImage(
                    image: NetworkImage(article.urlToImage!),
                    placeholder: const AssetImage('assets/giphy.gif'),
                  )
                : const Image(image: AssetImage('assets/no-image.png'))),
      ),
    );
  }
}

class _NewTitle extends StatelessWidget {
  final Article article;
  const _NewTitle({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        article.title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final Article article;
  final int index;
  const _TopBar({
    Key? key,
    required this.article,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Text(
          '${index + 1}.',
          style: TextStyle(color: myTheme.primaryColor),
        ),
        Text(article.source.name)
      ]),
    );
  }
}
