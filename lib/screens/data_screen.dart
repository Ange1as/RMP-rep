import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  late Future<List<Map<String, dynamic>>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _fetchData();
  }

  Future<List<Map<String, dynamic>>> _fetchData() async {
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase.from('items').select();
      return (response as List).map((e) => e as Map<String, dynamic>).toList();

    } catch (e) {
      debugPrint('Ошибка загрузки данных: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Данные из Supabase'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }
          final data = snapshot.data ?? [];
          if (data.isEmpty) {
            return const Center(child: Text('Нет данных в таблице "items"'));
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return ListTile(
                title: Text(item['name']?.toString() ?? 'Без имени'),
                subtitle: Text('ID: ${item['id']}'), 
              );
            },
          );
        },
      ),
    );
  }
}