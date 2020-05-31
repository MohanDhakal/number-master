import 'package:animation_practice/number_master/uis/page3.dart';
import 'package:animation_practice/number_master/stmt_provider/page_bloc.dart';
import 'package:animation_practice/number_master/uis/reusable_button.dart';
import 'package:animation_practice/number_master/utilities/sample_num.dart';
import 'package:animation_practice/number_master/uis/select_number_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Page2 extends StatefulWidget {
  static const String routeName = "page2";

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  int pageNumber;

  @override
  Widget build(BuildContext context) {
    pageNumber = ModalRoute.of(context).settings.arguments;



    return ChangeNotifierProvider(
      create: (_) => SelectedPageBloc(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        child: Scaffold(
          backgroundColor: Colors.blue,
          body: Column(
            children: <Widget>[
              MyPage(
                numlist: NumList.numList2,
                whichScreen: "select second number",
                num: this.pageNumber,
              ),
              Expanded(
                child: CustomButton(
                  destinationWidget: Page3(),
                  pageNumber: (pageNumber+1),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
