import 'package:flutter/foundation.dart';

//for result selection
class PageBloc extends ChangeNotifier {
  int _pageNo = 0;

  int get pageNo => _pageNo;

  set pageNo(int value) {
    _pageNo = value;
    notifyListeners();
  }
}

//for number selection

class SelectedPageBloc extends ChangeNotifier {
  int _selectedPageIndex = 0;

  Map<String, int> _selectedValues={};

  Map<String, int> get selectedValues => _selectedValues;

  set selectedValues(Map<String, int> value) {
    _selectedValues = value;
    notifyListeners();
  }

  int get selectedPageIndex => _selectedPageIndex;

  set selectedPageIndex(int value) {
    _selectedPageIndex = value;
    notifyListeners();
  }

}
