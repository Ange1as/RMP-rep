import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedValue();
  }

  Future<void> _loadSavedValue() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('user_input') ?? '';
    if (mounted) {
      setState(() {
        _controller.text = saved;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главная')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Первый Container с Row и тремя Text (требование задания)
            Container(
              width: double.infinity,
              height: 60,
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text('Элемент 1'),
                  Text('Элемент 2'),
                  Text('Элемент 3'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 TextFormField (сохранён из исходного кода)
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Введите текст',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                print('Вы ввели: $value'); // ✅ Пункт: onChanged + print()
              },
            ),

            const SizedBox(height: 30),

            // 🔹 ElevatedButton для перехода (сохранён)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DataScreen()),
                );
              },
              child: const Text('Перейти к данным из Supabase'),
            ),

            const SizedBox(height: 20),

            // 🔹 Второй Container (требование задания)
            Container(
              width: double.infinity,
              height: 100,
              color: Colors.blue[100],
              // Можно оставить пустым или добавить что-то
              child: Center(
                child: Text(
                  'Дополнительный контейнер',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}