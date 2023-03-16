import 'dart:convert';

import 'package:article_box/src/data/models/article.dart';
import 'package:article_box/src/ext/theme_shortcut.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:google_fonts/google_fonts.dart';

import '../../data/fake_articles.dart';
import 'articles_page.dart';

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
  late quill.QuillController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = quill.QuillController(
      document: quill.Document.fromJson(widget.article.content),
      selection: const TextSelection.collapsed(offset: -1),
    );
  }

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
              padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    article.title.toUpperCase(),
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
                  quill.QuillEditor(
                    controller: _controller,
                    scrollable: false,
                    scrollController: ScrollController(),
                    focusNode: FocusNode(),
                    autoFocus: true,
                    enableInteractiveSelection: false,
                    enableSelectionToolbar: false,
                    readOnly: true,
                    expands: false,
                    // **showCursor: controller.isEditEnabled,**
                    padding: EdgeInsets.zero,
                  ),
                  SizedBox(height: 28),
                  Text(
                    "Related Articles",
                    style: context.titleLarge,
                  ),
                  Divider(),
                  SizedBox(height: 8),
                ],
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.only(right: 16),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...FakeArticle.fakeArticles.map(
                    (article) => Container(
                      margin: const EdgeInsets.only(left: 16),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ArticleListItem(
                        title: article.title,
                        subTitle: article.getPublishDateAndReadTime(),
                        content: article.subTitle.substring(0, 50) + " ...",
                        tags: [],
                        thumbnail: article.thumbnail,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (_) => ArticleDetailPage(
                                article: article,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
