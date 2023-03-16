import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class NewArticlePage extends StatefulWidget {
  const NewArticlePage({super.key});

  @override
  State<NewArticlePage> createState() => _NewArticlePageState();
}

class _NewArticlePageState extends State<NewArticlePage> {
  String thumbnail = "";
  String title = "";
  String subTitle = "";
  List<dynamic> content = [];

  quill.QuillController _controller = quill.QuillController.basic();

  void onSaved({bool isPublish = false}) {
    var json = jsonEncode(_controller.document.toDelta().toJson());
    print(json);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: const Text("Confirmation"),
                content: const Text("Do you want to exit without saving?"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text("No")),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text("Yes"),
                  ),
                ],
              );
            },
          );
        },
        child: Scaffold(
          appBar: AppBar(title: Text(title.isEmpty ? "Title" : title)),
          body: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  child: AspectRatio(
                    aspectRatio: 1 / 0.5,
                    child: Image.network(
                      Faker().image.image(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 16),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            title = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Title",
                          isDense: true,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        maxLines: 3,
                        maxLength: 100,
                        decoration: InputDecoration(
                          labelText: "Short Description",
                          isDense: true,
                          filled: true,
                          alignLabelWithHint: true,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Divider(),
                ExpansionTile(
                  title: Text("Content"),
                  children: [
                    quill.QuillToolbar.basic(
                      controller: _controller,
                    ),
                    const Divider(),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      padding: const EdgeInsets.all(16),
                      child: quill.QuillEditor.basic(
                        controller: _controller,
                        readOnly: false, // true for view only mode
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    top: 16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            onSaved(isPublish: false);
                          },
                          child: const Text("Draft"),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            onSaved(isPublish: true);
                          },
                          child: const Text("Publish 🚀"),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
