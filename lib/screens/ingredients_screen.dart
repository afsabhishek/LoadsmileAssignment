import 'dart:convert';

import 'package:assignment/ingredients_model.dart';
import 'package:assignment/screens/reciep_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class IngredientsPage extends StatefulWidget {
  @override
  _IngredientsPageState createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  List<IngredientsDetails> _ingredientsList;
  @override
  Widget build(BuildContext context) {
    final IngredientsScreenArgs args =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Ingredients"),
      ),
      body: SafeArea(
          child: _ingredientsList == null
              ? _getIngredientsList(args.selectedDate)
              : prepareList(args.selectedDate)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (getSelectedIngredients().length > 0) {
            Navigator.pushNamed(context, '/recipelist',
                arguments: RecipeListArgs(getSelectedIngredients()));
            clearSelectedIngredients();
          } else {
            _showDialog();
          }
        },
        child: Icon(Icons.arrow_forward),
        backgroundColor: Colors.blue[300],
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Uh oh!"),
          content: new Text("Zero ingredient is selected"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _getIngredientsList(DateTime selectedDate) {
    return FutureBuilder(
      future: getIngredients(),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none ||
            projectSnap.connectionState == ConnectionState.waiting ||
            projectSnap.hasData == null) {
          return Center(
            child: Text(
              "Loading...",
              style: TextStyle(fontSize: 20),
            ),
          );
        }
        final ingredientDetails = json.decode(projectSnap.data.body) as List;
        final items = ingredientDetails
            .map((i) => new IngredientsDetails.fromJson(i))
            .toList();
        _ingredientsList = items.toList();
        return prepareList(selectedDate);
      },
    );
  }

  getSelectedIngredients() {
    List<String> list = new List<String>();
    _ingredientsList.forEach((item) {
      if (item.isSelected) list.add(item.ingredientName);
    });
    return list;
  }

  clearSelectedIngredients() {
    List<String> list = new List<String>();
    _ingredientsList.forEach((item) {
      if (item.isSelected) item.isSelected = false;
    });
    return list;
  }

  Future<dynamic> getIngredients() {
    return http.get(
        "https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev/ingredients");
  }

  prepareList(DateTime selectedDate) {
    return ListView.builder(
      itemCount: _ingredientsList.length,
      itemBuilder: (context, index) {
        IngredientsDetails item = _ingredientsList[index];
        return Container(
          color: isExpired(selectedDate, item.ingredientExpireDate)
              ? Colors.grey[300]
              : item.isSelected ? Colors.blue[100] : Colors.white,
          child: ListTile(
            title: Text(item.ingredientName),
            subtitle: Text(
              "Use by: " +
                  new DateFormat.yMMMd().format(item.ingredientExpireDate),
              style: TextStyle(fontSize: 10),
            ),
            onTap: () {
              if (isExpired(selectedDate, item.ingredientExpireDate)) return;
              _onSelected(index);
            },
          ),
        );
      },
    );
  }

  _onSelected(int index) {
    setState(() {
      _ingredientsList[index].isSelected = !_ingredientsList[index].isSelected;
    });
  }

  bool isExpired(DateTime selectedDate, DateTime expiryDate) {
    return selectedDate.difference(expiryDate).inDays >= 0;
  }
}

class IngredientsScreenArgs {
  DateTime selectedDate;

  IngredientsScreenArgs(this.selectedDate);
}
