import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_app/components/button_add_task.dart';
import 'package:new_app/components/input_task.dart';
import 'package:new_app/components/list_task.dart';
import 'package:new_app/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tasks extends StatefulWidget {
  var tasks = new List<Item>();
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final newTaskCtrl = TextEditingController();

  void add() {
    setState(() {
      widget.tasks.add(Item(
        title: newTaskCtrl.text,
        done: false,
      ));

      newTaskCtrl.clear();
      save();
    });
  }

  void remove(int index) {
    setState(() {
      widget.tasks.removeAt(index);
      save();
    });
  }

  Future load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('tasks');

    if (data == null) {
      setState(() {
        widget.tasks = [];
      });
    }

    Iterable decoded = jsonDecode(data);

    List<Item> tasks = decoded.map((e) => Item.fromJSON(e)).toList();

    setState(() {
      widget.tasks = tasks;
    });
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('tasks', jsonEncode(widget.tasks));
  }

  setDone(index, value) {
    setState(() {
      widget.tasks[index].done = value;
      save();
    });
  }

  _TasksState() {
    load();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InputTask(
        ctrl: newTaskCtrl,
        appBar: AppBar(),
      ),
      body: ListTask(
        tasks: widget.tasks,
        remove: remove,
        setDone: setDone,
      ),
      floatingActionButton: ButtonAddTask(
        add: add,
      ),
    );
  }
}
