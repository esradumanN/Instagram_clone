import 'package:flutter/material.dart';

class NavbarProvider extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  set index(int index) {
    _index = index;
    notifyListeners();
  }

  clear() {
    _index = 0;
    notifyListeners();
  }
}
