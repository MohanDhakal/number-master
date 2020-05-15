import 'package:animation_practice/number_master/utilities/constants.dart';
import 'package:animation_practice/number_master/uis/num_btn.dart';
import 'package:animation_practice/number_master/utilities/sample_num.dart';
import 'package:animation_practice/number_master/utilities/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Page extends StatefulWidget {
  final List<int> numlist;
  final Color color;
  final String whichScreen;
  final int num;

  Page(
      {this.numlist = const [1, 2, 3, 4, 5, 6],
      this.color,
      this.whichScreen,
      this.num});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  static Color activeColor = Colors.red;

  static int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {

    List<NumButton> btnList = [
      NumButton(
        number: widget.numlist.elementAt(0),
        isEnabledColor: selectedIndex == 0 ? activeColor : null,
      ),
      NumButton(
        number: widget.numlist.elementAt(1),
        isEnabledColor: selectedIndex == 1 ? activeColor : null,
      ),
      NumButton(
          number: widget.numlist.elementAt(2),
          isEnabledColor: selectedIndex == 2 ? activeColor : null),
      NumButton(
          number: widget.numlist.elementAt(3),
          isEnabledColor: selectedIndex == 3 ? activeColor : null),
      NumButton(
          number: widget.numlist.elementAt(4),
          isEnabledColor: selectedIndex == 4 ? activeColor : null),
      NumButton(
          number: widget.numlist.elementAt(5),
          isEnabledColor: selectedIndex == 5 ? activeColor : null)
    ];

    switch (widget.num) {
      case 1:

        UtilityMethods().putValues(
            key: Constant.page1Key,
            value: NumList.numList1.elementAt(selectedIndex ?? 0));

        break;
      case 2:
        UtilityMethods().putValues(
            key: Constant.page2Key,
            value: NumList.numList2.elementAt(selectedIndex ?? 0));
        break;
      case 3:
        UtilityMethods().putValues(
            key: Constant.page3Key,
            value: NumList.numList3.elementAt(selectedIndex ?? 0));
        break;
      case 4:
        UtilityMethods().putValues(
            key: Constant.page4Key,
            value: NumList.numList4.elementAt(selectedIndex ?? 0));
        break;
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: widget.color),
      child: Container(
        color: widget.color,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                widget.whichScreen,
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              crossAxisCount: 2,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                    child: btnList.elementAt(0)),
                InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    child: btnList.elementAt(1)),
                InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                    },
                    child: btnList.elementAt(2)),
                InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = 3;
                      });
                    },
                    child: btnList.elementAt(3)),
                InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = 4;
                      });
                    },
                    child: btnList.elementAt(4)),
                InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = 5;
                      });
                    },
                    child: btnList.elementAt(5)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
