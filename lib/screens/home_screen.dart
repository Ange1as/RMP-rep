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
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Введите текст',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                print('Вы ввели: $value'); // ✅ Пункт 7: onChanged + print()
                // Можно сохранить в SharedPreferences (если нужно)
                // SharedPreferences.getInstance().then((prefs) => prefs.setString('user_input', value));
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DataScreen()),
                );
              },
              child: const Text('Перейти к данным из Supabase'),
            ),
          ],
        ),
      ),
    );
  }
}