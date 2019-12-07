class RecipeModel {
  String title;
  List<dynamic> ingredients;

  RecipeModel();

  factory RecipeModel.fromJson(Map model) {
    RecipeModel details = new RecipeModel();
    details.title = model['title'];
    details.ingredients = model['ingredients'];
    return details;
  }
}
