import 'package:animation_practice/number_master/stmt_provider/page_bloc.dart';
import 'package:animation_practice/number_master/uis/predict_numbers.dart';
import 'package:animation_practice/number_master/uis/reusable_button.dart';
import 'package:animation_practice/number_master/utilities/sample_num.dart';
import 'package:animation_practice/number_master/uis/select_number_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Page4 extends StatefulWidget {
  static const String routeName = "page4";

  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  int pageNumber;
  @override
  Widget build(BuildContext context) {

    pageNumber = ModalRoute.of(context).settings.arguments;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.green),
      child: Scaffold(
        backgroundColor: Colors.green,
        body: Column(
          children: <Widget>[
            Page(
              numlist: NumList.numList4,
              whichScreen: "select fourth number",
              num: pageNumber,
            ),
            Expanded(
              child: CustomButton(
                destinationWidget: PredictNumber(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
