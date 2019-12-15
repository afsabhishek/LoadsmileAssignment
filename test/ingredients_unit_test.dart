import 'package:assignment/ingredients_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:assignment/screens/ingredients_screen.dart';

void main() {
  List<IngredientsDetails> _ingredientDetailsList;

  String jsonText = '[' +
      '{' +
      '"title": "Ham",' +
      'use-by": "2019-11-25"' +
      '},'
          '{' +
      '"title": "Cheese",' +
      '"use-by": "2019-11-08"' +
      '},' +
      '{' +
      '"title": "Bread",' +
      '"use-by": "2019-11-01"' +
      '}]';

  setUp(() {
    _ingredientDetailsList = new List<IngredientsDetails>();
  });
  
  group("Ingredient list creation test", () {
      test('Create Ingredient', (){

      });
  });
}