import 'package:article_box/src/data/fake_articles.dart';
import 'package:article_box/src/ext/theme_shortcut.dart';
import 'package:article_box/src/features/articles/article_detai_page.dart';
import 'package:article_box/src/util/material_colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  bool isTabVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Article Box"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          )
        ],
      ),
      drawer: Drawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: () {}, child: Text("Featured")),
                OutlinedButton(onPressed: () {}, child: Text("Articles")),
                OutlinedButton(onPressed: () {}, child: Text("Videos")),
                OutlinedButton(onPressed: () {}, child: Text("Tips")),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {},
              child: NotificationListener<UserScrollNotification>(
                onNotification: (UserScrollNotification notification) {
                  final isScrollDown =
                      notification.direction == ScrollDirection.forward;
                  if (isScrollDown != isTabVisible) {
                    setState(() {
                      isTabVisible = isScrollDown;
                    });
                  }
                  return true;
                },
                child: ListView(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    top: 8,
                  ),
                  children: [
                    ...FakeArticle.fakeArticles.map(
                      (article) => ArticleListItem(
                        title: article.title,
                        subTitle: article.getPublishDateAndReadTime(),
                        content: article.subTitle,
                        tags: article.tags,
                        thumbnail: article.thumbnail,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ArticleDetailPage(
                                article: article,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ArticleListItem extends StatelessWidget {
  ArticleListItem({
    super.key,
    this.thumbnail = "",
    this.title = "",
    this.subTitle = "",
    this.content = "",
    this.tags = const [],
    this.onTap,
  });

  String thumbnail;
  String title;
  String subTitle;
  String content;
  List<String> tags;
  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Theme.of(context).cardColor,
        elevation: 4,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () {
            onTap?.call();
          },
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1 / 0.5,
                child: Hero(
                  tag: thumbnail,
                  child: Image.network(
                    thumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(height: 8),
                    Text(
                      subTitle,
                      style: context.labelMedium,
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      children: tags
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
                    SizedBox(height: 8),
                    Text(
                      content,
                      style: context.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
