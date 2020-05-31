import 'package:animation_practice/number_master/utilities/util.dart';
import 'package:flutter/material.dart';

class NumberButton extends StatelessWidget {
  @required
  final int number;
  final Color color;
  final int index;

  @required
  final Function(int) onButtonPresssed;

  NumberButton(
      {this.number = 1,
      this.color = Colors.lightBlue,
      this.onButtonPresssed,
      this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton(
          onPressed: () => onButtonPresssed(index),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: this.color,
              border: Border(
                top: BorderSide(color: Colors.black38),
                left: BorderSide(color: Colors.black38),
                right: BorderSide(color: Colors.black38),
                bottom: BorderSide(color: Colors.black38),
              ),
              boxShadow:
                  color == Colors.red ? UtilityMethods.showInnerShadow() : null,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Align(
              heightFactor: 0,
              widthFactor: 0,
              child: Text(
                this.number.toString(),
                style: TextStyle(fontSize: 34),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
