import 'dart:convert';

import 'package:assignment/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecipeList extends StatefulWidget {
  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    final RecipeListArgs args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe List"),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getReciepList(args),
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
            final recipeDetails = json.decode(projectSnap.data.body) as List;
            final itemList =
                recipeDetails.map((i) => new RecipeModel.fromJson(i)).toList();
            return ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                RecipeModel item = itemList[index];
                return ExpansionTile(
                  title: Text(item.title),
                  //subtitle: Text("Click to see Ingredients",style: TextStyle(fontSize: 10),),
                  children: item.ingredients
                      .map((data) => ListTile(
                            leading: Icon(Icons.keyboard_arrow_right),
                            title: Text(
                              data,
                              style: TextStyle(fontSize: 12),
                            ),
                          ))
                      .toList(),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> getReciepList(RecipeListArgs args) {
    String arguments = args.ingredientsList.join(', ');
    return http.get(
        "https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev/recipes?ingredients=" +
            arguments);
  }
}

class RecipeListArgs {
  List<String> ingredientsList;

  RecipeListArgs(this.ingredientsList);
}
