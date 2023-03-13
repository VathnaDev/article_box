import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moment_dart/moment_dart.dart';

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
    required String content,
    required String author,
    required List<String> tags,
  }) = _Article;

  String getPublishDateAndReadTime() {
    return "${Moment(publishedDate).format("MMM DD YYYY").toUpperCase()} | 5 MIN TO READ";
  }

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}
