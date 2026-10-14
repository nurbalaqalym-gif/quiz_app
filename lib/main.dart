
import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int questionIndex = 0;
  int score = 0;
  int? selectedAnswer;
  bool finished = false;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Flutter дегеніміз не?',
      'answers': [
        'Programming language',
        'Mobile framework',
        'Database',
        'Operating system',
      ],
      'correct': 1,
    },
    {
      'question': 'Flutter-де қай тіл қолданылады?',
      'answers': ['Python', 'Java', 'Dart', 'C++'],
      'correct': 2,
    },
    {
      'question': 'UI жасау үшін не қолданамыз?',
      'answers': ['Widget', 'Folder', 'File', 'Server'],
      'correct': 0,
    },
    {
      'question': 'main() функциясы не үшін керек?',
      'answers': [
        'App-ты бастау үшін',
        'Түс өзгерту үшін',
        'Файл өшіру үшін',
        'Сурет салу үшін',
      ],
      'correct': 0,
    },
    {
      'question': 'Hot Reload не істейді?',
      'answers': [
        'Телефонды өшіреді',
        'Кодтағы өзгерісті көрсетеді',
        'Интернет қосады',
        'Файлды жояды',
      ],
      'correct': 1,
    },
  ];

  void chooseAnswer(int index) {
    if (selectedAnswer != null) return;

    setState(() {
      selectedAnswer = index;

      if (index == questions[questionIndex]['correct']) {
        score++;
      }
    });
  }

  void nextQuestion() {
    setState(() {
      if (questionIndex < questions.length - 1) {
        questionIndex++;
        selectedAnswer = null;
      } else {
        finished = true;
      }
    });
  }

  void restartQuiz() {
    setState(() {
      questionIndex = 0;
      score = 0;
      selectedAnswer = null;
      finished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: finished
              ? buildResult()
              : buildQuestion(),
        ),
      ),
    );
  }

  Widget buildQuestion() {
    final question = questions[questionIndex];
    final answers = question['answers'] as List<String>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        const Text(
          'QUIZ TIME',
          style: TextStyle(
            color: Color(0xFF7654D6),
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),

        const SizedBox(height: 24),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Your Progress',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '${questionIndex + 1}/${questions.length}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF7654D6),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        LinearProgressIndicator(
          value: (questionIndex + 1) / questions.length,
          minHeight: 8,
          borderRadius: BorderRadius.circular(10),
          backgroundColor: Colors.deepPurple.shade100,
          color: const Color(0xFF7654D6),
        ),

        const SizedBox(height: 35),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.lightbulb_outline,
                color: Color(0xFF7654D6),
                size: 36,
              ),
              const SizedBox(height: 18),
              Text(
                'Question ${questionIndex + 1}',
                style: const TextStyle(
                  color: Color(0xFF7654D6),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                question['question'],
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'Choose your answer',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 12),

        Expanded(
          child: ListView.builder(
            itemCount: answers.length,
            itemBuilder: (context, index) {
              Color buttonColor = Colors.white;
              Color textColor = Colors.black87;

              if (selectedAnswer != null) {
                if (index == question['correct']) {
                  buttonColor = Colors.green.shade100;
                  textColor = Colors.green.shade900;
                } else if (index == selectedAnswer) {
                  buttonColor = Colors.red.shade100;
                  textColor = Colors.red.shade900;
                }
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => chooseAnswer(index),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: textColor,
                      padding: const EdgeInsets.all(18),
                      side: BorderSide(
                        color: selectedAnswer == index
                            ? const Color(0xFF7654D6)
                            : Colors.deepPurple.shade100,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${String.fromCharCode(65 + index)}. ${answers[index]}',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed:
                selectedAnswer == null ? null : nextQuestion,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7654D6),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              questionIndex == questions.length - 1
                  ? 'See Result'
                  : 'Next Question',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildResult() {
    final percentage = (score / questions.length * 100).round();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.emoji_events,
            size: 100,
            color: Color(0xFF7654D6),
          ),

          const SizedBox(height: 24),

          const Text(
            'Quiz Completed!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            '$score / ${questions.length}',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7654D6),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Your score: $percentage%',
            style: const TextStyle(fontSize: 18),
          ),

          const SizedBox(height: 16),

          Text(
            percentage >= 80
                ? 'Excellent! Great job!'
                : percentage >= 40
                    ? 'Good try! Keep learning!'
                    : 'Keep practicing!',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17),
          ),

          const SizedBox(height: 35),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: restartQuiz,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7654D6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Try Again',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
