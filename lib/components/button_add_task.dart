import 'package:flutter/material.dart';

class ButtonAddTask extends StatelessWidget {
  Function add;

  ButtonAddTask({this.add});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: add,
      child: Icon(Icons.add),
      backgroundColor: Colors.red[300],
    );
  }
}
