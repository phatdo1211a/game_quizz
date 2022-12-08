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
  late String a, b, c, d;
  var isLoaded = false;
  int soCau = 1;
  Timer? timer;
  int seconds = 10;
  int maxsecond = 10;
  int heart = 10;
  var currentQuestionIndex = 0;

  var optionsList = [];
  int points = 0;
  List<CauHoiObject> cauHoi = [];
  @override
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
  // resetColors() {
  //   optionsColor = [
  //     Colors.white,
  //     Colors.white,
  //     Colors.white,
  //     Colors.white,
  //     Colors.white,
  //     Colors.white,
  //   ];
  // }

  gotoNextQuestion() {
    isLoaded = false;
    soCau++;
    //resetColors();
    timer!.cancel();
    seconds = 11;
    startTimer();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          timer.cancel();
          if (heart == 0) {
            setState(() {
              timer.cancel();
            });
            customAlert(
                    context: context,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    title: 'Ồ đã hết lượt chơi rồi!',
                    desc: "Bạn có $points vàng",
                    text: 'Đồng ý')
                .show();
          }
          heart--;
          gotoNextQuestion();
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
            a = cauHoi[0].dap_an_1;
            b = cauHoi[0].dap_an_2;
            c = cauHoi[0].dap_an_3;
            d = cauHoi[0].dap_an_4;
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
                                        "Chúc mừng bạn đã hoàn thành và có $points điểm.!",
                                    text: "Thoát",
                                    onPressed: () {
                                      setState(() {
                                        timer?.cancel();
                                        // resetGame();
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
                                      color: Colors.white,
                                      text: "${points.toString()}")),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          normalText(
                              color: Colors.white,
                              size: 20,
                              text: "${seconds}"),
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
                              text: 'Câu số ${cauHoi[0].id.toString()}:')),
                      const SizedBox(height: 20),
                      normalText(
                          color: Colors.white,
                          size: 25,
                          text: '${cauHoi[0].cauHoi}'),
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
                                      if (cauHoi[index].dap_an_1 ==
                                          cauHoi[index]
                                              .dap_an_dung
                                              .toString()) {
                                        optionsColor1[index] = Colors.green;
                                      } else {
                                        optionsColor1[index] = Colors.red;
                                      }
                                    });
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
                                    if (cauHoi[index].dap_an_dung ==
                                        cauHoi[index].dap_an_2) {
                                      optionsColor2[index] = Colors.green;
                                    } else {
                                      optionsColor2[index] = Colors.red;
                                    }
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
                                    if (cauHoi[index].dap_an_dung ==
                                        cauHoi[index].dap_an_3) {
                                      optionsColor3[index] = Colors.green;
                                    } else {
                                      optionsColor3[index] = Colors.red;
                                    }
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
                                    if (cauHoi[index].dap_an_dung ==
                                        cauHoi[index].dap_an_4) {
                                      optionsColor4[index] = Colors.green;
                                    } else {
                                      optionsColor4[index] = Colors.red;
                                    }
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
