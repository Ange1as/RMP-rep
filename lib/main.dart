import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лабораторная работа №1',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Базовый UI'),
      ),
      body: Column(
        children: [
          // Первый Container
          Container(
            width: 200,
            height: 100,
            color: Colors.red,
          ),

          // Row с тремя Text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text('Текст 1'),
              Text('Текст 2'),
              Text('Текст 3'),
            ],
          ),

          // Второй Container
          Container(
            width: 150,
            height: 80,
            color: Colors.green,
          ),

          // Expanded с Row и CircleAvatar
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue,
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    'https://png.pngtree.com/thumb_back/fw800/background/20230617/pngtree-background-artwork-black-and-white-contoured-paper-design-in-3d-rendering-image_3616737.jpg',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Button pressed!');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}