import 'package:flutter/material.dart';
import '../models/question.dart';

class QuizScreen extends StatefulWidget {
  final String category;

  const QuizScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<Question> questions;
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  bool answerSelected = false;
  int? selectedAnswerIndex;

  @override
  void initState() {
    super.initState();
    questions = getQuestions(widget.category);
  }

  List<Question> getQuestions(String category) {
    if (category == 'flutter') {
      return [
        Question(question: "Какой виджет используется для создания кнопки?", options: ["Text", "Container", "ElevatedButton", "Image"], correctAnswerIndex: 2),
        Question(question: "Какой метод вызывается при создании виджета?", options: ["build()", "initState()", "dispose()", "didUpdateWidget()"], correctAnswerIndex: 0),
        Question(question: "Какой виджет отображает список элементов?", options: ["Column", "Row", "ListView", "Stack"], correctAnswerIndex: 2),
        Question(question: "Какой пакет используется для работы с HTTP в Flutter?", options: ["flutter_bloc", "http", "provider", "shared_preferences"], correctAnswerIndex: 1),
        Question(question: "Какой виджет позволяет переключаться между экранами?", options: ["Navigator", "Scaffold", "AppBar", "MaterialApp"], correctAnswerIndex: 0),
        Question(question: "Какой метод вызывается при изменении состояния виджета?", options: ["setState()", "build()", "initState()", "dispose()"], correctAnswerIndex: 0),
        Question(question: "Какой виджет используется для отображения изображения?", options: ["Text", "Container", "Image", "Icon"], correctAnswerIndex: 2),
        Question(question: "Какой тип данных используется для хранения целых чисел?", options: ["String", "double", "int", "bool"], correctAnswerIndex: 2),
        Question(question: "Какой виджет используется для отображения диалогового окна?", options: ["AlertDialog", "SnackBar", "BottomSheet", "Drawer"], correctAnswerIndex: 0),
        Question(question: "Какой метод используется для навигации назад?", options: ["Navigator.push()", "Navigator.pop()", "Navigator.replace()", "Navigator.remove()"], correctAnswerIndex: 1),
      ];
    } else if (category == 'dart') {
      return [
        Question(question: "Как объявить переменную в Dart?", options: ["var name;", "let name;", "const name;", "def name;"], correctAnswerIndex: 0),
        Question(question: "Какой тип данных используется для хранения строк?", options: ["int", "double", "String", "bool"], correctAnswerIndex: 2),
        Question(question: "Какой оператор используется для сравнения значений?", options: ["=", "==", "!==", "==="], correctAnswerIndex: 1),
        Question(question: "Какой метод используется для вывода текста в консоль?", options: ["print()", "log()", "console.log()", "debug()"], correctAnswerIndex: 0),
        Question(question: "Какой тип данных используется для хранения логических значений?", options: ["int", "double", "String", "bool"], correctAnswerIndex: 3),
        Question(question: "Какой ключевое слово используется для создания класса?", options: ["function", "class", "struct", "interface"], correctAnswerIndex: 1),
        Question(question: "Какой метод используется для проверки условия?", options: ["if", "for", "while", "switch"], correctAnswerIndex: 0),
        Question(question: "Какой тип данных используется для хранения дробных чисел?", options: ["int", "double", "String", "bool"], correctAnswerIndex: 1),
        Question(question: "Какой оператор используется для присваивания значения?", options: ["==", "=", "+=", "-="], correctAnswerIndex: 1),
        Question(question: "Какой метод используется для цикла по списку?", options: ["for", "while", "do-while", "foreach"], correctAnswerIndex: 0),
      ];
    } else if (category == 'supabase') {
      return [
        Question(question: "Что такое Supabase?", options: ["База данных", "Фреймворк", "Облачный сервис", "Операционная система"], correctAnswerIndex: 2),
        Question(question: "Какой язык запросов использует Supabase?", options: ["SQL", "NoSQL", "GraphQL", "REST"], correctAnswerIndex: 0),
        Question(question: "Какой метод используется для входа в Supabase?", options: ["signIn()", "login()", "auth.signInWithPassword()", "user.login()"], correctAnswerIndex: 2),
        Question(question: "Какой метод используется для регистрации в Supabase?", options: ["signUp()", "register()", "auth.signUp()", "user.register()"], correctAnswerIndex: 2),
        Question(question: "Какой метод используется для выхода из Supabase?", options: ["signOut()", "logout()", "auth.signOut()", "user.logout()"], correctAnswerIndex: 2),
        Question(question: "Какой метод используется для получения текущего пользователя?", options: ["getCurrentUser()", "getUser()", "auth.currentUser", "user.current"], correctAnswerIndex: 2),
        Question(question: "Какой метод используется для обновления профиля пользователя?", options: ["updateUser()", "setUser()", "auth.updateUser()", "user.update()"], correctAnswerIndex: 2),
        Question(question: "Какой метод используется для отправки запроса к таблице?", options: ["select()", "get()", "from().select()", "query()"], correctAnswerIndex: 2),
        Question(question: "Какой метод используется для вставки данных в таблицу?", options: ["insert()", "add()", "from().insert()", "push()"], correctAnswerIndex: 2),
        Question(question: "Какой метод используется для удаления данных из таблицы?", options: ["delete()", "remove()", "from().delete()", "drop()"], correctAnswerIndex: 2),
      ];
    }

    return [];
  }

  void selectAnswer(int index) {
    if (answerSelected) return;

    setState(() {
      selectedAnswerIndex = index;
      answerSelected = true;
      if (index == questions[currentQuestionIndex].correctAnswerIndex) {
        correctAnswers++;
      }
    });
  }

  void nextQuestion() {
    setState(() {
      currentQuestionIndex++;
      answerSelected = false;
      selectedAnswerIndex = null;
    });

    if (currentQuestionIndex >= questions.length) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('🎉 Квиз завершён!'),
          content: Text('Вы ответили правильно на $correctAnswers из ${questions.length} вопросов.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('ОК'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex >= questions.length) {
      return Scaffold(
        appBar: AppBar(title: Text('${widget.category.toUpperCase()} Quiz')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 80, color: Colors.green),
              SizedBox(height: 20),
              Text(
                'Вы прошли квиз!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Правильных ответов: $correctAnswers из ${questions.length}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Назад'),
              ),
            ],
          ),
        ),
      );
    }

    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: Text('${widget.category.toUpperCase()} Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${currentQuestionIndex + 1}. ${currentQuestion.question}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 20),
            ...List.generate(currentQuestion.options.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: GestureDetector(
                  onTap: () => selectAnswer(index),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: selectedAnswerIndex == null
                          ? Colors.white
                          : selectedAnswerIndex == index
                              ? (index == currentQuestion.correctAnswerIndex
                                  ? Colors.green[100]
                                  : Colors.red[100])
                              : (index == currentQuestion.correctAnswerIndex
                                  ? Colors.green[100]
                                  : Colors.white),
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Radio<int>(
                          value: index,
                          groupValue: selectedAnswerIndex,
                          onChanged: (value) => selectAnswer(value!),
                          activeColor: Colors.blue,
                        ),
                        Expanded(
                          child: Text(currentQuestion.options[index]),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: answerSelected ? nextQuestion : null,
              child: Text(currentQuestionIndex + 1 < questions.length ? 'Следующий' : 'Завершить'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}