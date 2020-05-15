import 'package:animation_practice/number_master/uis/page1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Tutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: Colors.purpleAccent),
        child: Scaffold(
            body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Welcome to the NUMBER MASTER, in this game you will be presented with number from where you have"
                "to select the number one from each screen which you have to remember later on to predict.",
                style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),textAlign: TextAlign.justify,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: FlatButton(
                  onPressed: () => Navigator.pushNamed(context, Page1.routeName,
                      arguments: 1),
                  child: Text("Get Started")),
            ),
          ],
        )));
  }
/*

  Container(
  width: width,
  margin: EdgeInsets.all(5),
  decoration: BoxDecoration(a
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
*/

}
