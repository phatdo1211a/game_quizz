import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_quizz/screens/home.dart';
import 'package:game_quizz/play/components/customChoicesButton.dart';
import 'package:game_quizz/play/components/custome_alert.dart';
import 'package:game_quizz/play/components/gameInfoRow.dart';
import 'package:game_quizz/play/components/helping_icons_row.dart';
import 'package:game_quizz/play/components/presentCurrentQuestion.dart';
import 'package:game_quizz/play/util/balance_list.dart';
import 'package:game_quizz/play/util/question_list.dart';

class QuestionsPage extends StatefulWidget {
  static final id = 'QuestionsPage';
  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  QuestionsList questionBank = QuestionsList();
  //*The number of question
  int currentQuestionNum = 1;
  //*The current balance
  int currentBalance = 0;
  // the balance after first wrong answer (loosing game)
  int loosingBalance = 0;
  //* these variable for check if user use 50/50   and switch question or not
  bool is5050Used = false;
  bool isSwitchUsed = false;
  //this variable used to (recognize the choosen answer number)to change background of answer_box5555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
  String userclickedNumber = '0';
// to save the choises btn backgrounds
  Map<String, String> buttonbackground = {
    '1': 'answer_box',
    '2': 'answer_box',
    '3': 'answer_box',
    '4': 'answer_box'
  };
  @override
  static const maxSeconds = 5;
  int seconds = maxSeconds;
  Timer? timer;
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() => seconds--);
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    if (seconds == 0) {
      timer?.cancel();
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 54, 18),
      body: SafeArea(
        child: Center(
          // main coulmn for all UI elements
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Row for helping icons -------------------------------------
              helpingIconsRow(
                is5050UsedValue: is5050Used,
                isSwitchUsedValue: isSwitchUsed,
                withdrawFunction: () {
                  customAlert(
                    context: context,
                    title: "Huỷ trò chơi",
                    desc: "Bạn chỉ có $currentBalance Xu. Hãy thử lại nhé!",
                    text: "Thoát",
                    onPressed: () {
                      setState(() {
                        reSetGameData();
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                  ).show();
                },
                functionOF5050: () {
                  setState(() {
                    if (is5050Used == false) {
                      questionBank.removTowOption();
                      is5050Used = true;
                    }
                  });
                },
                switchFunction: () {
                  setState(() {
                    if (isSwitchUsed == false) {
                      questionBank.replaceQuestion();
                      isSwitchUsed = true;
                    }
                  });
                },
              ),
                
            
              gameInfoRow(
                currentBalanceValue: currentBalance,
                currentQustionNumber: currentQuestionNum,
              ),
              //Thời gian
               Center(child:  
                buildTimer(),
              ),
              presentCurrentQuestion(theQuestion: questionBank.getQuestion()),

              customChoicesButton(
                buttonPadding: EdgeInsets.fromLTRB(0, 15, 0, 5),
                onPressed: () {
                  if (questionBank.getChoiceOne() != '  ') {
                    setState(() {
                      userclickedNumber = '1';
                    });

                    checkAnswe(questionBank.getChoiceOne());
                  }
                },
                text: questionBank.getChoiceOne(),
                imageName: buttonbackground['1'] ?? '',
              ),
              //second option
              customChoicesButton(
                buttonPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                onPressed: () {
                  if (questionBank.getChoiceTwo() != '  ') {
                    setState(() {
                      userclickedNumber = '2';
                    });

                    checkAnswe(questionBank.getChoiceTwo());
                  }
                },
                text: questionBank.getChoiceTwo(),
                imageName: buttonbackground['2'] ?? '',
              ),
              //third option
              customChoicesButton(
                buttonPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                onPressed: () {
                  if (questionBank.getChoiceThree() != '  ') {
                    setState(() {
                      userclickedNumber = '3';
                    });

                    checkAnswe(questionBank.getChoiceThree());
                  }
                },
                text: questionBank.getChoiceThree(),
                imageName: buttonbackground['3'] ?? '',
              ),
              // fourth option
              customChoicesButton(
                buttonPadding: EdgeInsets.fromLTRB(0, 5, 0, 15),
                onPressed: () {
                  if (questionBank.getChoiceFour() != '  ') {
                    setState(() {
                      userclickedNumber = '4';
                    });

                    checkAnswe(questionBank.getChoiceFour());
                  }
                },
                text: questionBank.getChoiceFour(),
                imageName: buttonbackground['4'] ?? '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkAnswe(String userPickedAnswer) async {
    String correctAnswer = questionBank.getAnswer();

    setState(() {
      if (userPickedAnswer == correctAnswer) {
        buttonbackground[userclickedNumber] = 'correct';
        currentBalance = ListOfBalance().getNewBalance();
      } else {
        buttonbackground[userclickedNumber] = 'Wrong';
        loosingBalance = ListOfBalance().isLoss();
      }
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      if (userPickedAnswer != correctAnswer) {
        customAlert(
                context: context,
                onPressed: () {
                  setState(() {
                    reSetGameData();
                  });
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                title: 'Thua ',
                desc:
                    "Tiếc quá bạn chỉ có $loosingBalance Xu. Hãy thử lại nào.",
                text: 'Đồng ý')
            .show();
      } else if (currentQuestionNum + 1 > 4) {
        customAlert(
          context: context,
          onPressed: () {
            setState(() {
              reSetGameData();
            });
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          title: "Chiến thắng",
          desc: "Chúc mừng bạn đã giành được $currentBalance Xu",
          text: "Đồng ý",
        ).show();
      } else {
        currentQuestionNum++;
        buttonbackground[userclickedNumber] = 'answer_box';
        questionBank.nextQuestion();
      }
    });
  }

  void reSetGameData() {
    currentQuestionNum = 1;
    currentBalance = 0;
    is5050Used = false;
    isSwitchUsed = false;
    ListOfBalance().resetBalanceCounter();
  }

  //thời gian
  Widget buildTime() {
    return Text(
      '$seconds',
      style: const TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  Widget buildTimer() => SizedBox(
        width: 50,
        height: 50,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: seconds / maxSeconds,
              valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
              strokeWidth: 10,
              backgroundColor: Colors.red,
            ),
            Center(child: buildTime())
          ],
        ),
      );
}
