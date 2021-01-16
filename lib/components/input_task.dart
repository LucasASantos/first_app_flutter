import 'package:flutter/material.dart';

class InputTask extends StatelessWidget implements PreferredSizeWidget {
  static const SIZE = 18.00;
  static const TEXT_COLOR = Colors.white;
  static const LABEL_TEXT = 'Insira uma nova tarefa';
  final AppBar appBar;

  final TextEditingController ctrl;

  InputTask({this.ctrl, this.appBar});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextFormField(
        keyboardType: TextInputType.text,
        style: TextStyle(
          fontSize: SIZE,
          color: TEXT_COLOR,
        ),
        decoration: InputDecoration(
            labelText: LABEL_TEXT,
            labelStyle: TextStyle(
              color: TEXT_COLOR,
            )),
        controller: ctrl,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
