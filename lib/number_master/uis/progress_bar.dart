import 'package:animation_practice/number_master/stmt_provider/bloc.dart';
import 'package:animation_practice/number_master/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class IndicateProgress extends StatelessWidget {
  final String headerText;
  final IconData icons;

  IndicateProgress({this.headerText, this.icons});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<Model>(
        builder: (context, model, child) {
          return model.selectedNumbers["check"] < 1
              ? Text(
                  "No result Available yet",
                )
              : CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 10.0,
                  percent: _calculatePercentage(model) != 0
                      ? (_calculatePercentage(model) / 100.0)
                      : _calculatePercentage(model) + 1,
                  animation: true,
                  header: new Text(headerText),
                  center: _getMessage(model),
                  footer: new Icon(
                    icons,
                    size: 50.0,
                    color: Colors.yellow,
                  ),
                  progressColor: _calculateProgressAndShowColor(model),
                );
        },
      ),
    );
  }

  Widget _getMessage(model) {
    String message="no correct";
    if (_calculatePercentage(model) == 25)
      message = "correct 1";
    else if (_calculatePercentage(model) == 50)
      message = "correct 2";
    else if (_calculatePercentage(model) == 75)
      message = "correct 3";
    else if (_calculatePercentage(model) == 100) message = "all correct";

    return Text(message);
  }

  Color _calculateProgressAndShowColor(Model model) {
    if (_calculatePercentage(model) < 25) {
      return Colors.redAccent;
    } else if (_calculatePercentage(model) >= 25 &&
        _calculatePercentage(model) < 50) {
      return Colors.purpleAccent;
    } else if (_calculatePercentage(model) >= 50 &&
        _calculatePercentage(model) < 75) {
      return Colors.blueAccent;
    } else if (_calculatePercentage(model) >= 75 &&
        _calculatePercentage(model) == 100) {
      return Colors.green;
    }
    return Colors.greenAccent;
  }

  double _calculatePercentage(Model model) {
    double realPercentage=0;
    if (model.correct_1 && //a
        model.correct_2 && //b
        model.correct_3 && //c
        model.correct_4) {
      realPercentage += 100;
    } else if ((model.correct_1 && model.correct_2 && model.correct_3) ||
        (model.correct_1 && model.correct_3 && model.correct_4) ||
        (model.correct_1 && model.correct_2 && model.correct_4)) {
      realPercentage += 75;
    } else if ((model.correct_1 && model.correct_2) ||
        (model.correct_1 && model.correct_3) ||
        (model.correct_1 && model.correct_4) ||
        (model.correct_2 && model.correct_3) ||
        (model.correct_2 && model.correct_4) ||
        (model.correct_3 && model.correct_4)) {
      realPercentage += 50;
    } else if (model.correct_1 ||
        model.correct_2 ||
        model.correct_3 ||
        model.correct_4) {
      realPercentage += 25;
    } else{
      realPercentage = 0;
    }

    return realPercentage;
  }
}
