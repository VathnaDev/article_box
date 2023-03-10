import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExampleScreen(),
    );
  }
}
