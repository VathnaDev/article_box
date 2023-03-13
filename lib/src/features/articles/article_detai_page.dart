import 'package:article_box/src/data/models/article.dart';
import 'package:article_box/src/ext/theme_shortcut.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleDetailPage extends StatefulWidget {
  ArticleDetailPage({
    super.key,
    required this.article,
  });

  Article article;

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  @override
  Widget build(BuildContext context) {
    final article = widget.article;

    return Scaffold(
      appBar: AppBar(
        title: Text("Article Box"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 3 / 2,
              child: Hero(
                tag: article.thumbnail,
                child: Image.network(
                  article.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    article.title,
                    style: context.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: article.tags
                          .map(
                            (e) => Container(
                              margin: const EdgeInsets.only(
                                right: 8,
                              ),
                              child: OutlinedButton(
                                onPressed: () {},
                                clipBehavior: Clip.hardEdge,
                                child: Text(
                                  "#${e}",
                                  style:
                                      context.textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    article.getPublishDateAndReadTime(),
                    style: context.labelLarge
                        ?.copyWith(fontStyle: FontStyle.italic),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Author: ${article.author}",
                    style: context.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(),
                  Text(
                    article.content,
                    style: context.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
