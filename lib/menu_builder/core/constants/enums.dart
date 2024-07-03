enum APIResponseStatus { initial, loading, completed, error }

enum AddDishSideSheetType { variation, availability, category, menu }

enum CategoryType { parent, child }

enum APIResultType { failed, success }

enum DevelopmentMode {
  release,
  development;

  static DevelopmentMode fromName(String name) {
    return DevelopmentMode.values.firstWhere((e) => e.name == name);
  }
}
