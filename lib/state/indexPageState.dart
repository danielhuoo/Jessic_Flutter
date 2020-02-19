import 'package:flutter/material.dart';

class IndexPageState extends ChangeNotifier {
  int _selectedIndex = 0;

  get selectedIndex => _selectedIndex;

  setIndex(val) {
    _selectedIndex = val;
    notifyListeners();
  }
}
