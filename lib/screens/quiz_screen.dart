import 'package:flutter/material.dart';
import 'results_screen.dart'; // We need this to navigate to the results page.

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // Tracks which question the user is currently on (e.g., 0, 1, 2...).
  int _currentQuestion = 0;

  //  A list to store the user's answers as they progress through the quiz.
  List<String> answers = [];

  // DATA SOURCE: This is the 'model' for our quiz. It's a list of questions,
  // where each question is a map containing the question text and a list of options.
  // It's 'final' because the questions themselves don't change.
  final List<Map<String, dynamic>> questions =  [
    {
      "question": "How do you feel about taking financial risks?",
      "options": [
        "Love it! High risk, high reward",
        "I take calculated risks only",
        "No risks! I prefer stability"
      ],
    },
    {
      "question": "What’s your approach to making money?",
      "options": [
        "Hustle hard, multiple income streams",
        "Smart investments & passive income",
        "Stick to a steady job"
      ],
    },
    {
      "question": "If you suddenly got \$50,000, what would you do first?",
      "options": [
        "Invest it all into a business",
        "Travel & enjoy life a bit",
        "Save it for future security"
      ],
    },
    {
      "question": "What best describes your work style?",
      "options": [
        "Be my own boss, full freedom",
        "Corporate but with flexibility",
        "A structured job with stability"
      ],
    },
    {
      "question": "How do you react to unexpected financial opportunities?",
      "options": [
        "Jump on them immediately",
        "Think carefully before deciding",
        "Hesitate & sometimes miss out"
      ],
    },
    {
      "question": "Which quote matches your money mindset?",
      "options": [
        "'Money makes money—invest & grow!'",
        "'Plan, save, and build wealth step by step.'",
        "'Money isn’t everything, but security is nice.'"
      ],
    },
    {
      "question": "What’s your biggest motivation for making money?",
      "options": [
        "Financial freedom & luxury lifestyle",
        "Success & recognition",
        "Stability & taking care of loved ones"
      ],
    },
    {
      "question": "If you could guarantee success in one thing, what would it be?",
      "options": [
        "Running a successful business",
        "Becoming a top investor",
        "Having a dream job I love"
      ],
    },
  ];

  // CORE FUNCTION: This is the main logic that drives the quiz forward.

  void _nextQuestion(String answer) {
    // setState() is the most important function in a State class. It tells Flutter
    // that the state has changed and the UI needs to be rebuilt to reflect those changes.
    setState(() {
      // 1. Record the user's chosen answer.
      answers.add(answer);

      // 2. Check if there are more questions left.
      if (_currentQuestion < questions.length - 1) {
        // If yes, increment the counter to show the next question.
        _currentQuestion++;
      } else {
        // 3. If the quiz is finished, navigate to the ResultsScreen.
        // We pass the collected 'answers' to the next screen so it can process them.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResultsScreen(answers: answers),
          ),
        );
      }
    });
  }

  /// The build method describes the UI. It runs every time setState() is called,
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade200, Colors.purple.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // UI reflects the current state (_currentQuestion)
                    Text(
                      'Q${_currentQuestion + 1}', // Display question number
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.yellowAccent),
                    ),
                    SizedBox(height: 10),
                    // The question text is pulled from our 'questions' list using the current index.
                    Text(
                      questions[_currentQuestion]["question"],
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),

                    // The progress indicator's value is calculated from the current state.
                    LinearProgressIndicator(
                      value: (_currentQuestion + 1) / questions.length,
                      backgroundColor: Colors.purple.shade100,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                      minHeight: 8,
                    ),
                    SizedBox(height: 20),

                    // CORE UI GENERATION: This is a powerful Flutter pattern.
                    // 1. We get the list of 'options' for the current question.
                    // 2. '.map()' transforms each option string into an ElevatedButton widget.
                    // 3. The '...' (spread operator) takes the list of buttons generated by .map()
                    //    and inserts them as individual widgets into the Column's children list.
                    ...questions[_currentQuestion]["options"].map((option) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: ElevatedButton(
                          // Each button, when pressed, calls our core logic function.
                          onPressed: () => _nextQuestion(option),
                          child: Text(option, style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 22),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      );
                    }).toList(), // .toList() is required to finish the .map() operation.
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}