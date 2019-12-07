class IngredientsDetails{
  String ingredientName;
  String lastdate;
  bool isSelected = false;

  IngredientsDetails() ;

  factory IngredientsDetails.fromJson(Map model) {
    IngredientsDetails details = new IngredientsDetails();
    details.ingredientName = model['title'];
    details.lastdate = model['use-by'];
    return details;
  }
}