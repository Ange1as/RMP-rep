import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'quiz_category_screen.dart'; // ← импорт экрана квизов
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? fullName;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadFullName();
  }

  Future<void> _loadFullName() async {
    final user = Supabase.instance.client.auth.currentUser;
    String? nameFromSupabase = user?.userMetadata?['full_name'];

    if (nameFromSupabase != null) {
      setState(() {
        fullName = nameFromSupabase;
      });
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    String? nameFromPrefs = prefs.getString('full_name');

    setState(() {
      fullName = nameFromPrefs ?? 'Гость';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главная'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              final supabase = Supabase.instance.client;
              await supabase.auth.signOut();

              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('full_name');

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Добро пожаловать, ${fullName ?? 'Гость'}!', style: TextStyle(fontSize: 20)),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizCategoryScreen()),
                    );
                  },
                  child: Text('Пройти квиз'),
                ),
              ],
            ),
          ),
          Container(color: Colors.blue[50], child: Center(child: Text('Категории'))),
          Container(color: Colors.green[50], child: Center(child: Text('Профиль'))),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Квизы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}