import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_app/models/item.dart';
import 'package:new_app/screens/tasks.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Todo do Lucão',
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        home: Tasks());
  }
}
