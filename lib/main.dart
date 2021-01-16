import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_app/models/item.dart';
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
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  var items = new List<Item>();

  HomePage();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newTaskCtrl = TextEditingController();

  void add() {
    setState(() {
      widget.items.add(Item(
        title: newTaskCtrl.text,
        done: false,
      ));

      newTaskCtrl.clear();
      save();
    });
  }

  void remove(int index) {
    setState(() {
      widget.items.removeAt(index);
      save();
    });
  }

  Future load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('tasks');

    if (data == null) {
      setState(() {
        widget.items = [];
      });
    }

    Iterable decoded = jsonDecode(data);

    List<Item> items = decoded.map((e) => Item.fromJSON(e)).toList();

    setState(() {
      widget.items = items;
    });
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('tasks', jsonEncode(widget.items));
  }

  _HomePageState() {
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          keyboardType: TextInputType.text,
          style: TextStyle(
            fontSize: 18.00,
            color: Colors.white,
          ),
          decoration: InputDecoration(
              labelText: 'Insira uma nova tarefa',
              labelStyle: TextStyle(
                color: Colors.white,
              )),
          controller: newTaskCtrl,
        ),
      ),
      body: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (ctxt, index) {
            final item = widget.items[index];
            return Dismissible(
              key: Key(item.title),
              background: Container(
                color: Colors.red[200],
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
                  setState(() {
                    item.done = value;
                    save();
                  });
                },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.red[300],
      ),
    );
  }
}
