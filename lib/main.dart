import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Supabase
  await Supabase.initialize(
    url: 'https://opeaihxbdnzsjmtxuldy.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9wZWFpaHhiZG56c2ptdHh1bGR5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjAxMzM4NzIsImV4cCI6MjA3NTcwOTg3Mn0.G95mZ4AAQz591UftMaf-TV47Msd-pBmhJqzsBIpQJpc',
  );

  // Сохраняем переменную в SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('app_status', 'initialized');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}