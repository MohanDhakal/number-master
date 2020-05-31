import 'dart:async';
import 'dart:convert';

import 'package:animation_practice/number_master/utilities/constants.dart';
import 'package:animation_practice/number_master/uis/num_btn.dart';
import 'package:animation_practice/number_master/onprogress/custom_dialog.dart';
import 'package:animation_practice/number_master/onprogress/questions.dart';
import 'package:animation_practice/number_master/utilities/sample_num.dart';
import 'package:animation_practice/number_master/utilities/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuestionScreen extends StatefulWidget {
  static const String routeName = "/questionScreen";

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  List<bool> isSelected;
  int selectedIndex;
  Timer _timer;
  bool timerEnabled = false;
  int startTime = 10;
  int level = 0;
  Questions _questions;
  List<int> selectedValues;

  @override
  void initState() {
    super.initState();

    isSelected = [true, false];

    _getQuestion();

    Future.delayed(Duration.zero).then((value) {
      _addToSelectedList(Constant.page1Key);
      _addToSelectedList(Constant.page2Key);
      _addToSelectedList(Constant.page3Key);
      _addToSelectedList(Constant.page4Key);

      setState(() {
        timerEnabled = true;
      });

      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(body: Builder(builder: (context) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: ToggleButtons(
                borderColor: Colors.black,
                fillColor: Colors.grey,
                borderWidth: 1,
                selectedBorderColor: Colors.black,
                selectedColor: Colors.white,
                borderRadius: BorderRadius.circular(6),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'show selection',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'hide selection',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < isSelected.length; i++) {
                      isSelected[i] = i == index;
                    }
                  });
                },
                isSelected: isSelected,
              ),
            ),
            SizedBox(
                child: timerEnabled ? Text("00:0${startTime}") : Container()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                _questions != null
                    ? _questions.question
                    : "Question Loading...",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
              )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  child: NumButton(
                    number: _assignNumberAccordingToLevel().elementAt(2)??0,
                    isEnabledColor:
                        selectedIndex == 0 ? Colors.red : Colors.blueAccent,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child: NumButton(
                    number: _assignNumberAccordingToLevel().elementAt(0),
                    isEnabledColor:
                        selectedIndex == 1 ? Colors.red : Colors.blueAccent,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                  child: NumButton(
                    number:_assignNumberAccordingToLevel().elementAt(1),
                    isEnabledColor:
                        selectedIndex == 2 ? Colors.red : Colors.greenAccent,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = 3;
                    });
                  },
                  child: NumButton(
                    number: _assignNumberAccordingToLevel().elementAt(3),
                    isEnabledColor:
                        selectedIndex == 3 ? Colors.red : Colors.greenAccent,
                  ),
                ),
              ],
            ),
            Container(
                width: width,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: FlatButton(
                    onPressed: () async {
                      _timer.cancel();

                      //check the correct select4d value from the sharedpreferecne and decide wrong or right
                      if (selectedIndex != null) {
                        if (NumList.numList1.elementAt(selectedIndex) ==
                            selectedValues.elementAt(selectedIndex)) {
                          int level = await showDialog(
                              context: context,
                              builder: (newContext) {
                                return CustomDialog(
                                  title: Constant.correctTitle,
                                  content: Constant.correctAns,
                                  level: this.level,
                                  tag: Constant.correctAns,
                                  result: 100.0,
                                );
                              });

                          setState(() {
                            this.level = level;
                          });
                          _getQuestion();
                          timerEnabled = true;
                          if (level != null) {
                            startTime = 10;
                            startTimer();
                          }
                        } else {
                          int level = await showDialog(
                              context: context,
                              builder: (newContext) {
                                return CustomDialog(
                                  title: Constant.wrongTitle,
                                  content: Constant.worngContent,
                                  level: this.level,
                                  tag: Constant.wrongAns,
                                  result: 0.0,
                                );
                              });

                          setState(() {
                            this.level = level;
                          });
                          _getQuestion();
                          timerEnabled = true;
                          if (level != null) {
                            startTime = 10;
                            startTimer();
                          }
                        }
                      } else {
                        final snackbar = SnackBar(
                          backgroundColor: Colors.black12,
                          content: Text("please select an answer at least."),
                          duration: Duration(seconds: 2),
                          elevation: 10,
                        );
                        Scaffold.of(context).showSnackBar(snackbar);
                      }
                    },
                    child: Text("check result")))
          ],
        ),
      );
    }));
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

  _getQuestion() {
    if (this.level == 0) {
      //todo: get the question from set1.json file locally
      _fetchJsonData("questions/set1.json").then((value) {
        setState(() {
          _questions = value.qsnList.elementAt(0);
        });
      });
    } else if (this.level == 1) {
      _fetchJsonData("questions/set2.json").then((value) {
        setState(() {
          _questions = value.qsnList.elementAt(0);
        });
      });
    } else if (this.level == 2) {
      _fetchJsonData("questions/set2.json").then((value) {
        setState(() {
          _questions = value.qsnList.elementAt(1);
        });
      });
    }
  }

  Future<QuestionsList> _fetchJsonData(String pathToJsonFile) async {
    String jsonString = await _loadJsonFromAsset(pathToJsonFile);
    final jsonResponse = json.decode(jsonString);
    QuestionsList messageList = QuestionsList.fromJson(jsonResponse);
    return messageList;
  }

  Future<String> _loadJsonFromAsset(pathToJsonFile) async {
    return await rootBundle.loadString(pathToJsonFile);
  }

  _addToSelectedList(String key) {
    UtilityMethods().getSelectedNumberWithKey(key: key).then((value) {
      selectedValues.add(value);
    });
  }

  showDialogBox(context) async {
    int level = await showDialog(
        context: context,
        builder: (newContext) {
          return CustomDialog(
            title: Constant.timeUpTitle,
            content: Constant.timeUpContent,
            tag: Constant.timeUp,
            level: this.level,
          );
        });
    setState(() {
      this.level = level;
    });
    if (level != null) {
      startTime = 10;
      startTimer();
    }
    _getQuestion();
  }

  List<int> _assignNumberAccordingToLevel() {
  List <int> newList=[];
   if(this.level==0){
     return selectedValues;

   }else{
     for(int i=0;i<4;i++){
       if(_questions.index==3){
         newList.add(selectedValues.elementAt(3)*3);
       }
     }
   }
  }
}
