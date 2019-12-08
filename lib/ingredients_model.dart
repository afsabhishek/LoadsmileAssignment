class IngredientsDetails {
  String ingredientName;
  String lastdate;
  bool isSelected = false;
  DateTime get ingredientExpireDate {
    return DateTime.parse(lastdate);
  }

  IngredientsDetails();

  factory IngredientsDetails.fromJson(Map model) {
    IngredientsDetails details = new IngredientsDetails();
    details.ingredientName = model['title'];
    details.lastdate = model['use-by'];
    return details;
  }
}
