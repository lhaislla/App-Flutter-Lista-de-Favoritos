import 'package:flutter/material.dart';
import 'edit.dart';
import 'list.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerador de palavras',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      initialRoute: '/',
      routes: {
        RandomWords.routeName: (context) => const RandomWords(),
        Editar.routeName: (context) => const Editar()
      },
    );
  }
}
