import 'dart:math';

import 'package:article_box/src/data/models/article.dart';
import 'package:faker/faker.dart';

class FakeArticle {
  static final fakeArticles = List.generate(30, (index) {
    Faker faker = Faker();

    return Article(
      thumbnail: faker.image.image(random: true),
      title: faker.lorem.words(8).join(" "),
      publishedDate: faker.date.dateTime(),
      subTitle: faker.lorem.words(35).join(" "),
      content: faker.lorem.sentences(30).join(" "),
      author: faker.person.name(),
      tags: faker.lorem.words(Random().nextInt(6)),
    );
  });
}
