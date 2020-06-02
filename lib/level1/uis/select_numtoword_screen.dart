import 'dart:async';

import 'package:animation_practice/level1/uis/custom_dialog.dart';
import 'package:animation_practice/level1/uis/numtoword_btn_screen.dart';
import 'package:animation_practice/level1/utilities/constant.dart';
import 'package:animation_practice/level1//utilities/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:number_to_words_spelling/number_to_words_spelling.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:vibration/vibration.dart';

class SelectNumToWord extends StatefulWidget {
  @override
  _SelectNumToWordState createState() => _SelectNumToWordState();
}

class _SelectNumToWordState extends State<SelectNumToWord> {


  double width;
  int selectedIndex;
  int firstNumber;
  int secondNumber;
  int randomIndexForAns;
  String question;
  double progressValue = 0;
  Timer _timer;
  bool timerEnabled = false;
  int startTime = 15;

  @override
  void initState() {
    super.initState();

    _setPage();
    setState(() {
      timerEnabled = true;
    });
    Future.delayed(Duration(seconds: 2));
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return (this.secondNumber != null && this.question != null)
        ? AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(statusBarColor: Colors.purpleAccent),
            child: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: width*0.4,
                    decoration: BoxDecoration(
                        color: startTime < 5
                            ? Colors.redAccent
                            : Colors.greenAccent,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        (startTime < 10) ? "00:0$startTime" : "00:$startTime",
                        style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Text(
                    "Level 2: One step a head ",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      this.question,
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          color: Colors.black),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  getElementAtIndex(0,context),
                  getElementAtIndex(1,context),
                  getElementAtIndex(2,context),
                  getElementAtIndex(3,context),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LinearPercentIndicator(
                      backgroundColor: Colors.green,
                      progressColor: Colors.blue,
                      lineHeight: 20,
                      percent: progressValue / 100,
                      center: Text(progressValue == 0
                          ? ""
                          : progressValue.toString() + " %"),
                      animation: true,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (timer) => setState(
        () {
          if (startTime < 1) {
            _timer.cancel();
            showDialogBox(context);
          } else {
            startTime = startTime - 1;
          }
        },
      ),
    );
  }

  showDialogBox(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (innerContext) {
          return CustomDialog(
            previousContext: context,
            title: "Time Up!!!",
            content:
                "Your time is up,let's start it again and get it done this time!!!",
            result: 0,
            level: 2,
          );
        });
  }

  Widget getElementAtIndex(index1,context) {
    return NumToWord(
      index: index1,
      isPressed: this.selectedIndex == index1 ? true : false,
      numberToConvert: getNumToConvert(index1),
      onButtonPresssed: (selectedIndex, answer) async {
        setState(() {
          this.selectedIndex = selectedIndex;
        });

        if (NumberWordsSpelling.toWord(
                '${this.firstNumber}' + '${this.secondNumber}', 'en_US') ==
            answer) {
          progressValue += 50;
          if (progressValue > 50) {
            _timer.cancel();
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (innerContext) {
                  return CustomDialog(
                    previousContext: context,
                    title: "congratulations!!!",
                    content:
                        "You have accomplished level 2 ,let's focus on your numeric memory,restart the game with the below button",
                    result: 100,
                    level: 2,
                  );
                });
          } else {
            setState(() {
              this.selectedIndex = null;
            });
            Future.delayed(Duration(seconds: 1));
            _setPage();
          }
        } else {
          if (await Vibration.hasVibrator()) {
            Vibration.vibrate(
              duration: 200,
            );
          }
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (innerContext) {
                return CustomDialog(
                  previousContext: context,
                  title: "sorry?!!!",
                  content:
                      "you are unable to make it this time ,let's restart again!",
                  result: 50,
                  level: 2,
                );
              });
        }
      },
    );
  }

  String getNumToConvert(index) {
    switch (index) {
      case 0:
        return (randomIndexForAns == index)
            ? ('${this.firstNumber}' + '${this.secondNumber}')
            : ('${this.firstNumber * 2}' +
                '${(this.secondNumber / 2).floor()}');
        break;
      case 1:
        return (randomIndexForAns == index)
            ? ('${this.firstNumber}' + '${this.secondNumber}')
            : ('${this.firstNumber * 2}' + '${(this.secondNumber + 1)}');

        break;
      case 2:
        return (randomIndexForAns == index)
            ? ('${this.firstNumber}' + '${this.secondNumber}')
            : ('${this.firstNumber + 2}' + '${(this.secondNumber - 2)}');

        break;
      default:
        return (randomIndexForAns == index)
            ? ('${this.firstNumber}' + '${this.secondNumber}')
            : ('${this.firstNumber + 3}' + '${(this.secondNumber / 3).ceil()}');
    }
  }

  String getKey(index) {
    switch (index) {
      case 0:
        return Constant.page1Key;
        break;
      case 1:
        return Constant.page2Key;
        break;
      case 2:
        return Constant.page3Key;
        break;
      default:
        return Constant.page4Key;
    }
  }

  String _getQuestion(index1, index2) {
    print("index1= {$index1} and index2= {$index2}");
    if (index1 == 0 && index2 == 1) {
      return Constant.question01;
    } else if (index1 == 0 && index2 == 2) {
      return Constant.question02;
    } else if (index1 == 0 && index2 == 3) {
      return Constant.question03;
    } else if (index1 == 1 && index2 == 0) {
      return Constant.question10;
    } else if (index1 == 1 && index2 == 2) {
      return Constant.question12;
    } else if (index1 == 1 && index2 == 3) {
      return Constant.question13;
    } else if (index1 == 2 && index2 == 0) {
      return Constant.question20;
    } else if (index1 == 2 && index2 == 1) {
      return Constant.question21;
    } else if (index1 == 2 && index2 == 3) {
      return Constant.question23;
    } else if (index1 == 3 && index2 == 0) {
      return Constant.question30;
    } else if (index1 == 3 && index2 == 1) {
      return Constant.question31;
    } else if (index1 == 3 && index2 == 2) {
      return Constant.question32;
    } else
      return "no index correct";
  }

  _setPage() {
    int randIndex1 = UtilityMethods().getRandIndex();
    int randIndex2 = UtilityMethods().getRandIndex();

    while (randIndex1 == randIndex2) {
      randIndex2 = UtilityMethods().getRandIndex();
    }

    UtilityMethods()
        .getSelectedNumberWithKey(key: getKey(randIndex1))
        .then((value) {
      setState(() {
        this.firstNumber = value;
      });
    });

    UtilityMethods()
        .getSelectedNumberWithKey(key: getKey(randIndex2))
        .then((value) {
      setState(() {
        this.secondNumber = value;
      });
    });
    setState(() {
      randomIndexForAns = UtilityMethods().getRandIndex();
      this.question = _getQuestion(randIndex1, randIndex2);
    });
  }
}
