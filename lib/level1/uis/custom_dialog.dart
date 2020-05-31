import 'package:animation_practice/level1/uis/select_numtoword_screen.dart';
import 'package:animation_practice/level1/utilities/constant.dart';
import 'package:animation_practice/main.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class CustomDialog extends StatefulWidget {
  final String title, content;
  final double result;

  //tag for different type of situatioin such as
  //i might not make solution in time or i might get the wrong anser

  final String tag;
  final int level;
  final previousContext;

  CustomDialog(
      {this.title = "huh!!!",
      this.result = 20,
      this.previousContext,
      this.tag,
      this.level = 1,
      this.content = "You are unable to make it,you can restart the game ! "});

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return AssetGiffyDialog(
      image: Image.asset(
        //update this image according to right or wrong anser
        widget.result >= 75 ? Constant.clap : Constant.thinking,
      ),
      title: Text(widget.title),
      description: Text(widget.content),
      buttonCancelText: Text("restart game"),
      buttonOkColor: Colors.green,
      buttonCancelColor: Colors.red,
      buttonOkText: Text("let's continue"),
      onlyOkButton: widget.result >= 75 ? true : false,
      onlyCancelButton: widget.result < 75 ? true : false,
      onCancelButtonPressed: _handleCancel,
      onOkButtonPressed: _handleOkay,
      entryAnimation: EntryAnimation.DEFAULT,
    );
  }

  void _handleCancel() {
    Navigator.pop(context);
    Navigator.pushReplacement(
        widget.previousContext, MaterialPageRoute(builder: (_) => Home()));
  }

  void _handleOkay() {
    switch (widget.level) {
      case 1:
        Navigator.pop(context);
        Navigator.pushReplacement(widget.previousContext,
            MaterialPageRoute(builder: (_) => SelectNumToWord()));
        break;
      case 2:
        Navigator.pop(context);
        Navigator.pushReplacement(
            widget.previousContext, MaterialPageRoute(builder: (_) => Home()));
        break;
    }
  }
}
