import 'package:animation_practice/number_master/onprogress/custom_dialog.dart';
import 'package:animation_practice/number_master/stmt_provider/bloc.dart';
import 'package:animation_practice/number_master/stmt_provider/page_bloc.dart';
import 'package:animation_practice/number_master/uis/progress_bar.dart';
import 'package:animation_practice/number_master/uis/select_result_btn.dart';
import 'package:animation_practice/number_master/utilities/constants.dart';
import 'package:animation_practice/number_master/utilities/sample_num.dart';
import 'package:animation_practice/number_master/utilities/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PredictNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Model()),
        ChangeNotifierProvider(create: (_) => PageBloc())
      ],
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 30),
              child: Text(
                "Remember your selected numbers? Give it a try!",
                style: TextStyle(fontSize: 15),
              ),
            ),
            SelectNumber(),
            Consumer<Model>(builder: (context, model, child) {
              return Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: FlatButton(
                      child: Text(model.buttonPlaceHolderName),
                      onPressed: () {
                        PageBloc page =
                            Provider.of<PageBloc>(context, listen: false);
                        page.pageNo++;

                        model.buttonPlaceHolderName =
                            "predict  ${page.pageNo} number";

                        model.selectedNumbers.update("check", (value) => 1);

                        for (int index = 0; index < 4; index++) {
                          String page = "page${index + 1}";

                          UtilityMethods()
                              .getSelectedNumberWithKey(key: page)
                              .then((value) {
                            if (value == model.selectedNumbers[page]) {
                              if (index == 0)
                                model.correct_1 = true;
                              else if (index == 1)
                                model.correct_2 = true;
                              else if (index == 2)
                                model.correct_3 = true;
                              else if (index == 3) model.correct_4 = true;
                            }
                          });
                        }

                        if (page.pageNo == 4) {
                          model.buttonPlaceHolderName = "move forward";
                        }

                        if (model.buttonPlaceHolderName == "move forward") {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                  title: "Congrats!",
                                  content:
                                      "you have accomplished  the beginner level of the game,your mind is something!wait sometime for another level!",
                                  result: _calculatePercentage(model),
                                );
                              });
                        }
                      }),
                ),
              );
            }),
            Result(),
          ],
        ),
      ),
    );
  }

  double _calculatePercentage(Model model) {
    double realPercentage = 0;
    if (model.correct_1 && //a
        model.correct_2 && //b
        model.correct_3 && //c
        model.correct_4) {
      realPercentage += 100;
    } else if ((model.correct_1 && model.correct_2 && model.correct_3) ||
        (model.correct_1 && model.correct_3 && model.correct_4) ||
        (model.correct_1 && model.correct_2 && model.correct_4)) {
      realPercentage += 75;
    } else if ((model.correct_1 && model.correct_2) ||
        (model.correct_1 && model.correct_3) ||
        (model.correct_1 && model.correct_4) ||
        (model.correct_2 && model.correct_3) ||
        (model.correct_2 && model.correct_4) ||
        (model.correct_3 && model.correct_4)) {
      realPercentage += 50;
    } else if (model.correct_1 ||
        model.correct_2 ||
        model.correct_3 ||
        model.correct_4) {
      realPercentage += 25;
    } else {
      realPercentage = 0;
    }

    return realPercentage;
  }
}

class SelectNumber extends StatefulWidget {
  static Color activeColor = Colors.red;
  static int selectedIndex = 0;

  @override
  _SelectNumberState createState() => _SelectNumberState();
}

class _SelectNumberState extends State<SelectNumber> {
  @override
  Widget build(BuildContext context) {
    PageBloc page = Provider.of<PageBloc>(context, listen: true);
    Model model = Provider.of<Model>(context, listen: true);

    switch (page.pageNo) {
      case 0:
        model.selectedNumbers.update(Constant.page1Key, (value) {
          value = NumList.numList1.elementAt(SelectNumber.selectedIndex);
          return value;
        });
        break;
      case 1:
        model.selectedNumbers.update(Constant.page2Key, (value) {
          value = NumList.numList2.elementAt(SelectNumber.selectedIndex);
          return value;
        });
        break;
      case 2:
        model.selectedNumbers.update(Constant.page3Key, (value) {
          value = NumList.numList3.elementAt(SelectNumber.selectedIndex);
          return value;
        });
        break;
      case 3:
        model.selectedNumbers.update(Constant.page4Key, (value) {
          value = NumList.numList1.elementAt(SelectNumber.selectedIndex);
          return value;
        });
        break;
    }

    return Container(
      color: _assignColorAccordingToPageNumber(page.pageNo),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                SelectNumber.selectedIndex = 0;
              });
            },
            child: ResultButton(
                //todo: page no aunsar  randomly values halne
                //except the one correct value
                number:
                    _assignListAccordingToPageNumber(page.pageNo).elementAt(0),
                isEnabledColor: SelectNumber.selectedIndex == 0
                    ? SelectNumber.activeColor
                    : null),
          ),
          InkWell(
            onTap: () {
              setState(() {
                SelectNumber.selectedIndex = 1;
              });
            },
            child: ResultButton(
                number:
                    _assignListAccordingToPageNumber(page.pageNo).elementAt(1),
                isEnabledColor: SelectNumber.selectedIndex == 1
                    ? SelectNumber.activeColor
                    : null),
          ),
          InkWell(
            onTap: () {
              setState(() {
                SelectNumber.selectedIndex = 2;
              });
            },
            child: ResultButton(
                number:
                    _assignListAccordingToPageNumber(page.pageNo).elementAt(2),
                isEnabledColor: SelectNumber.selectedIndex == 2
                    ? SelectNumber.activeColor
                    : null),
          ),
          InkWell(
            onTap: () {
              setState(() {
                SelectNumber.selectedIndex = 3;
              });
            },
            child: ResultButton(
                number:
                    _assignListAccordingToPageNumber(page.pageNo).elementAt(3),
                isEnabledColor: SelectNumber.selectedIndex == 3
                    ? SelectNumber.activeColor
                    : null),
          ),
        ],
      ),
    );
  }
}

List<int> _assignListAccordingToPageNumber(int pageNo) {
  switch (pageNo) {
    case 0:
      return NumList.numList1;
      break;
    case 1:
      return NumList.numList2;
      break;
    case 2:
      return NumList.numList3;
      break;
    case 3:
      return NumList.numList4;
      break;
    default:
      return NumList.numList1;
  }
}

Color _assignColorAccordingToPageNumber(int pageNo) {
  if (pageNo == 0) {
    return Colors.purpleAccent;
  } else if (pageNo == 1) {
    return Colors.grey;
  } else if (pageNo == 2) {
    return Colors.yellow;
  } else if (pageNo == 3) {
    return Colors.lightGreenAccent;
  } else
    return Colors.purpleAccent;
}

class Result extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IndicateProgress(
        headerText: "Result Section",
        icons: Icons.wb_incandescent,
      ),
    );
  }
}
