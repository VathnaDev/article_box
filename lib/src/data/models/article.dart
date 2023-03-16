import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:reading_time/reading_time.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
abstract class Article with _$Article {
  const Article._(); // ADD THIS LINE

  factory Article({
    required String thumbnail,
    required String title,
    required DateTime publishedDate,
    required String subTitle,
    required List<dynamic> content,
    required String author,
    required List<String> tags,
  }) = _Article;

  String calcualteReadingTime() {
    final wholeArticle = [
      title,
      subTitle,
      content.join(),
    ].join();
    return readingTime(wholeArticle).msg;
  }

  String getPublishDateAndReadTime() {
    return "${Moment(publishedDate).format("MMM DD YYYY").toUpperCase()} | ${calcualteReadingTime()}"
        .toUpperCase();
  }

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}
