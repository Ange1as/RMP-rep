import 'package:flutter/material.dart';
import 'data_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Рабочие URL изображений пневматических пистолетов (Unsplash)
    final List<String> weaponImages = [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNyg12WRw9GrpZucs8pp4uPv-wW2nUVAfutA&s', // пистолет
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1AS2ovhP4rKe6PGe3FmKpLdWgFHB3vNvA8A&s', // пистолет
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMXvKImOZY11EKjN0dKZlD_IsTnwfmtRsO1w&s', // пистолет
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('AirGun Shop'),
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DataScreen()),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 🔹 Заголовок приложения
              Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '🔫 AirGun Shop',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[300],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 Меню — три блока в строке
              Row(
                children: [
                  _buildMenuCard('Винтовки', Colors.grey[200]!),
                  const SizedBox(width: 12),
                  _buildMenuCard('Пистолеты', Colors.grey[300]!),
                  const SizedBox(width: 12),
                  _buildMenuCard('Аксессуары', Colors.grey[400]!),
                ],
              ),

              const SizedBox(height: 24),

              // 🔹 Акция / баннер
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.red, width: 1.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.red,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '🔥 Скидка 15% на первую покупку!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red[800],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 🔹 Галерея изображений — пистолеты
              ...List.generate(
                weaponImages.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey, width: 1),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        weaponImages[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.error_outline,
                              size: 48,
                              color: Colors.red,
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(String title, Color color) {
    return Expanded(
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 1.5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
