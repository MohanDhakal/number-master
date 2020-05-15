import 'package:animation_practice/number_master/uis/page2.dart';
import 'package:animation_practice/number_master/uis/reusable_button.dart';
import 'package:animation_practice/number_master/utilities/sample_num.dart';
import 'package:animation_practice/number_master/uis/select_number_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Page1 extends StatefulWidget {

  static const String routeName = "page1";
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  int pageNumber;

  @override
  Widget build(BuildContext context) {

    this.pageNumber = ModalRoute.of(context).settings.arguments;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.purple),
      child: Scaffold(
        backgroundColor: Colors.purple,
        body: Column(
          children: <Widget>[
            Page(
              numlist: NumList.numList1,
              whichScreen: "select first number",
              num: this.pageNumber,
            ),
            Expanded(
              child: CustomButton(
                destinationWidget: Page2(),
                pageNumber: (this.pageNumber+1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
