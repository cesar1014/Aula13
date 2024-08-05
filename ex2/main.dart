import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final List<String> personagens = [
    'Anakin Skywalker',
    'Luke Skywalker',
    'Darth Maul',
    'Darth Vader',
    'General Grievous'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vetores',
      home: Scaffold(
        body: ListView.builder(
            itemCount: personagens.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(personagens[index]),
              );
            }),
      ),
    );
  }
}
