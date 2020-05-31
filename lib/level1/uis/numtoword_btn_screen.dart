import 'package:animation_practice/level1/utilities/util.dart';
import 'package:flutter/material.dart';
import 'package:number_to_words_spelling/number_to_words_spelling.dart';

class NumToWord extends StatefulWidget {
  final String numberToConvert;
  final bool isPressed;
  final int index;

  @required
  final Function(int, String) onButtonPresssed;

  NumToWord(
      {this.numberToConvert,
      this.index,
      this.isPressed = false,
      this.onButtonPresssed});

  @override
  _NumToWordState createState() => _NumToWordState();
}

class _NumToWordState extends State<NumToWord> {
  String convertedString = " ";
  double width;

  @override
  Widget build(BuildContext context) {
    setState(() {
      convertedString =
          NumberWordsSpelling.toWord(widget.numberToConvert, 'en_US');
    });

    width = MediaQuery.of(context).size.width;

    return FlatButton(
      onPressed: () {
        widget.onButtonPresssed(widget.index, convertedString);
      },
      child: Center(
        child: Container(
          width: width * 0.8,
          height: width * 0.2,
          decoration: BoxDecoration(
              boxShadow:
                  widget.isPressed ? UtilityMethods.showInnerShadow() : null,
              borderRadius: BorderRadius.circular(30),
              color: widget.isPressed ? Colors.red : Colors.blue),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              convertedString,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ),
    );
  }
}
