import 'package:animation_practice/level1/uis/btn_screen.dart';
import 'package:animation_practice/level1/uis/custom_dialog.dart';
import 'package:animation_practice/level1/utilities/constant.dart';
import 'package:animation_practice/level1/utilities/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:vibration/vibration.dart';

class PredictScreen extends StatefulWidget {
  @override
  _PredictScreenState createState() => _PredictScreenState();
}

class _PredictScreenState extends State<PredictScreen> {
  int randIndex, randIndex2;
  int selectedIndex;
  int numberToSelect = 0;
  double progressValue = 0;
  int ans;

  @override
  void dispose() {
    super.dispose();
    Vibration.cancel();
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      //to get the values of this particular index
      randIndex = UtilityMethods().getRandIndex();

      //to put the value in this index in UI,used in ui
      randIndex2 = UtilityMethods().getRandIndex();
    });
    UtilityMethods()
        .getSelectedNumberWithKey(key: _getKey(randIndex))
        .then((value) {
      setState(() {
        ans = value;
      });
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.purpleAccent),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Level 1: An initial touch ",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                _getQuestion(),
                style: TextStyle(fontSize: 25, fontStyle: FontStyle.normal),
              ),
            ),
            getRowWith(0, 1, buildContext),
            getRowWith(2, 3, buildContext),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinearPercentIndicator(
                backgroundColor: Colors.green,
                progressColor: Colors.blue,
                lineHeight: 20,
                percent: progressValue / 100,
                center: Text(progressValue.toString() + " %"),
                animation: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getKey(index) {
    if (index == 0) {
      return Constant.page1Key;
    } else if (index == 1) {
      return Constant.page2Key;
    } else if (index == 2) {
      return Constant.page3Key;
    } else {
      return Constant.page4Key;
    }
  }

  Widget getRowWith(int index1, int index2, context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        NumberButton(
            number: _putNumberInPlace(index1),
            index: index1,
            color: selectedIndex == index1 ? Colors.red : Colors.lightBlue,
            onButtonPresssed: (selectedIndex) async {
              setState(() {
                this.selectedIndex = selectedIndex;
              });

              if (ans == _putNumberInPlace(index1)) {
                _resetPage(context);
              } else {
                if (await Vibration.hasVibrator()) {
                  Vibration.vibrate(
                    duration: 200,
                  );
                }
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (innerContext) {
                      return CustomDialog(
                        previousContext: context,
                        title: "sorry to say?",
                        content:
                            "let's focus more and restart the game with the below button!!",
                        result: progressValue,
                        level: 1,
                      );
                    });
              }
            }),
        NumberButton(
            number: _putNumberInPlace(index2),
            index: index2,
            color: selectedIndex == index2 ? Colors.red : Colors.lightGreen,
            onButtonPresssed: (selectedIndex) async {
              setState(() {
                this.selectedIndex = selectedIndex;
              });
              if (ans == _putNumberInPlace(index2)) {
                _resetPage(context);
              } else {
                if (await Vibration.hasVibrator()) {
                  Vibration.vibrate(
                    duration: 200,
                  );
                }
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (innerContext) {
                      return CustomDialog(
                        previousContext: context,
                        title: "sorry to say?",
                        content:
                            "let's focus more and restart the game with the below button",
                        result: progressValue,
                        level: 1,
                      );
                    });
              }
            }),
      ],
    );
  }

  _resetPage(context) {
    double myProgressValue = this.progressValue + 50;
    print(myProgressValue);

    if (myProgressValue > 50) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (innerContext) {
            return CustomDialog(
              previousContext: context,
              title: "woo ,yeah!",
              content:
                  "You are already a step far,let's continue more with the same energy!!",
              result: myProgressValue,
              level: 1,
            );
          });
    } else {
      setState(() {
        progressValue = myProgressValue;
      });

      int newIndex = randIndex;

      while (randIndex == newIndex) {
        newIndex = UtilityMethods().getRandIndex();
      }

      setState(() {
        randIndex = newIndex;
        randIndex2 = UtilityMethods().getRandIndex();
        this.selectedIndex = null;
      });

      UtilityMethods()
          .getSelectedNumberWithKey(key: _getKey(randIndex))
          .then((value) {
        setState(() {
          ans = value;
        });
      });
    }
  }

  int _putNumberInPlace(index) {
    _getNumberAtIndex(randIndex).then((value) {
      setState(() {
        numberToSelect = value;
      });
    });

    switch (index) {
      case 0:
        return (index == randIndex2) ? numberToSelect : numberToSelect + 1;
        break;
      case 1:
        return (index == randIndex2) ? numberToSelect : numberToSelect * 2;

        break;
      case 2:
        return (index == randIndex2)
            ? numberToSelect
            : (numberToSelect / 2).floor();

        break;
      case 3:
        return (index == randIndex2) ? numberToSelect : numberToSelect - 2;

        break;
    }
    return 0;
  }

  Future<int> _getNumberAtIndex(int randIndex) async {
    int number;
    switch (randIndex) {
      case 0:
        await UtilityMethods()
            .getSelectedNumberWithKey(key: Constant.page1Key)
            .then((value) => number = value);
        return number;
        break;
      case 1:
        await UtilityMethods()
            .getSelectedNumberWithKey(key: Constant.page2Key)
            .then((value) => number = value);
        return number;
        break;
      case 2:
        await UtilityMethods()
            .getSelectedNumberWithKey(key: Constant.page3Key)
            .then((value) => number = value);
        return number;
        break;
      case 3:
        await UtilityMethods()
            .getSelectedNumberWithKey(key: Constant.page4Key)
            .then((value) => number = value);
        return number;
        break;
    }
    return 0;
  }

  String _getQuestion() {
    switch (randIndex) {
      case 0:
        return Constant.question1;
        break;
      case 1:
        return Constant.question2;
        break;
      case 2:
        return Constant.question3;
        break;
      case 3:
        return Constant.question4;
        break;
    }
    return "";
  }
}
