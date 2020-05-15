import 'package:animation_practice/number_master/utilities/util.dart';
import 'package:flutter/material.dart';

class ResultButton extends StatefulWidget {
  @required
  final int number;

  final Color isEnabledColor;

  ResultButton({
    this.number = 1,
    this.isEnabledColor,
  });

  @override
  _ResultButtonState createState() => _ResultButtonState();
}

class _ResultButtonState extends State<ResultButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: widget.isEnabledColor ??
              (isEven(widget.number) ? Colors.blueAccent : Colors.greenAccent),
          border: Border(
            top: BorderSide(color: Colors.black38),
            left: BorderSide(color: Colors.black38),
            right: BorderSide(color: Colors.black38),
            bottom: BorderSide(color: Colors.black38),
          ),
          boxShadow: UtilityMethods.showInnerShadow(),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Align(
          heightFactor: 0,
          widthFactor: 0,
          child: Text(
            widget.number.toString(),
            style: TextStyle(fontSize: 34),
          ),
        ),
      ),
    );
  }

  bool isEven(a) {
    if (a % 2 == 0) {
      return true;
    }
    return false;
  }
}
