import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'game.dart';
import 'grain.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  if (localStorage.getItem('score') == null) {
    localStorage.setItem('score', '0');
  } else {
    String str = localStorage.getItem('score')!;
    score = int.parse(str);
  }
  
  runApp(const MaterialApp(
    home: SimpleChickenGameWidget(),
  ));
}
