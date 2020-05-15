import 'package:animation_practice/number_master/utilities/constants.dart';
import 'package:flutter/cupertino.dart';

class Model with ChangeNotifier {
  //selected number

  //selected numbers
  Map<String, int> _selectedNumbers = {
    Constant.page1Key: 0,
    Constant.page2Key: 0,
    Constant.page3Key: 0,
    Constant.page4Key: 0,
    "check": 0,
  };

  String _buttonPlaceHolderName = "choose next";

  String get buttonPlaceHolderName => _buttonPlaceHolderName;

  set buttonPlaceHolderName(String value) {
    _buttonPlaceHolderName = value;
    notifyListeners();
  }

  Map<String, int> get selectedNumbers => _selectedNumbers;

  set selectedNumbers(Map<String, int> value) {
    _selectedNumbers = value;
    notifyListeners();
  }

  bool _correct_1 = false;
  bool _correct_2 = false;
  bool _correct_3 = false;
  bool _correct_4 = false;

  bool get correct_3 => _correct_3;

  set correct_3(bool value) {
    _correct_3 = value;
    notifyListeners();
  }

  bool get correct_1 => _correct_1;

  set correct_1(bool value) {
    _correct_1 = value;
    notifyListeners();
  }

  bool get correct_2 => _correct_2;

  set correct_2(bool value) {
    _correct_2 = value;
    notifyListeners();
  }

  bool get correct_4 => _correct_4;

  set correct_4(bool value) {
    _correct_4 = value;
    notifyListeners();
  }

  //to save to add to profile

  int _oneCorrectCount,
      _twoCorrectCount,
      _threeCorrectCount,
      _fourthCorrectCount,
      _totalPlayedCount;

  String _userName;

  int get oneCorrectCount => _oneCorrectCount;

  set oneCorrectCount(int value) {
    _oneCorrectCount = value;
    notifyListeners();
  }

  get twoCorrectCount => _twoCorrectCount;

  set twoCorrectCount(value) {
    _twoCorrectCount = value;
    notifyListeners();
  }

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
    notifyListeners();
  }

  get totalPlayedCount => _totalPlayedCount;

  set totalPlayedCount(value) {
    _totalPlayedCount = value;
    notifyListeners();
  }

  get fourthCorrectCount => _fourthCorrectCount;

  set fourthCorrectCount(value) {
    _fourthCorrectCount = value;
    notifyListeners();
  }

  get threeCorrectCount => _threeCorrectCount;

  set threeCorrectCount(value) {
    _threeCorrectCount = value;
    notifyListeners();
  }
}
