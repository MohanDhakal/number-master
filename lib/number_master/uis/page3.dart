import 'package:animation_practice/number_master/uis/page4.dart';
import 'package:animation_practice/number_master/stmt_provider/page_bloc.dart';
import 'package:animation_practice/number_master/uis/reusable_button.dart';
import 'package:animation_practice/number_master/utilities/sample_num.dart';
import 'package:animation_practice/number_master/uis/select_number_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Page3 extends StatefulWidget {
  static const String routeName = "page3";

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  int pageNumber;

  @override
  Widget build(BuildContext context) {
    pageNumber = ModalRoute.of(context).settings.arguments;


    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.grey),
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Column(
          children: <Widget>[
            Page(
              numlist: NumList.numList3,
              whichScreen: "select third number",
              num: this.pageNumber,
            ),
            Expanded(
              child: CustomButton(
                destinationWidget: Page4(),
                pageNumber: (pageNumber+1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
