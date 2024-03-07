import 'package:flutter/material.dart';

import 'src/Pages/zpages.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData.dark(),
      initialRoute: 'home',
      routes: {
        'home': (_) => HomePage(),
      },
    );
  }
}
