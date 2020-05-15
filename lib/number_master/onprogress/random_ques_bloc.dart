import 'package:flutter/foundation.dart';

class QuestionBloc with ChangeNotifier {
  int _inLevel = 0;

  int get inLevel => _inLevel;

  set inLevel(int value) {
    _inLevel = value;
    notifyListeners();
  }
}
