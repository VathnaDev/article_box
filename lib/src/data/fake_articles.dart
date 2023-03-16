import 'dart:math';

import 'package:article_box/src/data/models/article.dart';
import 'package:faker/faker.dart';

class FakeArticle {
  static final quillBody = [
    {"insert": "Should we write providers by hand?"},
    {
      "insert": "\n",
      "attributes": {"header": 1}
    },
    {"insert": "\nShould we write providers by hand?"},
    {
      "insert": "\n\n",
      "attributes": {"header": 2}
    },
    {
      "insert": "Should we write providers by hand?",
      "attributes": {"background": "#f44336"}
    },
    {
      "insert": "\n",
      "attributes": {"blockquote": true}
    },
    {"insert": "\n"},
    {
      "insert": "Should we write providers by hand?",
      "attributes": {"background": "#f44336"}
    },
    {
      "insert": "\n",
      "attributes": {"blockquote": true}
    },
    {"insert": "\n"},
    {
      "insert": "Should we write providers by hand?",
      "attributes": {"background": "#f44336"}
    },
    {
      "insert": "\n",
      "attributes": {"blockquote": true}
    },
    {"insert": "\n"}
  ];

  static final fakeArticles = List.generate(30, (index) {
    Faker faker = Faker();

    return Article(
      thumbnail: faker.image.image(random: true),
      title: faker.lorem.words(8).join(" "),
      publishedDate: faker.date.dateTime(),
      subTitle: faker.lorem.words(35).join(" "),
      content: quillBody,
      author: faker.person.name(),
      tags: faker.lorem.words(Random().nextInt(6)),
    );
  });
}
