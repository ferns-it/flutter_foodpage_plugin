enum APIResponseStatus { initial, loading, completed, error }

enum AddDishSideSheetType { variation, availability, category, menu, meal }

enum CategoryType { parent, child }

enum APIResultType { failed, success }

enum DishVariationType { single, multiple, meal }

enum DevelopmentMode {
  release,
  development;

  static DevelopmentMode fromName(String name) {
    return DevelopmentMode.values.firstWhere((e) => e.name == name);
  }
}

enum ResponseResult {
  success,
  pending,
  failure;
}
