import 'package:flutter/material.dart';
import 'package:new_app/models/item.dart';

class ListTask extends StatelessWidget {
  static const DELETE_COLOR = Colors.red;
  List<Item> tasks;
  Function remove, setDone;

  ListTask({this.tasks, this.remove, this.setDone});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (ctxt, index) {
          final item = tasks[index];
          return Dismissible(
            key: Key(item.title),
            background: Container(
              color: DELETE_COLOR,
            ),
            onDismissed: (direction) {
              remove(index);
            },
            direction: DismissDirection.endToStart,
            child: CheckboxListTile(
              title: Text(item.title),
              key: Key(item.title),
              value: item.done,
              onChanged: (value) {
                setDone(index, value);
              },
            ),
          );
        });
  }
}
