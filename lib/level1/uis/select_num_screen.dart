import 'package:animation_practice/level1/uis/btn_screen.dart';
import 'package:animation_practice/level1/uis/predict_screen.dart';
import 'package:animation_practice/level1/utilities/constant.dart';
import 'package:animation_practice/level1/utilities/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectNumber extends StatefulWidget {
  @override
  _SelectNumberState createState() => _SelectNumberState();
}

class _SelectNumberState extends State<SelectNumber> {
  List<int> numberList;
  int pageCount = 0;
  int selectedIndex;

  @override
  void initState() {
    super.initState();
    UtilityMethods().getRandomNumbers().then((value) {
      this.setState(() => this.numberList = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.purpleAccent),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              _getTitle(this.pageCount),
              style: TextStyle(fontSize: 25, fontStyle: FontStyle.normal),
            ),
            getRowWith(0, 1),
            getRowWith(2, 3),
            getRowWith(4, 5),
            Builder(
              builder: (context) {
                return FlatButton.icon(

                  onPressed: () {
                    if (this.pageCount == 3) {
                      if (selectedIndex == null) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("please select a number"),
                        ));
                      } else {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => PredictScreen()));
                      }
                    } else {
                      if (selectedIndex == null) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          duration: Duration(milliseconds: 500),
                          content: Text("please select a number"),
                        ));
                      } else {
                        setState(() {
                          UtilityMethods().getRandomNumbers().then((value) {
                            this.numberList = value;
                          });
                          this.selectedIndex = null;
                          this.pageCount++;
                        });
                      }
                    }
                  },
                  color: Colors.blueAccent,
                  icon: Icon(Icons.arrow_forward_ios),
                  label: Text(
                    _getBtnText(this.pageCount),
                    style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontSize: 18),
                  ),
                  colorBrightness: Brightness.light,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget getRowWith(int index1, int index2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        NumberButton(
            number: numberList != null ? numberList.elementAt(index1) : 1,
            index: index1,
            color: selectedIndex == index1 ? Colors.red : Colors.lightBlue,
            onButtonPresssed: (selectedIndex) {
              setState(() {
                this.selectedIndex = selectedIndex;
              });
              _assignKeyValueToPage(index1);
            }),
        NumberButton(
            number: numberList != null ? numberList.elementAt(index2) : 2,
            index: index2,
            color: selectedIndex == index2 ? Colors.red : Colors.lightGreen,
            onButtonPresssed: (selectedIndex) {
              setState(() {
                this.selectedIndex = selectedIndex;
              });
              _assignKeyValueToPage(index2);
            }),
      ],
    );
  }

  String _getTitle(pageNo) {
    switch (pageNo) {
      case 0:
        return Constant.title1;
        break;
      case 1:
        return Constant.title2;
        break;
      case 2:
        return Constant.title3;
        break;
      case 3:
        return Constant.title4;
        break;
      default:
        return "";
    }
  }

  String _getBtnText(pageNo) {
    switch (pageNo) {
      case 3:
        return Constant.predictText;
        break;
      default:
        return Constant.btnText1;
    }
  }

  _assignKeyValueToPage(index) {
    switch (this.pageCount) {
      case 0:
        UtilityMethods().putValues(
            key: Constant.page1Key, value: numberList.elementAt(index));

        break;
      case 1:
        UtilityMethods().putValues(
            key: Constant.page2Key, value: numberList.elementAt(index));

        break;
      case 2:
        UtilityMethods().putValues(
            key: Constant.page3Key, value: numberList.elementAt(index));

        break;
      case 3:
        UtilityMethods().putValues(
            key: Constant.page4Key, value: numberList.elementAt(index));
        break;
    }
  }

  showSnackBar() {}
}
