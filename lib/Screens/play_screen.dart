import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_quizz/const/image.dart';
import 'package:game_quizz/object/cau_hoi_object.dart';
import 'package:game_quizz/object/chu_de_object.dart';
import 'package:game_quizz/provider/cau_hoi_provider.dart';
import 'package:game_quizz/screens/home.dart';

import '../const/colors.dart';
import '../const/text_style.dart';
import '../play/components/custome_alert.dart';
import '../provider/chu_de_provider.dart';
import 'nextpage.dart';

class PlayScreen extends StatefulWidget {
  String email;
  int id;
  PlayScreen({Key? key, required this.email, required this.id})
      : super(key: key);

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  @override
  late String a, b, c, d;
  var isLoaded = false;
  Timer? timer;
  int seconds = 10;
  int maxsecond=10;
  int heart = 3;
  var currentQuestionIndex = 0;

  var optionsList = [];
  int points = 0;
  List<CauHoiObject> cauHoi = [];

  var optionsColor1 = [
    Colors.white,
  ];
  var optionsColor2 = [
    Colors.white,
  ];
  var optionsColor3 = [
    Colors.white,
  ];
  var optionsColor4 = [
    Colors.white,
  ];
  resetColors() {
    optionsColor1 = [
      Colors.white,
    ];
    optionsColor2 = [
      Colors.white,
    ];
    optionsColor3 = [
      Colors.white,
    ];
    optionsColor4 = [
      Colors.white,
    ];
  }

  void resetGame() {
    isLoaded = false;
    currentQuestionIndex = 0;
    resetColors();
    timer?.cancel();
    seconds = 10;
    points = 0;
    // is5050Used = false;
    // isSwitchUsed = false;
  }

  gotoNextQuestion() {
    isLoaded = false;
    currentQuestionIndex++;
    resetColors();
    timer!.cancel();
    seconds = 10;
    maxsecond=10;
    startTimer();
  }

  void initState() {
    super.initState();
      startTimer();
  }
  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  void hetMang() {
     if (heart == 0) {
          setState(() {
            currentQuestionIndex = currentQuestionIndex;
            timer?.cancel();
            customAlert(
                    context: context,
                    onPressed: () {
                      heart+=1;
                      Navigator.pop(context);
                    },
                    title: 'Ồ đã hết lượt chơi rồi!',
                    desc: "Bạn có $points vàng",
                    text: 'Thêm một lượt chơi')
                .show();
          });
        }
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          timer.cancel();
          heart--;
          //gotoNextQuestion();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<List<CauHoiObject>>(
      future: CauHoiProvider.getDataById(this.widget.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CauHoiObject> cauHoi = snapshot.data!;
          if (isLoaded == false) {
            a = cauHoi[currentQuestionIndex].dap_an_1.toString();
            b = cauHoi[currentQuestionIndex].dap_an_2.toString();
            c = cauHoi[currentQuestionIndex].dap_an_3.toString();
            d = cauHoi[currentQuestionIndex].dap_an_4.toString();
            isLoaded = true;
          }
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  timer?.cancel();
                                  customAlert(
                                    context: context,
                                    title: "Thoát trò chơi",
                                    desc:
                                        "Kết thúc trò chơi và bạn có $points điểm",
                                    text: "Thoát",
                                    onPressed: () {
                                      setState(() {
                                        timer!.cancel();
                                        resetGame();
                                      });
                                      nextpage(
                                          context,
                                          HomeScreen(
                                            email: this.widget.email,
                                          ));
                                    },
                                  ).show();
                                },
                                icon: const Icon(
                                  CupertinoIcons.xmark,
                                  color: Colors.white,
                                  size: 18,
                                )),
                          ),
                          Row(
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
                                      color: Colors.white, text: "$points")),
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
                              size: 20,
                              text: 'Câu số ${currentQuestionIndex + 1}:')),
                      const SizedBox(height: 20),
                      normalText(
                          color: Colors.white,
                          size: 25,
                          text: '${cauHoi[currentQuestionIndex].cauHoi}'),
                      const SizedBox(height: 20),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (cauHoi[index]
                                              .dap_an_dung
                                              .toString() ==
                                          a) {
                                        optionsColor1[index] = Colors.green;
                                        points += 1;
                                        hetMang();
                                      } else {
                                        optionsColor1[index] = Colors.red;
                                        heart -= 1;
                                        hetMang();
                                      }
                                    });
                                    if (currentQuestionIndex <
                                        cauHoi.length - 1) {
                                      Future.delayed(const Duration(seconds: 1),
                                          () {
                                            setState(() {
                                               gotoNextQuestion();
                                            });
                                      });
                                    } else {
                                      timer!.cancel();
                                      customAlert(
                                              context: context,
                                              onPressed: () {
                                                setState(() {
                                                  timer!.cancel();
                                                  resetGame();
                                                });
                                                nextpage(
                                                    context,
                                                    HomeScreen(
                                                        email:
                                                            this.widget.email));
                                              },
                                              title: 'Bạn đã hoàn thành ',
                                              desc:
                                                  "Chúc mừng bạn đã có $points vàng.",
                                              text: 'Màn hình chính')
                                          .show();
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    alignment: Alignment.center,
                                    width: size.width - 100,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: optionsColor1[index],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: headingText(
                                      color: blue,
                                      size: 18,
                                      text: a,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (cauHoi[currentQuestionIndex]
                                              .dap_an_dung
                                              .toString() ==
                                          b) {
                                        optionsColor2[index] = Colors.green;
                                        points += 1;
                                        hetMang();
                                      } else {
                                        optionsColor2[index] = Colors.red;
                                        heart -= 1;
                                        hetMang();
                                      }
                                      if (currentQuestionIndex <
                                          cauHoi.length - 1) {
                                        Future.delayed(
                                            const Duration(seconds: 1), () {
                                              setState(() {
                                                gotoNextQuestion();
                                              });
                                        });
                                      } else {
                                        timer!.cancel();
                                        customAlert(
                                                context: context,
                                                onPressed: () {
                                                  setState(() {
                                                    timer!.cancel();
                                                    resetGame();
                                                  });
                                                  nextpage(
                                                      context,
                                                      HomeScreen(
                                                          email: this
                                                              .widget
                                                              .email));
                                                },
                                                title: 'Bạn đã hoàn thành ',
                                                desc:
                                                    "Chúc mừng bạn đã có $points vàng. Hãy thử lại nào.",
                                                text: 'Đồng ý')
                                            .show();
                                      }
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    alignment: Alignment.center,
                                    width: size.width - 100,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: optionsColor2[index],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: headingText(
                                      color: blue,
                                      size: 18,
                                      text: b,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (cauHoi[currentQuestionIndex]
                                              .dap_an_dung
                                              .toString() ==
                                          c) {
                                        optionsColor3[index] = Colors.green;
                                        points += 1;
                                        hetMang(); 
                                      } else {
                                        optionsColor3[index] = Colors.red;
                                        heart -= 1;
                                        hetMang();
                                      }
                                      if (currentQuestionIndex <
                                          cauHoi.length - 1) {
                                        Future.delayed(
                                            const Duration(seconds: 1), () {
                                           setState(() {
                                                gotoNextQuestion();
                                              });
                                        });
                                      } else {
                                        timer!.cancel();
                                        customAlert(
                                                context: context,
                                                onPressed: () {
                                                  setState(() {
                                                    timer!.cancel();
                                                    resetGame();
                                                  });
                                                  nextpage(
                                                      context,
                                                      HomeScreen(
                                                          email: this
                                                              .widget
                                                              .email));
                                                },
                                                title: 'Bạn đã hoàn thành ',
                                                desc:
                                                    "Chúc mừng bạn đã có $points vàng. Hãy thử lại nào.",
                                                text: 'Đồng ý')
                                            .show();
                                      }
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    alignment: Alignment.center,
                                    width: size.width - 100,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: optionsColor3[index],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: headingText(
                                      color: blue,
                                      size: 18,
                                      text: c,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (cauHoi[currentQuestionIndex]
                                              .dap_an_dung
                                              .toString() ==
                                          d) {
                                        optionsColor4[index] = Colors.green;
                                        points += 1;
                                          hetMang();
                                      } else {
                                        optionsColor4[index] = Colors.red;
                                        heart -= 1;
                                        hetMang();
                                      }
                                      if (currentQuestionIndex <
                                          cauHoi.length - 1) {
                                        Future.delayed(
                                            const Duration(seconds: 1), () {
                                          setState(() {
                                                gotoNextQuestion();
                                              });
                                        });
                                      } else {
                                        timer!.cancel();
                                        customAlert(
                                                context: context,
                                                onPressed: () {
                                                  setState(() {
                                                    timer!.cancel();
                                                    resetGame();
                                                  });
                                                  nextpage(
                                                      context,
                                                      HomeScreen(
                                                          email: this
                                                              .widget
                                                              .email));
                                                },
                                                title: 'Bạn đã hoàn thành ',
                                                desc:
                                                    "Chúc mừng bạn đã có $points vàng. Hãy thử lại nào.",
                                                text: 'Đồng ý')
                                            .show();
                                      }
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    alignment: Alignment.center,
                                    width: size.width - 100,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: optionsColor4[index],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: headingText(
                                      color: blue,
                                      size: 18,
                                      text: d,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          })
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Text('');
      },
    );
  }
}
