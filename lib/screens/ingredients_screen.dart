import 'dart:convert';

import 'package:assignment/ingredients_model.dart';
import 'package:assignment/screens/reciep_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IngredientsPage extends StatefulWidget {
  @override
  _IngredientsPageState createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  List<IngredientsDetails> _ingredientsList = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose date"),
      ),
      body: SafeArea(
          child:
              _ingredientsList == null ? _getIngredientsList() : prepareList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/recipelist',
              arguments: RecipeListArgs(getSelectedIngredients()));
        },
        child: Icon(Icons.arrow_forward_ios),
        backgroundColor: Colors.green,
      ),
    );
  }

  _getIngredientsList() {
    return FutureBuilder(
      future: getIngredients(),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none ||
            projectSnap.connectionState == ConnectionState.waiting ||
            projectSnap.hasData == null) {
          return Container(
            child: Text("Loading"),
          );
        }
        final ingredientDetails = json.decode(projectSnap.data.body) as List;
        final items = (ingredientDetails as List)
            .map((i) => new IngredientsDetails.fromJson(i))
            .toList();
        _ingredientsList = items.toList();
        return prepareList();
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

  Future<dynamic> getIngredients() {
    return http.get(
        "https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev/ingredients");
  }

  prepareList() {
    return ListView.builder(
      itemCount: _ingredientsList.length,
      itemBuilder: (context, index) {
        IngredientsDetails item = _ingredientsList[index];
        return CheckboxListTile(
          title: Text(item.ingredientName),
          subtitle: Text(item.lastdate),
          value: item.isSelected,
          onChanged: (bool value) {
            if (item.isSelected == value) {
              return;
            }
            setState(() {
              _ingredientsList[index].isSelected = value;
            });
          },
        );
      },
    );
  }
}
