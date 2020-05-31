import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UtilityMethods {
  int getRandIndex() {
    var rng = new Random();
    return rng.nextInt(4);
  }

  Future<List<int>> getRandomNumbers(
      {int lowerLimit = 5, int upperLimit = 100}) async {
    var rng = new Random();
    var l = new List.generate(
        20, (_) => (rng.nextDouble() * (upperLimit - lowerLimit)).floor() + 5);
    var newList = LinkedHashSet<int>.from(l).toList();
    return newList;
  }

  static List<BoxShadow> showShadow() {
    return [
      BoxShadow(
        blurRadius: 15,
        offset: -Offset(5, 5),
        color: Colors.purple,
      ),
      BoxShadow(
        blurRadius: 15,
        offset: Offset(4.5, 4.5),
        color: kDarkShadow,
      )
    ];
  }

  static List<BoxShadow> showInnerShadow() {
    return [
      BoxShadow(
        blurRadius: 15,
        offset: Offset(5, 5),
        color: Colors.purple,
      ),
      BoxShadow(
        blurRadius: 15,
        offset: -Offset(4.5, 4.5),
        color: kDarkShadow,
      ),
    ];
  }

  static final kOrange = Color.fromRGBO(238, 115, 201, 1); // rgb(238, 134, 48)
  static final kDarkShadow =
      Color.fromRGBO(178, 137, 216, 1); // rgb(216, 213, 208)

  void putValues({String key, int value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
    print("The key is : ${key} : The value is: ${value}");
  }

  Future<int> getSelectedNumberWithKey({String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int num = prefs.getInt(key);
    return num;
  }
}
