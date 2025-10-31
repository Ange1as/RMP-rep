import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Supabase клиент для версии 1.0.0
final supabase = SupabaseClient(
  'https://frvexfoezbscdbcvuxas.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZydmV4Zm9lemJzY2RiY3Z1eGFzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk3NDY4ODgsImV4cCI6MjA3NTMyMjg4OH0.XDr9MFxBMX0P42a4MwjstxtZeh_Caqdyrfpfr7d9ec8',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Сообщения',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Мои сообщения'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> _messages = [];
  String _inputMessage = '';
  bool _isLoading = false;

  // Загрузка сообщений из таблицы
  Future<void> _loadMessages() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await supabase
          .from('messages')
          .select()
          .order('created_at', ascending: false);

      setState(() {
        _messages = (response as List).cast<Map<String, dynamic>>();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка загрузки: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Отправка нового сообщения
  Future<void> _sendMessage() async {
    if (_inputMessage.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите сообщение')),
      );
      return;
    }

    try {
      await supabase.from('messages').insert({
        'message': _inputMessage.trim(), // ✅ Используем 'message', как в вашей таблице
      });

      setState(() {
        _inputMessage = '';
      });

      await _loadMessages();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка отправки: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadMessages(); // Загружаем при старте
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Поле ввода
            TextField(
              decoration: const InputDecoration(
                hintText: 'Введите сообщение...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _inputMessage = value),
              onSubmitted: (_) => _sendMessage(),
            ),
            const SizedBox(height: 16),

            // Кнопка обновления
            ElevatedButton.icon(
              onPressed: _loadMessages,
              icon: const Icon(Icons.refresh),
              label: const Text('Обновить'),
            ),
            const SizedBox(height: 16),

            // Список сообщений
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final msg = _messages[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(
                              msg['message']?.toString() ?? '[пусто]', // ✅ 'message', не 'content'
                              style: const TextStyle(fontSize: 16),
                            ),
                            subtitle: msg['created_at'] != null
                                ? Text('Создано: ${msg['created_at']}')
                                : null,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Отправить',
        child: const Icon(Icons.send),
      ),
    );
  }
}