import 'dart:async';

import 'package:game_quizz/provider/api_service.dart';
import 'package:game_quizz/const/colors.dart';
import 'package:game_quizz/const/image.dart';
import 'package:game_quizz/const/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_quizz/screens/home.dart';
import 'package:game_quizz/screens/nextpage.dart';

import '../play/components/custome_alert.dart';
import '../play/components/helping_icons_row.dart';

class QuizScreen extends StatefulWidget {
    String email;
  QuizScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState(email: email);
}

class _QuizScreenState extends State<QuizScreen> {
    String email;
  _QuizScreenState({Key? key, required this.email});
  bool is5050Used = false;
  bool isSwitchUsed = false;
  int heart=100;
  var currentQuestionIndex = 0;
  int seconds = 10;
  int maxsecond = 10;
  Timer? timer;
  late Future quiz;

  int points = 0;

  var isLoaded = false;

  var optionsList = [];

  var optionsColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  @override
  void initState() {
    super.initState();
    quiz = getQuiz();
    startTimer();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  resetColors() {
    optionsColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          gotoNextQuestion();
        }
      });
    });
  }

  gotoNextQuestion() {
    isLoaded = false;
    currentQuestionIndex++;
    resetColors();
    timer!.cancel();
    seconds = 11;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [blue, darkBlue],
            ),
          ),
          child: FutureBuilder(
            future: quiz,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data["results"];
                if (isLoaded == false) {
                  optionsList = data[currentQuestionIndex]["incorrect_answers"];
                  optionsList.add(data[currentQuestionIndex]["correct_answer"]);
                  optionsList.shuffle();
                  isLoaded = true;
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: lightgrey, width: 2),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  customAlert(
                                    context: context,
                                    title: "Thoát trò chơi",
                                    desc:
                                        "Bạn chỉ có $points tym. Hãy thử lại nhé!",
                                    text: "Thoát",
                                    onPressed: () {
                                      setState(() {
                                        points = 0;
                                        is5050Used = false;
                                        isSwitchUsed = false;
                                      });
                                      nextpage(context, HomeScreen(email: email,));
                                    },
                                  ).show();
                                },
                                icon: const Icon(
                                  CupertinoIcons.xmark,
                                  color: Colors.white,
                                  size: 28,
                                )),
                          ),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: null,
                                icon: const Icon(CupertinoIcons.heart_fill,
                                    color: Colors.red, size: 18),
                                label: normalText(
                                  color: Colors.white,
                                  text: "$heart",
                                ),
                              ),
                              TextButton.icon(
                                  onPressed: null,
                                  icon: const Icon(
                                      CupertinoIcons.money_dollar_circle,
                                      color: Color.fromARGB(255, 228, 207, 16),
                                      size: 18),
                                  label: normalText(
                                      color: Colors.white,
                                      text: points.toString())),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          normalText(
                              color: Colors.white, size: 20, text: "$seconds"),
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(
                              value: seconds / maxsecond,
                              valueColor:
                                  const AlwaysStoppedAnimation(Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: normalText(
                              color: lightgrey,
                              size: 18,
                              text:
                                  "Question ${currentQuestionIndex + 1} of ${data.length}")),
                      const SizedBox(height: 20),
                      normalText(
                          color: Colors.white,
                          size: 20,
                          text: data[currentQuestionIndex]["question"]),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: optionsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var answer =
                              data[currentQuestionIndex]["correct_answer"];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (answer.toString() ==
                                    optionsList[index].toString()) {
                                  optionsColor[index] = Colors.green;
                                  points = points + 10;
                                } else {
                                  optionsColor[index] = Colors.red;
                                  heart=heart-1;
                                }
                                if (currentQuestionIndex < data.length - 1) {
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    gotoNextQuestion();
                                  });
                                } else {
                                  timer!.cancel();
                                  //here you can do whatever you want with the results
                                }
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              alignment: Alignment.center,
                              width: size.width - 100,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: optionsColor[index],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: headingText(
                                color: blue,
                                size: 18,
                                text: optionsList[index].toString(),
                              ),
                            ),
                          );
                        },
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              helpingIconsRow(
                                is5050UsedValue: is5050Used,
                                isSwitchUsedValue: isSwitchUsed,
                                functionOF5050: () {
                                  setState(() {
                                    if (is5050Used == false) {
                                      int myCount = 0;
                                      for (int i = 0; i <= 3; i++) {
                                        if (data[currentQuestionIndex]
                                                    ["question"][i] !=
                                                data[currentQuestionIndex]
                                                    ["correct_answer"] &&
                                            myCount <= 1) {
                                          data[currentQuestionIndex]
                                              ["incorrect_answers"][i] = ' ';
                                          myCount++;
                                        }
                                      }
                                      is5050Used = true;
                                    }
                                  });
                                },
                                switchFunction: () {
                                  setState(() {
                                    if (isSwitchUsed == false) {
                                      data[currentQuestionIndex]["question"] +=
                                          data[currentQuestionIndex]
                                              ["question"];
                                      isSwitchUsed = true;
                                    }
                                  });
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
