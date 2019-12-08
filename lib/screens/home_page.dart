import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'ingredients_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose date"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                new DateFormat.yMMMd().format(selectedDate),
                style: Theme.of(context).textTheme.display1,
              ),
              RaisedButton(
                child: Text("Choose Date"),
                onPressed: () {
                  _selectDate(context);
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/ingredients',
              arguments: IngredientsScreenArgs(selectedDate));
        },
        child: Icon(Icons.arrow_forward),
        backgroundColor: Colors.red[300],
      ),
    );
  }
}
