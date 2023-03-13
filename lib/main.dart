import 'dart:io';

import 'package:article_box/src/features/articles/articles_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/di/network_module.dart';
import 'src/example_screen.dart';
import 'src/util/pref_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefUtils.instance.initialize();

  // DI
  final app = MultiRepositoryProvider(
    providers: [
      ...networkProviders,
    ],
    child: const MyApp(),
  );

  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPrint(Platform.environment.toString());
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.dark),
      home: ArticlesPage(),
    );
  }

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(
      primarySwatch: Colors.blue,
      brightness: brightness,
      useMaterial3: true,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.montserratTextTheme(
        baseTheme.textTheme,
      ),
    );
  }
}
