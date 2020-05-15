import 'package:animation_practice/number_master/uis/tutorial.dart';
import 'package:animation_practice/number_master/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class CustomDialog extends StatefulWidget {
  final String title, content;
  final double result;
  final String tag;
  final int level;

  CustomDialog(
      {this.title = "huh!!!",
      this.result = 20,
      this.tag,
      this.level,
      this.content =
          "You are unable to make it,please restart the game again! "});

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
      title: Text(widget.result < 75 ? "huh!!!" : widget.title),
      description: Text(widget.result < 75
          ? "You are unable to make it,please restart the game again! "
          : widget.content),
      buttonCancelText: Text("restart"),
      buttonOkColor: Colors.green,
      buttonCancelColor: Colors.red,
      buttonOkText: Text("continue"),
      onlyOkButton: widget.result >= 75 ? true : false,
      onlyCancelButton: widget.result < 75 ? true : false,
      onCancelButtonPressed: _handleCancel,
      onOkButtonPressed: _handleOkay,
      entryAnimation: EntryAnimation.DEFAULT,
    );
  }

  void _handleCancel() {
    /*switch (widget.tag) {
      case Constant.timeUp:
        Navigator.pop(context,widget.level);
        break;

      case Constant.wrongAns:
        Navigator.pop(context,widget.level);
        break;ur
    }*/
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => Tutorial()));
  }

  void _handleOkay() {
    /*  int lev=widget.level;
    if(Constant.correctAns==widget.tag){

      Navigator.pop(context, ++lev);
    }
  }*/
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => Tutorial()));
  }
}
