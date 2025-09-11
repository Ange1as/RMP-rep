import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.grey[200], // фон серый (как на изображении)
          child: Column(
            children: [
              // Верхняя синяя полоса с текстом
              Container(
                height: 60,
                color: Colors.blue,
                alignment: Alignment.center,
                child: Text(
                  'TEXT',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Пространство между заголовком и блоками
              SizedBox(height: 10),

              // Три зелёных блока в одной строке
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 150,
                      color: Colors.green,
                      margin: EdgeInsets.only(right: 10),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 150,
                      color: Colors.green,
                      margin: EdgeInsets.only(left: 10, right: 10),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 150,
                      color: Colors.green,
                      margin: EdgeInsets.only(left: 10),
                    ),
                  ),
                ],
              ),

              // Пространство между блоками
              SizedBox(height: 10),

              // Длинный зелёный блок
              Container(
                height: 60,
                color: Colors.green,
                margin: EdgeInsets.symmetric(horizontal: 10),
              ),

              // Пространство
              SizedBox(height: 10),

              // Три коротких зелёных блока
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 40,
                      color: Colors.green,
                      margin: EdgeInsets.only(right: 10),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 40,
                      color: Colors.green,
                      margin: EdgeInsets.only(left: 10, right: 10),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 40,
                      color: Colors.green,
                      margin: EdgeInsets.only(left: 10),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
