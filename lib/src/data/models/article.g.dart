// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Article _$$_ArticleFromJson(Map<String, dynamic> json) => _$_Article(
      thumbnail: json['thumbnail'] as String,
      title: json['title'] as String,
      publishedDate: DateTime.parse(json['publishedDate'] as String),
      subTitle: json['subTitle'] as String,
      content: json['content'] as List<dynamic>,
      author: json['author'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_ArticleToJson(_$_Article instance) =>
    <String, dynamic>{
      'thumbnail': instance.thumbnail,
      'title': instance.title,
      'publishedDate': instance.publishedDate.toIso8601String(),
      'subTitle': instance.subTitle,
      'content': instance.content,
      'author': instance.author,
      'tags': instance.tags,
    };
