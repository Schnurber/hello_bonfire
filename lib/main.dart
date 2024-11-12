import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'game.dart';
import 'grain.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  String? item = localStorage.getItem('score');
  if (item == null) {
    localStorage.setItem('score', '0');
  } else {
    String str = item;
    score = int.parse(str);
  }
  
  runApp(const MaterialApp(
    home: SimpleChickenGameWidget(),
  ));
}
