import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int questionIndex = 0;
  bool showResultsMessage = false;
  int? yourChoiceIndex;

  List<Map<String, dynamic>> questionsWithAnswers = [
    {
      'question': 'What is your favorite sport?',
      'answers': ['Football', 'Tennis', 'Basketball', 'Volleyball'],
    },
    {
      'question': 'What is your favorite color?',
      'answers': ['Green', 'Red', 'Blue', 'White'],
    },
    {
      'question': 'What is your favorite animal?',
      'answers': ['Camel', 'Horse', 'Dog', 'Cat'],
    },
    {
      'question': 'What is your favorite animal?',
      'answers': ['Camel', 'Horse', 'Dog', 'Cat'],
    },
  ];

  void resetQuiz() {
    setState(() {
      questionIndex = 0;
      showResultsMessage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final questionWithAnswer = questionsWithAnswers[questionIndex];
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: showResultsMessage == false
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showResultsMessage == false) ...[
                      SizedBox(height: size.height * 0.1),
                      Text(
                        questionWithAnswer['question'],
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Answer and get points',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: size.height * 0.1),
                      for (int i = 0;
                          i < questionWithAnswer['answers'].length;
                          i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                yourChoiceIndex = i;
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                color: i == yourChoiceIndex
                                    ? Colors.green
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: i == yourChoiceIndex
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    const SizedBox(width: 16.0),
                                    Text(
                                      questionWithAnswer['answers'][i],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: i == yourChoiceIndex
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (yourChoiceIndex != null) {
                                if (questionIndex <
                                    questionsWithAnswers.length - 1) {
                                  questionIndex ++;
                                } else {
                                  showResultsMessage = true;
                                }
                                yourChoiceIndex = null;
                              } else {
                                // TODO: Add a snack bar with a message for the user
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text('Next'),
                        ),
                      ),
                      // for (int i = 0; i < questionWithAnswer['answers'].length; i++)
                      //   Padding(
                      //     padding: const EdgeInsets.only(bottom: 16.0),
                      //     child: SizedBox(
                      //       width: double.infinity,
                      //       height: 40,
                      //       child: ElevatedButton(
                      //         onPressed: () {
                      //           setState(() {
                      //             if (questionIndex <
                      //                 questionsWithAnswers.length - 1) {
                      //               questionIndex++;
                      //             } else {
                      //               showResultsMessage = true;
                      //             }
                      //           });
                      //         },
                      //         child: Text(questionWithAnswer['answers'][i]),
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Congratulations!',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Your score is: ${questionIndex + 1}/${questionsWithAnswers.length}',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      TextButton(
                        onPressed: resetQuiz,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.green,
                          textStyle: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        child: const Text('Reset Quiz'),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
